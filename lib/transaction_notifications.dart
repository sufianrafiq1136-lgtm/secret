import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_profile.dart';

const String kTransactionNotificationChannelId = 'transaction_alerts';
const String kTransactionNotificationChannelName = 'Transaction alerts';
const String _maskedAccountPrefix = '*******';

/// Keeps only the last four characters visible without leaking account length.
String maskAccountNumber(String value) {
  final compact = value.replaceAll(RegExp(r'\s+'), '');
  if (compact.isEmpty || compact.toLowerCase() == 'notset') {
    return _maskedAccountPrefix;
  }
  final visible = compact.length <= 4
      ? compact
      : compact.substring(compact.length - 4);
  return '$_maskedAccountPrefix$visible';
}

String paymentRailForBankName(String bankName) {
  final normalized = bankName.trim().toLowerCase();
  if (normalized.contains('raast')) return 'Raast Payment';
  if (normalized.contains('easypaisa')) return 'Easypaisa Transfer';
  return 'Bank Transfer';
}

String formatTransactionNotificationDate(DateTime value) {
  final local = value.toLocal();
  String two(int part) => part.toString().padLeft(2, '0');
  String three(int part) => part.toString().padLeft(3, '0');
  return '${local.year}-${two(local.month)}-${two(local.day)} at '
      '${two(local.hour)}:${two(local.minute)}:${two(local.second)}.${three(local.millisecond)}';
}

String formatTransactionNotificationBody({
  required String ownerName,
  required double amount,
  required String receiverName,
  required String receiverMaskedAccount,
  required String paymentRail,
  required String ownerMaskedAccount,
  required DateTime completedAt,
  required String transactionId,
}) {
  return 'Dear $ownerName, An amount of Rs. ${amount.toStringAsFixed(2)} has '
      'been successfully sent to $receiverName in $receiverMaskedAccount via '
      '$paymentRail from your Easypaisa account $ownerMaskedAccount on '
      '${formatTransactionNotificationDate(completedAt)}. Trx ID: $transactionId.';
}

class TransactionNotificationRecord {
  const TransactionNotificationRecord({
    required this.id,
    required this.transactionId,
    required this.title,
    required this.body,
    required this.amount,
    required this.receiverName,
    required this.receiverMaskedAccount,
    required this.paymentRail,
    required this.createdAt,
    required this.readAt,
  });

  final String id;
  final String transactionId;
  final String title;
  final String body;
  final double amount;
  final String receiverName;
  final String receiverMaskedAccount;
  final String paymentRail;
  final DateTime? createdAt;
  final DateTime? readAt;

  bool get isUnread => readAt == null;

  factory TransactionNotificationRecord.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data();
    return TransactionNotificationRecord(
      id: document.id,
      transactionId: (data['transactionId'] as String?) ?? document.id,
      title: (data['title'] as String?) ?? 'Transaction Successful',
      body: (data['body'] as String?) ?? '',
      amount: (data['amount'] as num?)?.toDouble() ?? 0,
      receiverName: (data['receiverName'] as String?) ?? '',
      receiverMaskedAccount:
          (data['receiverMaskedAccount'] as String?) ?? _maskedAccountPrefix,
      paymentRail: (data['paymentRail'] as String?) ?? 'Payment',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      readAt: (data['readAt'] as Timestamp?)?.toDate(),
    );
  }
}

class TransactionNotificationService {
  TransactionNotificationService._();

  static final instance = TransactionNotificationService._();

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();
  final StreamController<String> _openController =
      StreamController<String>.broadcast();
  bool _initialized = false;
  String? _pendingNotificationId;

  Stream<String> get notificationOpens => _openController.stream;
  String? get pendingNotificationId => _pendingNotificationId;

  Future<void> initialize() async {
    if (_initialized || kIsWeb || Firebase.apps.isEmpty) return;
    _initialized = true;
    await _initializeLocalNotifications();

    FirebaseMessaging.onMessage.listen(_showForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleOpenedMessage);
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (_) => requestPermissionAndRegisterDevice(),
    );
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) _handleOpenedMessage(initialMessage);
  }

  Future<void> initializeForBackgroundMessage() async {
    if (kIsWeb) return;
    await _initializeLocalNotifications();
  }

  Future<void> _initializeLocalNotifications() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        final notificationId = response.payload;
        if (notificationId != null && notificationId.isNotEmpty) {
          _emitOpen(notificationId);
        }
      },
    );
    const channel = AndroidNotificationChannel(
      kTransactionNotificationChannelId,
      kTransactionNotificationChannelName,
      description: 'Alerts for completed money transfers.',
      importance: Importance.high,
    );
    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  Future<void> _showForegroundMessage(RemoteMessage message) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    final notificationId = message.data['notificationId'] as String? ?? '';
    final title = message.notification?.title ??
        (message.data['title'] as String?) ??
        'Transaction Successful';
    final body = message.notification?.body ?? (message.data['body'] as String?) ?? '';
    await _localNotifications.show(
      notificationId.hashCode,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          kTransactionNotificationChannelId,
          kTransactionNotificationChannelName,
          channelDescription: 'Alerts for completed money transfers.',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: notificationId,
    );
  }

  Future<void> showLocalTransactionNotification({
    required String notificationId,
    required String ownerName,
    required double amount,
    required String receiverName,
    required String receiverMaskedAccount,
    required String paymentRail,
    required String ownerMaskedAccount,
    required DateTime completedAt,
  }) async {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) return;
    final transactionId = 'TRX-$notificationId';
    final body = formatTransactionNotificationBody(
      ownerName: ownerName,
      amount: amount,
      receiverName: receiverName,
      receiverMaskedAccount: receiverMaskedAccount,
      paymentRail: paymentRail,
      ownerMaskedAccount: ownerMaskedAccount,
      completedAt: completedAt,
      transactionId: transactionId,
    );
    await _localNotifications.show(
      notificationId.hashCode,
      'Transaction Successful',
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          kTransactionNotificationChannelId,
          kTransactionNotificationChannelName,
          channelDescription: 'Alerts for completed money transfers.',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: notificationId,
    );
  }

  void _handleOpenedMessage(RemoteMessage message) {
    final notificationId = message.data['notificationId'] as String?;
    if (notificationId != null && notificationId.isNotEmpty) {
      _emitOpen(notificationId);
    }
  }

  void _emitOpen(String notificationId) {
    _pendingNotificationId = notificationId;
    _openController.add(notificationId);
  }

  void consumePendingNotification(String notificationId) {
    if (_pendingNotificationId == notificationId) {
      _pendingNotificationId = null;
    }
  }

  Future<void> requestPermissionAndRegisterDevice() async {
    if (kIsWeb ||
        defaultTargetPlatform != TargetPlatform.android ||
        Firebase.apps.isEmpty ||
        FirebaseAuth.instance.currentUser == null) {
      return;
    }
    try {
      await _localNotifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.requestNotificationsPermission();

      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.denied) return;
      final accountId = await activeAccountId();
      final token = await FirebaseMessaging.instance.getToken();
      if (accountId == null || token == null || token.isEmpty) return;

      final preferences = await SharedPreferences.getInstance();
      final preferenceKey = 'fcm_token_for_$accountId';
      final previousToken = preferences.getString(preferenceKey);
      final deviceCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(accountId)
          .collection('devices');
      if (previousToken != null && previousToken != token) {
        await deviceCollection.doc(_tokenDocumentId(previousToken)).set({
          'active': false,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }
      await deviceCollection.doc(_tokenDocumentId(token)).set({
        'token': token,
        'platform': 'android',
        'active': true,
        'ownerUid': FirebaseAuth.instance.currentUser!.uid,
        'updatedAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      await preferences.setString(preferenceKey, token);
    } catch (_) {
      // Device registration must never block sign-in or a completed transfer.
    }
  }

  Future<void> deactivateCurrentDevice() async {
    if (kIsWeb || Firebase.apps.isEmpty || FirebaseAuth.instance.currentUser == null) {
      return;
    }
    try {
      final accountId = await activeAccountId();
      if (accountId == null) return;
      final preferences = await SharedPreferences.getInstance();
      final token = preferences.getString('fcm_token_for_$accountId');
      if (token == null || token.isEmpty) return;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(accountId)
          .collection('devices')
          .doc(_tokenDocumentId(token))
          .set({
        'active': false,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Logout should still succeed when the device record cannot sync.
    }
  }

  String _tokenDocumentId(String token) => base64Url.encode(utf8.encode(token));
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) await Firebase.initializeApp();
  await TransactionNotificationService.instance.initializeForBackgroundMessage();
}

class NotificationInboxScreen extends StatefulWidget {
  const NotificationInboxScreen({super.key, this.initialNotificationId});

  final String? initialNotificationId;

  @override
  State<NotificationInboxScreen> createState() => _NotificationInboxScreenState();
}

class _NotificationInboxScreenState extends State<NotificationInboxScreen> {
  bool _openedInitialNotification = false;

  Future<void> _openDetail(TransactionNotificationRecord record) async {
    if (record.isUnread) {
      final accountId = await activeAccountId();
      if (accountId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(accountId)
            .collection('notifications')
            .doc(record.id)
            .update({'readAt': FieldValue.serverTimestamp()});
      }
    }
    if (!mounted) return;
    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NotificationDetailScreen(notification: record),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: FutureBuilder<String?>(
        future: activeAccountId(),
        builder: (context, accountSnapshot) {
          if (accountSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final accountId = accountSnapshot.data;
          if (accountId == null) {
            return const _NotificationEmptyState(
              icon: Icons.lock_outline_rounded,
              title: 'Sign in to view notifications',
              subtitle: 'Transaction alerts are available after sign-in.',
            );
          }
          return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(accountId)
                .collection('notifications')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const _NotificationEmptyState(
                  icon: Icons.error_outline_rounded,
                  title: 'Unable to load notifications',
                  subtitle: 'Please check your connection and try again.',
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final notifications = (snapshot.data?.docs ?? const [])
                  .map(TransactionNotificationRecord.fromFirestore)
                  .toList();
              if (notifications.isEmpty) {
                return const _NotificationEmptyState(
                  icon: Icons.notifications_none_rounded,
                  title: 'No notifications yet',
                  subtitle: 'Completed transfers will appear here.',
                );
              }
              final initialId = widget.initialNotificationId;
              if (!_openedInitialNotification && initialId != null) {
                final initial = notifications.where((item) => item.id == initialId);
                if (initial.isNotEmpty) {
                  _openedInitialNotification = true;
                  WidgetsBinding.instance.addPostFrameCallback(
                    (_) => _openDetail(initial.first),
                  );
                }
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: notifications.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return _NotificationListItem(
                    notification: notification,
                    onTap: () => _openDetail(notification),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class NotificationDetailScreen extends StatelessWidget {
  const NotificationDetailScreen({super.key, required this.notification});

  final TransactionNotificationRecord notification;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction notification')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_rounded, color: Color(0xFF12C36A), size: 44),
            const SizedBox(height: 18),
            Text(
              notification.title,
              style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            Text(
              notification.body,
              style: const TextStyle(fontSize: 17, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationListItem extends StatelessWidget {
  const _NotificationListItem({required this.notification, required this.onTap});

  final TransactionNotificationRecord notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: notification.isUnread ? const Color(0xFFF0FAF4) : Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE0E2E5)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_balance_wallet_outlined, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: notification.isUnread
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        if (notification.isUnread)
                          const Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Icon(Icons.circle, color: Color(0xFF12C36A), size: 10),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.body,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Color(0xFF66636E), height: 1.25),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NotificationEmptyState extends StatelessWidget {
  const _NotificationEmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: const Color(0xFF77737F)),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF77737F)),
            ),
          ],
        ),
      ),
    );
  }
}
