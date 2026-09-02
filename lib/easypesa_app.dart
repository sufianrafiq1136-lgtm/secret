import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cross_file/cross_file.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gal/gal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'user_profile.dart';

class AppColors {
  static const background = Color(0xFFF6F6F7);
  static const surface = Colors.white;
  static const surfaceSoft = Color(0xFFF9FAFB);
  static const textPrimary = Color(0xFF3C3850);
  static const textSecondary = Color(0xFF8B8795);
  static const textMuted = Color(0xFFB9B8C0);
  static const brandGreen = Color(0xFF12C36A);
  static const brandGreenDark = Color(0xFF0A8B60);
  static const tealCard = Color(0xFF0A7666);
  static const tealCardDark = Color(0xFF006B5D);
  static const mint = Color(0xFFBBEEC4);
  static const mint2 = Color(0xFFD8F0B0);
  static const yellow = Color(0xFFE8E596);
  static const divider = Color(0xFFE7E7EA);
  static const shadow = Color(0x14000000);
  static const successBlue = Color(0xFFE2F2FF);
  static const successBlueText = Color(0xFF3E465B);
  static const danger = Color(0xFFE63B3B);
  static const warning = Color(0xFFF4C542);
}

class AppAssets {
  static const digitalBankLogo = 'assets/logos/Header digital bank logo .png';
  static const easypaisaLogo = 'assets/logos/easypaisa_logo.png';
  static const easypaisaWordmark = 'assets/logos/easypaisa_wordmark.png';
  static const easypaisaJpg = 'assets/logos/easypaisa.jpg';
  static const jazzCashBankLogo = 'assets/icons/jazzCash bank logo.jpg';
  static const easypisaBankLogo = 'assets/icons/easypisa bank logo.jpg';
  static const profileAvatar = 'assets/images/profile_avatar.png';
  static const elloProfile = 'assets/icons/ello profile picture.jpg';
  static const walletHero = 'assets/icons/Wallet icon.jpg';
  static const borrowHero = 'assets/icons/borrow icon.jpg';
  static const cardsHero = 'assets/icons/cards icon.jpg';
  static const jazzCash = 'assets/brands/jazzcash.png';
  static const easypaisaWallet = 'assets/brands/easypaisa_wallet.png';
  static const moneyBag = 'assets/icons/money_bag.jpg';
  static const sendMoney = 'assets/icons/Send Money icon.png';
  static const billPayment = 'assets/icons/Bill Payment.png';
  static const mobilePackages = 'assets/icons/Mobile Packages .png';
  static const easypaisaTransfer = 'assets/icons/easy paisa trasfer.png';
  static const bankTransfer = 'assets/icons/Bank trasfer.png';
  static const cnicTransfer = 'assets/icons/CNIC Tranfer.png';
  static const raast = 'assets/icons/Raast transfer.png';
  static const wallet = 'assets/icons/wallet.png';
  static const otherWallets = 'assets/icons/Other wallets.png';
  static const scanQr = 'assets/icons/Scan QR.png';
  static const quickCard = 'assets/icons/quick_card.png';
  static const onlineCard = 'assets/icons/online_card.png';
  static const plasticCard = 'assets/icons/plastic_card.png';
  static const walletIcon = 'assets/icons/wallet_icon.png';
  static const easyload = 'assets/icons/Easyload.png';
  static const easycashLoan = 'assets/icons/Easycash Loan.png';
  static const savingsPocket = 'assets/icons/Savings Pocket.png';
  static const inviteAndEarn = 'assets/icons/Invite & Earn.png';
  static const donations = 'assets/icons/Donations.png';
  static const termDeposit = 'assets/icons/Term Deposit.png';
  static const dailyRewards = 'assets/icons/Daily Rewards.png';
  static const buyNowPayLater = 'assets/icons/Buy Now Pay Later.png';
  static const insuranceMarketplace = 'assets/icons/Insurance Marketplace.png';
  static const mTag = 'assets/icons/M-Tag.png';
  static const rsOneGame = 'assets/icons/Rs .1 Game.png';
  static const loadingIcon = 'assets/icons/loadeing icon.jpg';
  static const authLockLogo =
      'assets/logos/authentication logo.jpg';
  static const abhiMicrofinanceBank =
      'assets/logos/abhli micro finance bank.png';
  static const alBarakaIslamicBank = 'assets/logos/Al Baraka islami Bank.jpg';
  static const alfaPay = 'assets/logos/Alfhpla pay.png';
  static const alliedBank = 'assets/logos/allied bank limited logo.jpg';
  static const apnaMicrofinanceBank = 'assets/logos/Apna microfinance bank.jpg';
  static const askariBank = 'assets/logos/Askri bank limited.png';
  static const bankAlHabib = 'assets/logos/Bank Al Habib.jpg';
  static const bankIslami = 'assets/logos/Bank al islami.png';
  static const bankAlfalah = 'assets/logos/Bank Alflah.png';
  static const uMicrofinanceBank = 'assets/logos/u bank.jpg';
  static const habibBank = 'assets/logos/HBL.png';
  static const habibMetropolitanBank =
      'assets/logos/habib metropolin limited.jpg';
  static const mcbBank = 'assets/logos/MCB_Bank_Limited_logo.jpg';
  static const mcbIslamicBank = 'assets/logos/mcb islamic bank.png';
  static const meezanBank = 'assets/logos/Meezan bank.png';
  static const unitedBank = 'assets/logos/ubl digital.png';
  static const nationalBank = 'assets/logos/NBP-Logo.png';
  static const jsBank = 'assets/logos/js bank.png';
  static const sadapay = 'assets/logos/sadapay.webp';
  static const nayapay = 'assets/logos/nayapay.jpg';
  static const raastId = 'assets/logos/raast id.png';
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.profile,
    required this.size,
    this.fallbackBackgroundColor = const Color(0xFFD9EDE3),
    this.fallbackIconColor = Colors.white,
  });

  final UserProfileData? profile;
  final double size;
  final Color fallbackBackgroundColor;
  final Color fallbackIconColor;

  @override
  Widget build(BuildContext context) {
    final photoBytes = profile?.photoBytes;
    final fallbackLetter = _singleLetterFor(profile?.displayName ?? '');
    return ClipOval(
      child: SizedBox(
        width: size,
        height: size,
        child: photoBytes != null
            ? Image.memory(photoBytes, fit: BoxFit.cover)
            : Container(
                color: fallbackBackgroundColor,
                alignment: Alignment.center,
                child: Text(
                  fallbackLetter,
                  style: TextStyle(
                    color: fallbackIconColor,
                    fontWeight: FontWeight.w700,
                    fontSize: size * 0.38,
                  ),
                ),
              ),
      ),
    );
  }
}

String _singleLetterFor(String input) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) return 'U';
  return trimmed.substring(0, 1).toUpperCase();
}

String formatRs(double value) => value.toStringAsFixed(2);

String initialsFor(String input) {
  final parts = input.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) return '?';
  if (parts.length == 1) {
    final word = parts.first;
    return word.isEmpty ? '?' : word.substring(0, 1).toUpperCase();
  }
  return (parts.first[0] + parts.last[0]).toUpperCase();
}

class AppScale {
  static const double factor = 0.75;

  static double v(num value) => value.toDouble() * factor;
}

extension AppScaleNum on num {
  double get ui => toDouble() * AppScale.factor;
}

/// Additional sizing used only by the home screen.
class HomeScale {
  static const double factor = 1.08;
}

class BankOption {
  const BankOption({
    required this.name,
    required this.asset,
    required this.fallbackColor,
  });

  final String name;
  final String asset;
  final Color fallbackColor;
}

class FavoriteRecipient {
  const FavoriteRecipient({
    required this.recipientName,
    required this.accountNumber,
    required this.bankName,
    required this.logoAsset,
    required this.savedAtMs,
  });

  final String recipientName;
  final String accountNumber;
  final String bankName;
  final String logoAsset;
  final int savedAtMs;

  String get id => '${bankName.toLowerCase()}|$accountNumber';

  Map<String, dynamic> toJson() => {
    'recipientName': recipientName,
    'accountNumber': accountNumber,
    'bankName': bankName,
    'logoAsset': logoAsset,
    'savedAtMs': savedAtMs,
  };

  factory FavoriteRecipient.fromJson(Map<String, dynamic> json) {
    return FavoriteRecipient(
      recipientName: (json['recipientName'] as String?) ?? '',
      accountNumber: (json['accountNumber'] as String?) ?? '',
      bankName: (json['bankName'] as String?) ?? '',
      logoAsset: (json['logoAsset'] as String?) ?? '',
      savedAtMs: (json['savedAtMs'] as num?)?.toInt() ?? 0,
    );
  }
}

class FavoriteRecipientsStore {
  static const _prefsKey = 'favorite_recipients_v1';

  static Future<List<FavoriteRecipient>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null || raw.isEmpty) return const [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      final parsed = decoded
          .whereType<Map>()
          .map(
            (entry) => FavoriteRecipient.fromJson(
              Map<String, dynamic>.from(entry),
            ),
          )
          .where(
            (item) =>
                item.recipientName.trim().isNotEmpty &&
                item.accountNumber.trim().isNotEmpty &&
                item.bankName.trim().isNotEmpty,
          )
          .toList();
      parsed.sort((a, b) => b.savedAtMs.compareTo(a.savedAtMs));
      return parsed;
    } catch (_) {
      return const [];
    }
  }

  static Future<void> upsert(FavoriteRecipient recipient) async {
    final prefs = await SharedPreferences.getInstance();
    final current = await load();
    final next = [
      recipient,
      ...current.where((item) => item.id != recipient.id),
    ];
    final serialized = jsonEncode(next.take(20).map((item) => item.toJson()).toList());
    await prefs.setString(_prefsKey, serialized);

    final favoritesCollection = await accountCollection('favorites');
    if (favoritesCollection == null) return;
    await favoritesCollection.doc(recipient.id).set({
      'recipientName': recipient.recipientName,
      'accountNumber': recipient.accountNumber,
      'bankName': recipient.bankName,
      'logoAsset': recipient.logoAsset,
      'savedAtMs': recipient.savedAtMs,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  static Future<bool> contains({
    required String bankName,
    required String accountNumber,
  }) async {
    final current = await load();
    final normalizedBank = bankName.toLowerCase();
    return current.any(
      (item) =>
          item.bankName.toLowerCase() == normalizedBank &&
          item.accountNumber == accountNumber,
    );
  }

  static Future<void> syncFromFirestore() async {
    final favoritesCollection = await accountCollection('favorites');
    if (favoritesCollection == null) return;
    final snapshot = await favoritesCollection.get();
    if (snapshot.docs.isEmpty) return;
    final favorites = snapshot.docs
        .map(
          (doc) => FavoriteRecipient(
            recipientName: (doc.data()['recipientName'] as String?) ?? '',
            accountNumber: (doc.data()['accountNumber'] as String?) ?? '',
            bankName: (doc.data()['bankName'] as String?) ?? '',
            logoAsset: (doc.data()['logoAsset'] as String?) ?? '',
            savedAtMs: (doc.data()['savedAtMs'] as num?)?.toInt() ??
                DateTime.now().millisecondsSinceEpoch,
          ),
        )
        .where(
          (item) =>
              item.recipientName.trim().isNotEmpty &&
              item.accountNumber.trim().isNotEmpty &&
              item.bankName.trim().isNotEmpty,
        )
        .toList()
      ..sort((a, b) => b.savedAtMs.compareTo(a.savedAtMs));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _prefsKey,
      jsonEncode(favorites.take(20).map((item) => item.toJson()).toList()),
    );
  }
}

class TransactionRecord {
  const TransactionRecord({
    required this.id,
    required this.title,
    required this.time,
    required this.amount,
    required this.isCredit,
    required this.dateLabel,
    required this.timestamp,
    required this.recipientName,
    required this.recipientAccount,
    required this.bankName,
    required this.iban,
    required this.fee,
    required this.status,
    this.showRepeat = false,
  });

  final String id;
  final String title;
  final String time;
  final double amount;
  final bool isCredit;
  final String dateLabel;
  final DateTime timestamp;
  final String recipientName;
  final String recipientAccount;
  final String bankName;
  final String iban;
  final double fee;
  final String status;
  final bool showRepeat;

  factory TransactionRecord.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    final timestamp = (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();
    return TransactionRecord(
      id: doc.id,
      title: (data['title'] as String?) ??
          'Money Transfer via Raast - ${(data['recipientName'] as String?) ?? ''}',
      time: _formatDisplayTime(timestamp),
      amount: (data['amount'] as num?)?.toDouble() ?? 0,
      isCredit: (data['type'] as String?) == 'credit',
      dateLabel: _formatDateLabel(timestamp),
      timestamp: timestamp,
      recipientName: (data['recipientName'] as String?) ?? '',
      recipientAccount: (data['recipientAccount'] as String?) ?? '',
      bankName: (data['bankName'] as String?) ?? 'Bank transfer',
      iban: (data['iban'] as String?) ?? '',
      fee: (data['fee'] as num?)?.toDouble() ?? 0,
      status: (data['status'] as String?) ?? 'success',
    );
  }
}

String _formatDisplayTime(DateTime value) {
  final hour = value.hour == 0
      ? 12
      : value.hour > 12
          ? value.hour - 12
          : value.hour;
  final minute = value.minute.toString().padLeft(2, '0');
  final suffix = value.hour >= 12 ? 'PM' : 'AM';
  return '$hour:$minute $suffix';
}

String _formatDateLabel(DateTime value) {
  const months = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  return '${value.day} ${months[value.month - 1]} ${value.year}';
}

class EasyPesaApp extends StatelessWidget {
  const EasyPesaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EasyPesa',
        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: const TextScaler.linear(AppScale.factor),
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: AppColors.background,
          fontFamily: 'Roboto',
          visualDensity: VisualDensity.compact,
          iconTheme: IconThemeData(
            color: AppColors.textPrimary,
            size: AppScale.v(22),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.brandGreen),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: AppColors.textPrimary,
              size: AppScale.v(22),
            ),
            titleTextStyle: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppScale.v(22),
              fontWeight: FontWeight.w600,
            ),
          ),
          textTheme: Typography.blackMountainView.apply(
            bodyColor: AppColors.textPrimary,
            displayColor: AppColors.textPrimary,
          ),
          cardTheme: const CardThemeData(
            color: Colors.white,
            surfaceTintColor: Colors.white,
          ),
        ),
        home: const AppShell(),
      ),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

enum _AuthPromptMode { credentials, pin }

class _AppShellState extends State<AppShell> with WidgetsBindingObserver {
  int _pageIndex = 0;
  bool _isUnlocked = false;
  bool _loadingAuthState = true;
  bool _authDialogOpen = false;
  _AuthPromptMode _authPromptMode = _AuthPromptMode.credentials;
  String? _rememberedEmail;
  Timer? _lockTimer;
  Timer? _deviceSessionTimer;
  DateTime? _lastUnlockAt;
  bool _isAdmin = false;

  static const _storedEmailKey = 'remembered_auth_email';
  static const _lastUnlockKey = 'last_unlock_at_ms';
  static const _lockAfter = Duration(minutes: 15);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _restoreAuthState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lockTimer?.cancel();
    _deviceSessionTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _relockIfExpired();
    }
  }

  Future<void> _restoreAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_storedEmailKey)?.trim();
    final lastUnlockMs = prefs.getInt(_lastUnlockKey);
    if (!mounted) return;

    setState(() {
      _rememberedEmail = (email == null || email.isEmpty) ? null : email;
      _lastUnlockAt =
          lastUnlockMs == null ? null : DateTime.fromMillisecondsSinceEpoch(lastUnlockMs);
      _authPromptMode = _rememberedEmail == null
          ? _AuthPromptMode.credentials
          : _AuthPromptMode.pin;
      _isUnlocked = false;
      _loadingAuthState = false;
    });

    _showAuthIfNeeded();
  }

  void _scheduleAutoLock() {
    _lockTimer?.cancel();
    _lockTimer = Timer(_lockAfter, () {
      if (!mounted) return;
      _lock();
    });
  }

  void _startDeviceSessionWatch() {
    _deviceSessionTimer?.cancel();
    _deviceSessionTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkForRemoteLogout();
    });
  }

  Future<void> _checkForRemoteLogout() async {
    if (!_isUnlocked) return;
    final currentUser = Firebase.apps.isNotEmpty ? FirebaseAuth.instance.currentUser : null;
    if (currentUser == null) return;
    final prefs = await SharedPreferences.getInstance();
    final deviceId = prefs.getString('device_session_id')?.trim();
    if (deviceId == null || deviceId.isEmpty) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('device_sessions')
        .doc(deviceId)
        .get();
    final data = snapshot.data();
    final shouldForceLogout =
        data == null || data['logoutRequested'] == true || data['isActive'] == false;
    if (!shouldForceLogout) return;
    if (!mounted) return;
    await FirebaseAuth.instance.signOut();
    _lock();
  }

  Future<void> _saveUnlockTimestamp() async {
    _lastUnlockAt = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastUnlockKey, _lastUnlockAt!.millisecondsSinceEpoch);
  }

  Future<void> _saveRememberedEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storedEmailKey, email);
    if (!mounted) return;
    setState(() => _rememberedEmail = email);
  }

  void _unlock() {
    if (!mounted) return;
    final currentUser = Firebase.apps.isNotEmpty ? FirebaseAuth.instance.currentUser : null;
    final accountIdFuture = Firebase.apps.isNotEmpty ? activeAccountId() : Future<String?>.value(null);
    accountIdFuture.then((accountId) {
      if (!mounted) return;
      setState(() {
        _isUnlocked = true;
        _isAdmin = isAdminEmail(currentUser?.email);
      });
      if (currentUser != null) {
        recordDeviceSession(user: currentUser, accountId: accountId);
      }
    });
    _scheduleAutoLock();
    _startDeviceSessionWatch();
    _saveUnlockTimestamp();
  }

  void _lock() {
    final currentUser = Firebase.apps.isNotEmpty ? FirebaseAuth.instance.currentUser : null;
    if (currentUser != null) {
      clearDeviceSession(user: currentUser);
    }
    _deviceSessionTimer?.cancel();
    if (!mounted) return;
    setState(() {
      _isUnlocked = false;
      _isAdmin = false;
      _authPromptMode = _AuthPromptMode.pin;
    });
    _showAuthIfNeeded();
  }

  void _relockIfExpired() {
    final lastUnlock = _lastUnlockAt;
    if (_isUnlocked &&
        lastUnlock != null &&
        DateTime.now().difference(lastUnlock) >= _lockAfter) {
      _lock();
    }
  }

  void _showAuthIfNeeded() {
    if (_authDialogOpen || _isUnlocked || _loadingAuthState) return;
    _authDialogOpen = true;
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: AuthScreen(
              mode: _authPromptMode,
              rememberedEmail: _rememberedEmail,
              onRememberEmail: _saveRememberedEmail,
              onUnlockSuccess: _unlock,
              onRequestClose: () => Navigator.of(dialogContext).pop(),
            ),
          ),
        );
      },
    ).whenComplete(() {
      _authDialogOpen = false;
    });
  }

  void _setNavIndex(int navIndex) {
    if (navIndex == 2) {
      _showQrScanner();
      return;
    }

    setState(() {
      _pageIndex = navIndex > 2 ? navIndex - 1 : navIndex;
    });
  }

  Future<void> _openProfileDrawer() async {
    if (!mounted) return;
    final currentUser = Firebase.apps.isNotEmpty ? FirebaseAuth.instance.currentUser : null;
    if (!_isUnlocked || currentUser == null) {
      _openAuthScreen();
      return;
    }
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Account drawer',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 240),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerLeft,
          child: Material(
            color: Colors.transparent,
            child: FutureBuilder<UserProfileData>(
              future: resolveUserProfile(),
              builder: (context, snapshot) {
                final profile = snapshot.data;
                return _ProfileDrawer(
                  profile: profile,
                  isLoadingProfile: snapshot.connectionState == ConnectionState.waiting,
                  onMyAccount: () {
                    Navigator.of(dialogContext).pop();
                    setState(() => _pageIndex = 3);
                  },
                  onTransactionHistory: () {
                    Navigator.of(dialogContext).pop();
                    setState(() => _pageIndex = 3);
                  },
                  onEditProfile: () async {
                    Navigator.of(dialogContext).pop();
                    await _openProfileEditor();
                  },
                  onAdminPanel: () {
                    Navigator.of(dialogContext).pop();
                    _openAdminPanel();
                  },
                  onLogout: _lock,
                );
              },
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(opacity: curved, child: child),
        );
      },
    );
  }

  Future<void> _showQrScanner() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (dialogContext) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 64,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: AppColors.brandGreen,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandGreen.withValues(alpha: 0.25),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.qr_code_2_rounded,
                    color: Colors.white,
                    size: 54,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'QR Scanner',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                const Text(
                  'This can be wired to the live scanner flow next.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.brandGreen,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text('Close'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openProfileEditor() async {
    if (!mounted) return;
    final profile = await resolveUserProfile();
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return _EditProfileDialog(
          profile: profile,
          onSave: (displayName, phoneNumber, photoBase64) async {
            await saveUserProfile(
              profile: profile,
              displayName: displayName,
              phoneNumber: phoneNumber,
              photoBase64: photoBase64,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Firebase.apps.isNotEmpty ? FirebaseAuth.instance.currentUser : null;

    return FutureBuilder<UserProfileData>(
      future: resolveUserProfile(),
      builder: (context, snapshot) {
        final accountId = currentUser == null ? null : snapshot.data?.accountId;
        final profile = snapshot.data ?? UserProfileData.fallback(currentUser, accountId);

        final pages = <Widget>[
          HomeScreen(
            isSignedIn: _isUnlocked && currentUser != null,
            isAdmin: _isAdmin,
            profile: profile,
            maskedAccountText: '*******1267',
            onSignIn: _openAuthScreen,
            onSendMoney: _openSendMoneyFlow,
            onOpenPlaceholder: _openPlaceholder,
            onOpenMyAccount: () => setState(() => _pageIndex = 3),
            onOpenProfileDrawer: _openProfileDrawer,
            onOpenAdminPanel: _openAdminPanel,
            onLogout: _lock,
          ),
          const CashPointsScreen(),
          const PromotionsScreen(),
          MyAccountScreen(
            profile: profile,
            onBackToHome: () => setState(() => _pageIndex = 0),
            onEditProfile: _openProfileEditor,
          ),
        ];

        return Scaffold(
          body: Stack(
            children: [
              IndexedStack(index: _pageIndex, children: pages),
              if (_loadingAuthState)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Color(0x11000000),
                    child: Center(
                      child: CircularProgressIndicator(color: AppColors.brandGreen),
                    ),
                  ),
                ),
            ],
          ),
          bottomNavigationBar: EasyPesaBottomNav(
            selectedIndex: _pageIndex,
            onTap: _setNavIndex,
          ),
        );
      },
    );
  }

  void _openPlaceholder(String title) {
    showNavigationLoader(context, () {
      Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => ComingSoonScreen(title: title)),
      );
    });
  }

  Future<void> _openAuthScreen() async {
    if (_authDialogOpen) return;
    _authPromptMode =
        _rememberedEmail == null ? _AuthPromptMode.credentials : _AuthPromptMode.pin;
    _showAuthIfNeeded();
  }

  void _openAdminPanel() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const AdminPanelScreen()),
    );
  }

  void _openSendMoneyFlow() {
    final hasFirebaseApp = Firebase.apps.isNotEmpty;
    final currentUser = hasFirebaseApp ? FirebaseAuth.instance.currentUser : null;
    if (!_isUnlocked || currentUser == null) {
      _openAuthScreen();
      return;
    }

    showSendMoneySheet(context);
  }
}

Future<void> showNavigationLoader(
  BuildContext context,
  VoidCallback onComplete,
) async {
  await showDialog<void>(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
    builder: (_) => const _NavigationLoader(),
  );
  if (context.mounted) onComplete();
}

class _NavigationLoader extends StatefulWidget {
  const _NavigationLoader();

  @override
  State<_NavigationLoader> createState() => _NavigationLoaderState();
}

class _NavigationLoaderState extends State<_NavigationLoader>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    )..forward();
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _timer = Timer(const Duration(milliseconds: 1100), () {
      if (mounted) Navigator.of(context).pop();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: FadeTransition(
        opacity: _animationController,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.78,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 14,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.brandGreen,
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Image.asset(
                            AppAssets.loadingIcon,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 22),
                  const Expanded(
                    child: Text(
                      'Loading, please wait.',
                      style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showSendMoneySheet(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    builder: (dialogContext) {
      return Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.92,
          height: MediaQuery.of(context).size.height * 0.374,
          child: SendMoneySheet(
            onEasypaisaTransfer: () {
              Navigator.of(dialogContext).pop();
              showNavigationLoader(context, () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => TransferFormScreen(
                      bankName: 'Easypaisa Bank',
                      logoAsset: AppAssets.easypisaBankLogo,
                    ),
                  ),
                );
              });
            },
            onBankTransfer: () {
              final navigator = Navigator.of(context);
              Navigator.of(dialogContext).pop();
              showNavigationLoader(context, () {
                navigator.push(
                  MaterialPageRoute<void>(
                    builder: (_) => const BankTransferScreen(),
                  ),
                );
              });
            },
            onRaastTransfer: () {
              Navigator.of(dialogContext).pop();
              showNavigationLoader(context, () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => TransferFormScreen(
                      bankName: 'Raast ID',
                      logoAsset: AppAssets.raastId,
                    ),
                  ),
                );
              });
            },
            onOtherWallets: () {
              Navigator.of(dialogContext).pop();
              showNavigationLoader(context, () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const OtherWalletsScreen(),
                  ),
                );
              });
            },
            onPlaceholder: (title) {
              final navigator = Navigator.of(context);
              Navigator.of(dialogContext).pop();
              showNavigationLoader(context, () {
                navigator.push(
                  MaterialPageRoute<void>(
                    builder: (_) => ComingSoonScreen(title: title),
                  ),
                );
              });
            },
          ),
        ),
      );
    },
  );
}

class EasyPesaBottomNav extends StatelessWidget {
  const EasyPesaBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 14,
      shadowColor: Colors.black26,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64.ui,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: [
              Positioned.fill(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: _NavItem(
                        index: 0,
                        selectedIndex: selectedIndex,
                        label: 'Home',
                        icon: Icons.home_rounded,
                        onTap: onTap,
                      ),
                    ),
                    Expanded(
                      child: _NavItem(
                        index: 1,
                        selectedIndex: selectedIndex,
                        label: 'Cash Points',
                        icon: Icons.location_on_outlined,
                        onTap: onTap,
                      ),
                    ),
                    SizedBox(width: 54.ui),
                    Expanded(
                      child: _NavItem(
                        index: 3,
                        selectedIndex: selectedIndex,
                        label: 'Promotions',
                        icon: Icons.campaign_outlined,
                        onTap: onTap,
                      ),
                    ),
                    Expanded(
                      child: _NavItem(
                        index: 4,
                        selectedIndex: selectedIndex,
                        label: 'My Account',
                        icon: Icons.person_outline_rounded,
                        onTap: onTap,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -13.5.ui,
                child: GestureDetector(
                  onTap: () => onTap(2),
                  child: Container(
                    width: 51.ui,
                    height: 51.ui,
                    decoration: BoxDecoration(
                      color: AppColors.brandGreen,
                      borderRadius: BorderRadius.circular(13.5.ui),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.brandGreen.withValues(alpha: 0.45),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.qr_code_2_rounded,
                      color: Colors.white,
                      size: 25.5.ui,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.index,
    required this.selectedIndex,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final int index;
  final int selectedIndex;
  final String label;
  final IconData icon;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final selected = selectedIndex == index;
    final color = selected ? AppColors.brandGreen : const Color(0xFFB7B7BC);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 46.5.ui,
            height: 3.ui,
            decoration: BoxDecoration(
              color: selected ? AppColors.brandGreen : Colors.transparent,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          SizedBox(height: 4.5.ui),
          Icon(icon, color: color, size: 22.5.ui),
          SizedBox(height: 3.75.ui),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: selected ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
          SizedBox(height: 5.25.ui),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.isSignedIn,
    required this.isAdmin,
    required this.profile,
    required this.maskedAccountText,
    required this.onSignIn,
    required this.onSendMoney,
    required this.onOpenPlaceholder,
    required this.onOpenMyAccount,
    required this.onOpenProfileDrawer,
    required this.onOpenAdminPanel,
    required this.onLogout,
  });

  final bool isSignedIn;
  final bool isAdmin;
  final UserProfileData profile;
  final String maskedAccountText;
  final VoidCallback onSignIn;
  final VoidCallback onSendMoney;
  final ValueChanged<String> onOpenPlaceholder;
  final VoidCallback onOpenMyAccount;
  final VoidCallback onOpenProfileDrawer;
  final VoidCallback onOpenAdminPanel;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final homeMediaQuery = MediaQuery.of(context).copyWith(
      textScaler: TextScaler.linear(AppScale.factor * HomeScale.factor),
    );

    return MediaQuery(
      data: homeMediaQuery,
      child: SafeArea(
        top: false,
        bottom: false,
        child: ListView(
          key: const PageStorageKey<String>('home-page'),
          padding: EdgeInsets.only(bottom: 112.ui),
          children: [
            _HomeRefreshHeader(
              isSignedIn: isSignedIn,
              isAdmin: isAdmin,
              profile: profile,
              maskedAccountText: maskedAccountText,
              onSearch: () => onOpenPlaceholder('Search'),
              onNotifications: () => onOpenPlaceholder('Notifications'),
              onLogout: onLogout,
              onSignIn: onSignIn,
              onProfileTap: onOpenProfileDrawer,
              onAdminTap: onOpenAdminPanel,
              onOpenPlaceholder: onOpenPlaceholder,
            ),
            SizedBox(height: 22.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ui),
              child: const Text(
                'More with easypaisa',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.2,
                ),
              ),
            ),
            SizedBox(height: 12.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ui),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14.ui,
                crossAxisSpacing: 14.ui,
                childAspectRatio: 0.94,
                children: [
                  FeatureTile(title: 'Send Money', asset: AppAssets.sendMoney, fallbackIcon: Icons.send_outlined, onTap: onSendMoney),
                  FeatureTile(title: 'Bill Payment', asset: AppAssets.billPayment, fallbackIcon: Icons.receipt_long_outlined, onTap: () => onOpenPlaceholder('Bill Payment')),
                  FeatureTile(title: 'Loads & Packages', asset: AppAssets.mobilePackages, fallbackIcon: Icons.phone_iphone_outlined, onTap: () => onOpenPlaceholder('Mobile Packages')),
                  FeatureTile(title: 'M-Tag', asset: AppAssets.mTag, fallbackIcon: Icons.route_outlined, onTap: () => onOpenPlaceholder('M-Tag')),
                  FeatureTile(title: 'Easycash', asset: AppAssets.easycashLoan, fallbackIcon: Icons.wallet_outlined, onTap: () => onOpenPlaceholder('Easycash Loan')),
                  FeatureTile(title: 'Term Deposit', asset: AppAssets.termDeposit, fallbackIcon: Icons.account_balance_wallet_outlined, onTap: () => onOpenPlaceholder('Term Deposit')),
                  FeatureTile(title: 'Insurance', asset: AppAssets.insuranceMarketplace, fallbackIcon: Icons.umbrella_outlined, onTap: () => onOpenPlaceholder('Insurance Marketplace')),
                  FeatureTile(title: 'Rs. 1 Game', asset: AppAssets.rsOneGame, fallbackIcon: Icons.celebration_outlined, onTap: () => onOpenPlaceholder('Rs.1 Game')),
                  FeatureTile(title: 'See All', asset: AppAssets.quickCard, fallbackIcon: Icons.more_horiz_rounded, onTap: () => onOpenPlaceholder('More services')),
                ],
              ),
            ),
            SizedBox(height: 24.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ui),
              child: const Text('Stories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 24.ui),
          ],
        ),
      ),
    );
  }
}

class _HomeRefreshHeader extends StatefulWidget {
  const _HomeRefreshHeader({
    required this.isSignedIn,
    required this.isAdmin,
    required this.profile,
    required this.maskedAccountText,
    required this.onSearch,
    required this.onNotifications,
    required this.onLogout,
    required this.onSignIn,
    required this.onProfileTap,
    required this.onAdminTap,
    required this.onOpenPlaceholder,
  });

  final bool isSignedIn;
  final bool isAdmin;
  final UserProfileData profile;
  final String maskedAccountText;
  final VoidCallback onSearch;
  final VoidCallback onNotifications;
  final VoidCallback onLogout;
  final VoidCallback onSignIn;
  final VoidCallback onProfileTap;
  final VoidCallback onAdminTap;
  final ValueChanged<String> onOpenPlaceholder;

  @override
  State<_HomeRefreshHeader> createState() => _HomeRefreshHeaderState();
}

class _HomeRefreshHeaderState extends State<_HomeRefreshHeader> {
  late final PageController _controller;
  bool _balanceVisible = true;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.75);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.brandGreen,
        systemNavigationBarColor: AppColors.background,
      ),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            color: AppColors.brandGreen,
          ),
          Container(
            height: 92.ui,
            padding: EdgeInsets.symmetric(horizontal: 16.ui),
            color: AppColors.background,
            child: Row(
              children: [
                GestureDetector(
                  onTap: widget.onProfileTap,
                  child: Container(
                    width: 48.ui,
                    height: 48.ui,
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: ProfileAvatar(
                        profile: widget.profile,
                        size: 44.ui,
                        fallbackBackgroundColor: const Color(0xFFD9EDE3),
                        fallbackIconColor: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 14.ui),
                const Expanded(
                  child: Text(
                    'Hey There 👋',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: widget.onNotifications,
                  icon: const Icon(Icons.notifications_none_rounded),
                  color: AppColors.textPrimary,
                  iconSize: 29.ui,
                  tooltip: 'Notifications',
                ),
                if (widget.isSignedIn)
                  IconButton(
                    onPressed: widget.onLogout,
                    icon: const Icon(Icons.logout_rounded),
                    color: AppColors.danger,
                    iconSize: 27.ui,
                    tooltip: 'Logout',
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.ui, 16.ui, 16.ui, 18.ui),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28.ui),
              child: InkWell(
                onTap: widget.onSearch,
                borderRadius: BorderRadius.circular(28.ui),
                child: Container(
                  height: 58.ui,
                  padding: EdgeInsets.symmetric(horizontal: 12.ui),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28.ui),
                    border: Border.all(color: const Color(0xFFD8D8DA), width: 1.5),
                  ),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          AppAssets.elloProfile,
                          width: 45.ui,
                          height: 45.ui,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 12.ui),
                      const Text(
                        'Search or Ask Ello',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.607,
            child: PageView.builder(
              controller: _controller,
              padEnds: false,
              itemCount: 3,
              itemBuilder: (context, index) {
                final offers = [
                  _HeroOffer(
                    title: 'easypaisa Account',
                    headline: widget.isSignedIn
                        ? (_balanceVisible ? 'Rs. 24,590' : 'Rs. ******')
                        : 'Sign in',
                    subtitle: widget.isSignedIn
                        ? (_balanceVisible
                            ? 'Tap to hide balance'
                            : 'Tap to view balance')
                        : '*******1267',
                    asset: AppAssets.walletHero,
                    colors: const [Color(0xFFB1F8B6), Color(0xFF8BDDB5)],
                    onTap: widget.isSignedIn ? widget.onProfileTap : widget.onSignIn,
                    onToggleBalance: widget.isSignedIn
                        ? () => setState(() => _balanceVisible = !_balanceVisible)
                        : null,
                    balanceVisible: _balanceVisible,
                  ),
                  _HeroOffer(
                    title: 'Borrow Money',
                    headline: 'Get up to Rs. 30,000',
                    subtitle: 'Instant loan, no hassle',
                    asset: AppAssets.borrowHero,
                    colors: const [Color(0xFFFFF0A5), Color(0xFFE8D96B)],
                    onTap: () => widget.onSignIn(),
                  ),
                  _HeroOffer(
                    title: 'Debit & Credit Card',
                    headline: 'Get your Card',
                    subtitle: 'Tap to explore and apply',
                    asset: AppAssets.cardsHero,
                    colors: const [Color(0xFFC8FBDD), Color(0xFF43E79D)],
                    onTap: () => widget.onOpenPlaceholder('Debit & Credit Card'),
                  ),
                ];
                return Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.748,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 4.ui : 0,
                        right: 10.ui,
                      ),
                      child: offers[index],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroOffer extends StatelessWidget {
  const _HeroOffer({
    required this.title,
    required this.headline,
    required this.subtitle,
    required this.asset,
    required this.colors,
    required this.onTap,
    this.onToggleBalance,
    this.balanceVisible = true,
  });

  final String title;
  final String headline;
  final String subtitle;
  final String asset;
  final List<Color> colors;
  final VoidCallback onTap;
  final VoidCallback? onToggleBalance;
  final bool balanceVisible;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(28.ui),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(28.ui),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(24.ui, 20.ui, 20.ui, 18.ui),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(28.ui),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 112.ui,
                child: Image.asset(asset, fit: BoxFit.contain),
              ),
              SizedBox(height: 8.ui),
              Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      headline,
                      style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.ui),
              if (onToggleBalance != null)
                GestureDetector(
                  onTap: onToggleBalance,
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.ui),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 17,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(width: 6.ui),
                        Icon(
                          balanceVisible
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 20.ui,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                )
              else
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 17,
                    color: AppColors.textPrimary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeaderCluster extends StatelessWidget {
  const _HomeHeaderCluster({
    required this.isSignedIn,
    required this.isAdmin,
    required this.profile,
    required this.maskedAccountText,
    required this.onSearch,
    required this.onNotifications,
    required this.onLogout,
    required this.onSignIn,
    required this.onProfileTap,
    required this.onAdminTap,
  });

  final bool isSignedIn;
  final bool isAdmin;
  final UserProfileData profile;
  final String maskedAccountText;
  final VoidCallback onSearch;
  final VoidCallback onNotifications;
  final VoidCallback onLogout;
  final VoidCallback onSignIn;
  final VoidCallback onProfileTap;
  final VoidCallback onAdminTap;

  @override
  Widget build(BuildContext context) {
    const headerBoost = 1.18;
    const heroBoost = 1.1;
    const cardBoost = 1.12;

    final headerHeight = AppScale.v(122) * headerBoost;
    final lowerPanelHeight = AppScale.v(55) * headerBoost;
    final cardTop = AppScale.v(82) * headerBoost;

    return SizedBox(
      height: headerHeight + lowerPanelHeight + AppScale.v(96) * headerBoost,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              _HomeHero(
                height: headerHeight,
                scale: heroBoost,
                profile: profile,
                onSearch: onSearch,
                onNotifications: onNotifications,
                onLogout: onLogout,
                onProfileTap: onProfileTap,
                onAdminTap: onAdminTap,
              ),
              Container(
                height: lowerPanelHeight,
                width: double.infinity,
                decoration: const BoxDecoration(color: Color(0xFFF0FAF0)),
              ),
            ],
          ),
          Positioned(
            left: 14.ui,
            right: 14.ui,
            top: cardTop,
            child: _AccountCard(
              isSignedIn: isSignedIn,
              displayName: profile.displayName,
              maskedAccountText: maskedAccountText,
              onSignIn: onSignIn,
              onTapProfile: onProfileTap,
              scale: cardBoost,
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHero extends StatelessWidget {
  const _HomeHero({
    required this.height,
    required this.scale,
    required this.profile,
    required this.onSearch,
    required this.onNotifications,
    required this.onLogout,
    required this.onProfileTap,
    required this.onAdminTap,
  });

  final double height;
  final double scale;
  final UserProfileData profile;
  final VoidCallback onSearch;
  final VoidCallback onNotifications;
  final VoidCallback onLogout;
  final VoidCallback onProfileTap;
  final VoidCallback onAdminTap;

  @override
  Widget build(BuildContext context) {
    final scale = this.scale;
    return Container(
      height: height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.mint, AppColors.yellow, Color(0xFFA8E5BE)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16.ui,
            left: 16.ui,
            child: GestureDetector(
              onTap: onProfileTap,
              child: Container(
                width: 42.ui * scale * HomeScale.factor,
                height: 42.ui * scale * HomeScale.factor,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.9), width: 2),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: ProfileAvatar(
                    profile: profile,
                    size: 42.ui * scale * HomeScale.factor,
                    fallbackBackgroundColor: const Color(0xFF5B5C69),
                    fallbackIconColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.ui,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                height: 96.ui * scale * HomeScale.factor,
                child: Image.asset(
                  AppAssets.digitalBankLogo,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const _DigitalBankFallback();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 20.ui,
            right: 96.ui,
            child: IconButton(
              onPressed: onSearch,
              icon: Icon(
                Icons.search_rounded,
                color: AppColors.textPrimary,
                size: 27.3.ui * scale * HomeScale.factor,
              ),
            ),
          ),
          Positioned(
            top: 20.ui,
            right: 52.ui,
            child: IconButton(
              onPressed: onNotifications,
              icon: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.textPrimary,
                size: 27.3.ui * scale * HomeScale.factor,
              ),
            ),
          ),
          Positioned(
            top: 20.ui,
            right: 8.ui,
            child: IconButton(
              onPressed: onLogout,
              icon: Icon(
                Icons.logout_rounded,
                color: AppColors.danger,
                size: 27.3.ui * scale * HomeScale.factor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DigitalBankFallback extends StatelessWidget {
  const _DigitalBankFallback();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 39.ui,
          height: 39.ui,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 21.ui,
                height: 21.ui,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.textPrimary,
                    width: 4.5.ui,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                bottom: 6.75.ui,
                child: Container(
                  width: 21.ui,
                  height: 10.5.ui,
                  decoration: const BoxDecoration(
                    color: AppColors.brandGreen,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 6.ui),
        const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'digital',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 0.92,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'bank',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 0.92,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ProfileDrawer extends StatelessWidget {
  const _ProfileDrawer({
    required this.profile,
    required this.isLoadingProfile,
    required this.onMyAccount,
    required this.onTransactionHistory,
    required this.onEditProfile,
    required this.onAdminPanel,
    required this.onLogout,
  });

  final UserProfileData? profile;
  final bool isLoadingProfile;
  final VoidCallback onMyAccount;
  final VoidCallback onTransactionHistory;
  final VoidCallback onEditProfile;
  final VoidCallback onAdminPanel;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.84,
        child: Material(
          color: Colors.white,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(28),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 18, 16, 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Account',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4FBF7),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFDCEFE3)),
                ),
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ProfileAvatar(
                          profile: profile,
                          size: 56,
                          fallbackBackgroundColor: const Color(0xFFD9EDE3),
                          fallbackIconColor: Colors.white,
                        ),
                        if (isLoadingProfile || profile == null)
                          const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.displayName ?? 'Loading...',
                            style: const TextStyle(
                              fontSize: 18,
                              height: 1.1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Profile, Settings & More',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            _DrawerAction(
              icon: Icons.person_outline_rounded,
              label: 'Edit Profile',
              onTap: onEditProfile,
            ),
            _DrawerAction(
              icon: Icons.receipt_long_outlined,
              label: 'Transaction History',
              onTap: onTransactionHistory,
            ),
            if (profile != null && isAdminEmail(profile!.email))
              _DrawerAction(
                icon: Icons.admin_panel_settings_outlined,
                label: 'Admin Panel',
                onTap: onAdminPanel,
              ),
            _DrawerAction(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {},
            ),
            _DrawerAction(
              icon: Icons.help_outline_rounded,
              label: 'Help & Support',
              onTap: () {},
            ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: onLogout,
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: AppColors.danger,
                    ),
                    label: const Text('Logout'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Color(0xFFE7E7EA)),
                      foregroundColor: AppColors.textPrimary,
                      backgroundColor: const Color(0xFFF9F9FA),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerAction extends StatelessWidget {
  const _DrawerAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textPrimary),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Color(0xFFB5B5BB)),
          ],
        ),
      ),
    );
  }
}

class _AccountCard extends StatefulWidget {
  const _AccountCard({
    required this.isSignedIn,
    required this.displayName,
    required this.maskedAccountText,
    required this.onSignIn,
    required this.onTapProfile,
    required this.scale,
  });

  final bool isSignedIn;
  final String displayName;
  final String maskedAccountText;
  final VoidCallback onSignIn;
  final VoidCallback onTapProfile;
  final double scale;

  @override
  State<_AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<_AccountCard> {
  bool _balanceVisible = true;

  void _toggleBalance() => setState(() => _balanceVisible = !_balanceVisible);

  @override
  Widget build(BuildContext context) {
    final scale = widget.scale;
    final isSignedIn = widget.isSignedIn;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isSignedIn ? widget.onTapProfile : widget.onSignIn,
        borderRadius: BorderRadius.circular(18.ui * scale),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.tealCard,
            borderRadius: BorderRadius.circular(18.ui * scale),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(16.ui * scale, 14.ui * scale, 16.ui * scale, 16.ui * scale),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 9.ui * scale, vertical: 6.ui * scale),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6.ui * scale),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'easypaisa Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'My Rewards',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15 * scale,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8.ui * scale),
                      Container(
                        width: 28.ui * scale,
                        height: 28.ui * scale,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFC107),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFE082),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 18.ui * scale),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSignedIn ? 'Available Balance' : widget.displayName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13 * scale,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.ui * scale),
                        Row(
                          children: [
                            Text(
                              isSignedIn
                                  ? (_balanceVisible ? 'Rs. 24,590' : 'Rs. ******')
                                  : widget.maskedAccountText,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 27 * scale,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (isSignedIn) ...[
                              SizedBox(width: 8.ui * scale),
                              GestureDetector(
                                onTap: _toggleBalance,
                                behavior: HitTestBehavior.opaque,
                                child: Icon(
                                  _balanceVisible
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: Colors.white,
                                  size: 23.ui * scale,
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 3.ui * scale),
                        Text(
                          isSignedIn
                              ? (_balanceVisible ? 'Tap to hide balance' : 'Tap to see balance')
                              : 'Sign in to your easypaisa account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12 * scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.ui * scale),
                  Column(
                    children: [
                      SizedBox(
                        width: 110.ui * scale,
                        child: OutlinedButton(
                          onPressed: widget.onSignIn,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: BorderSide(color: AppColors.brandGreen, width: 1.5.ui * scale),
                            minimumSize: Size.fromHeight(30.ui * scale),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.ui * scale),
                            ),
                          ),
                          child: Text(
                            isSignedIn ? 'Upgrade Account' : 'Sign In',
                            style: TextStyle(
                              fontSize: 10.5 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.ui * scale),
                      SizedBox(
                        width: 110.ui * scale,
                        child: FilledButton(
                          onPressed: widget.onSignIn,
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.brandGreen,
                            foregroundColor: Colors.white,
                            minimumSize: Size.fromHeight(30.ui * scale),
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.ui * scale),
                            ),
                          ),
                          child: Text(
                            isSignedIn ? 'Add Cash' : 'Sign In',
                            style: TextStyle(
                              fontSize: 12 * scale,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.title,
    required this.asset,
    required this.fallbackIcon,
    required this.onTap,
  });

  final String title;
  final String asset;
  final IconData fallbackIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18.ui),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(18.ui),
        onTap: onTap,
        child: Container(
          height: 93.ui,
          padding: EdgeInsets.fromLTRB(6.ui, 9.ui, 6.ui, 7.5.ui),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.ui),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: AssetOrIcon(
                    asset: asset,
                    fallbackIcon: fallbackIcon,
                    size: 63.ui * HomeScale.factor,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 4.5.ui),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  height: 1.05,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  const FeatureTile({
    super.key,
    required this.title,
    required this.asset,
    required this.fallbackIcon,
    required this.onTap,
  });

  final String title;
  final String asset;
  final IconData fallbackIcon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.ui),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.ui),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.ui, vertical: 10.ui),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.ui),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AssetOrIcon(
                asset: asset,
                fallbackIcon: fallbackIcon,
                size: 54.ui * HomeScale.factor,
                color: AppColors.textPrimary,
              ),
              SizedBox(height: 4.5.ui),
              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 11,
                  height: 1.05,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF403B4C),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DebitCardTile extends StatelessWidget {
  const DebitCardTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.accentColor,
    required this.asset,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final Color backgroundColor;
  final Color accentColor;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(19.5.ui),
      child: InkWell(
        borderRadius: BorderRadius.circular(19.5.ui),
        onTap: onTap,
        child: Container(
          width: 247.5.ui,
          padding: EdgeInsets.fromLTRB(16.5.ui, 22.5.ui, 16.5.ui, 16.5.ui),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19.5.ui),
            color: backgroundColor,
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      height: 1.05,
                    ),
                  ),
                  SizedBox(height: 10.5.ui),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 18.5,
                      height: 1.15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 4,
                child: AssetOrIcon(
                  asset: asset,
                  fallbackIcon: Icons.credit_card_rounded,
                  size: 57.ui * HomeScale.factor,
                  color: accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssetOrIcon extends StatelessWidget {
  const AssetOrIcon({
    super.key,
    required this.asset,
    required this.fallbackIcon,
    required this.size,
    this.color,
  });

  final String asset;
  final IconData fallbackIcon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(fallbackIcon, size: size, color: color);
      },
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({required this.activeIndex, required this.count});

  final int activeIndex;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final active = index == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(right: index == count - 1 ? 0 : 10),
          width: active ? 12 : 12,
          height: 12,
          decoration: BoxDecoration(
            color: active ? AppColors.brandGreen : const Color(0xFFD8D8D8),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

class SendMoneySheet extends StatelessWidget {
  const SendMoneySheet({
    super.key,
    required this.onEasypaisaTransfer,
    required this.onBankTransfer,
    required this.onRaastTransfer,
    required this.onOtherWallets,
    required this.onPlaceholder,
  });

  final VoidCallback onEasypaisaTransfer;
  final VoidCallback onBankTransfer;
  final VoidCallback onRaastTransfer;
  final VoidCallback onOtherWallets;
  final ValueChanged<String> onPlaceholder;

  @override
  Widget build(BuildContext context) {
    final options = <_SheetOption>[
      _SheetOption(
        'easypaisa\nTransfer',
        AppAssets.easypaisaTransfer,
        Icons.currency_exchange_rounded,
        AppColors.textPrimary,
        onEasypaisaTransfer,
      ),
      _SheetOption(
        'Bank\nTransfer',
        AppAssets.bankTransfer,
        Icons.account_balance_outlined,
        AppColors.textPrimary,
        onBankTransfer,
      ),
      _SheetOption(
        'CNIC\nTransfer',
        AppAssets.cnicTransfer,
        Icons.badge_outlined,
        AppColors.textPrimary,
        () => onPlaceholder('CNIC Transfer'),
      ),
      _SheetOption(
        'Raast\nPayment',
        AppAssets.raast,
        Icons.account_balance_outlined,
        AppColors.textPrimary,
        onRaastTransfer,
      ),
      _SheetOption(
        'Other\nWallets',
        AppAssets.otherWallets,
        Icons.account_balance_wallet_outlined,
        AppColors.textPrimary,
        onOtherWallets,
      ),
      _SheetOption(
        'Scan QR',
        AppAssets.scanQr,
        Icons.qr_code_scanner_rounded,
        AppColors.textPrimary,
        () => onPlaceholder('Scan QR'),
      ),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Send Money To',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 22),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 0.93,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                children: options
                    .map(
                      (option) => _SheetActionCard(
                        title: option.title,
                        asset: option.asset,
                        fallbackIcon: option.fallbackIcon,
                        color: option.color,
                        onTap: option.onTap,
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetOption {
  const _SheetOption(
    this.title,
    this.asset,
    this.fallbackIcon,
    this.color,
    this.onTap,
  );

  final String title;
  final String asset;
  final IconData fallbackIcon;
  final Color color;
  final VoidCallback onTap;
}

class _SheetActionCard extends StatelessWidget {
  const _SheetActionCard({
    required this.title,
    required this.asset,
    required this.fallbackIcon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final String asset;
  final IconData fallbackIcon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.ui),
        side: const BorderSide(color: Color(0xFFE4E4E8)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18.ui),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(7.5.ui, 10.5.ui, 7.5.ui, 9.ui),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: AssetOrIcon(
                    asset: asset,
                    fallbackIcon: fallbackIcon,
                    size: 50.625.ui,
                    color: color,
                  ),
                ),
              ),
              SizedBox(height: 4.5.ui),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  height: 1.0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BankTransferScreen extends StatefulWidget {
  const BankTransferScreen({
    super.key,
    this.initialSearchQuery,
    this.initialHighlightedBankName,
  });

  final String? initialSearchQuery;
  final String? initialHighlightedBankName;

  @override
  State<BankTransferScreen> createState() => _BankTransferScreenState();
}

class _BankTransferScreenState extends State<BankTransferScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late final TabController _tabController;
  List<FavoriteRecipient> _favoriteRecipients = const [];

  final List<BankOption> _banks = const [
    BankOption(
      name: 'JazzCash',
      asset: AppAssets.jazzCashBankLogo,
      fallbackColor: AppColors.brandGreen,
    ),
    BankOption(
      name: 'Easypaisa  Bank',
      asset: AppAssets.easypisaBankLogo,
      fallbackColor: AppColors.brandGreen,
    ),
    BankOption(
      name: 'ABHI Microfinance Bank',
      asset: AppAssets.abhiMicrofinanceBank,
      fallbackColor: Color(0xFF273A53),
    ),
    BankOption(
      name: 'Al Baraka Islamic Bank Limited',
      asset: AppAssets.alBarakaIslamicBank,
      fallbackColor: Color(0xFFEF4C6F),
    ),
    BankOption(
      name: 'Alfa Pay',
      asset: AppAssets.alfaPay,
      fallbackColor: Color(0xFFE8492E),
    ),
    BankOption(
      name: 'Allied Bank Limited',
      asset: AppAssets.alliedBank,
      fallbackColor: Color(0xFF3474C6),
    ),
    BankOption(
      name: 'Apna Microfinance Bank',
      asset: AppAssets.apnaMicrofinanceBank,
      fallbackColor: Color(0xFF7DAD2C),
    ),
    BankOption(
      name: 'Askari Commercial Bank Limited',
      asset: AppAssets.askariBank,
      fallbackColor: Color(0xFF2C8BC8),
    ),
    BankOption(
      name: 'Bank Al Habib Limited',
      asset: AppAssets.bankAlHabib,
      fallbackColor: Color(0xFF20794F),
    ),
    BankOption(
      name: 'Bank Alfalah',
      asset: AppAssets.bankAlfalah,
      fallbackColor: Color(0xFFF3683B),
    ),
    BankOption(
      name: 'BankIslami',
      asset: AppAssets.bankIslami,
      fallbackColor: Color(0xFF0D7F4F),
    ),
    BankOption(
      name: 'U Microfinance Bank',
      asset: AppAssets.uMicrofinanceBank,
      fallbackColor: Color(0xFF1D6C91),
    ),
    BankOption(
      name: 'Habib Bank Limited (HBL)',
      asset: AppAssets.habibBank,
      fallbackColor: Color(0xFF0A5B9A),
    ),
    BankOption(
      name: 'Habib Metropolitan Bank Limited',
      asset: AppAssets.habibMetropolitanBank,
      fallbackColor: Color(0xFF1E3A8A),
    ),
    BankOption(
      name: 'MCB Bank Limited',
      asset: AppAssets.mcbBank,
      fallbackColor: Color(0xFF00529B),
    ),
    BankOption(
      name: 'MCB Islamic Bank Limited',
      asset: AppAssets.mcbIslamicBank,
      fallbackColor: Color(0xFF008B62),
    ),
    BankOption(
      name: 'Meezan Bank Limited',
      asset: AppAssets.meezanBank,
      fallbackColor: Color(0xFF008B62),
    ),
    BankOption(
      name: 'United Bank Limited (UBL)',
      asset: AppAssets.unitedBank,
      fallbackColor: Color(0xFF008A5B),
    ),
    BankOption(
      name: 'National Bank of Pakistan (NBP)',
      asset: AppAssets.nationalBank,
      fallbackColor: Color(0xFF005B4F),
    ),
    BankOption(
      name: 'JS Bank Limited',
      asset: AppAssets.jsBank,
      fallbackColor: Color(0xFF1E3A8A),
    ),
    BankOption(
      name: 'Sadapay',
      asset: AppAssets.sadapay,
      fallbackColor: Color(0xFF1B5B4E),
    ),
    BankOption(
      name: 'Nayapay',
      asset: AppAssets.nayapay,
      fallbackColor: Color(0xFF1F4FB8),
    ),
    BankOption(
      name: 'Raast ID',
      asset: AppAssets.raastId,
      fallbackColor: AppColors.brandGreen,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    if (widget.initialSearchQuery != null &&
        widget.initialSearchQuery!.trim().isNotEmpty) {
      _searchController.text = widget.initialSearchQuery!.trim();
    }
    _searchController.addListener(() => setState(() {}));
    _loadFavorites();
    FavoriteRecipientsStore.syncFromFirestore();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  List<BankOption> get _filteredBanks {
    final query = _searchController.text.trim().toLowerCase();
    if (query.isEmpty) return _banks;
    return _banks
        .where((bank) => bank.name.toLowerCase().contains(query))
        .toList();
  }

  Future<void> _loadFavorites() async {
    final favorites = await FavoriteRecipientsStore.load();
    if (!mounted) return;
    setState(() {
      _favoriteRecipients = favorites;
    });
    await FavoriteRecipientsStore.syncFromFirestore();
    final refreshed = await FavoriteRecipientsStore.load();
    if (!mounted) return;
    setState(() {
      _favoriteRecipients = refreshed;
    });
  }

  void _openFavoriteRecipient(FavoriteRecipient favorite) {
    showNavigationLoader(context, () {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => TransferFormScreen(
            bankName: favorite.bankName,
            logoAsset: favorite.logoAsset,
            initialAccountNumber: favorite.accountNumber,
            initialRecipientName: favorite.recipientName,
          ),
        ),
      );
    }).then((_) => _loadFavorites());
  }

  void _showAllFavorites() {
    if (_favoriteRecipients.isEmpty) return;
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
            itemCount: _favoriteRecipients.length,
            separatorBuilder: (_, _) =>
                const Divider(height: 1, color: Color(0xFFEDEDF1)),
            itemBuilder: (context, index) {
              final favorite = _favoriteRecipients[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.brandGreen.withValues(alpha: 0.12),
                  child: Text(
                    initialsFor(favorite.recipientName),
                    style: const TextStyle(
                      color: AppColors.brandGreenDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                title: Text(
                  favorite.recipientName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('${favorite.bankName} * ${favorite.accountNumber}'),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _openFavoriteRecipient(favorite);
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SimpleAppBar(
              title: 'Bank Transfer',
              rightText: 'Help',
              onBack: () => Navigator.of(context).pop(),
            ),
            TabBar(
              controller: _tabController,
              labelColor: AppColors.brandGreen,
              unselectedLabelColor: const Color(0xFF9E9E9E),
              labelStyle: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
              indicatorColor: AppColors.brandGreen,
              indicatorWeight: 4,
              tabs: const [
                Tab(text: 'Send Money'),
                Tab(text: 'History'),
              ],
            ),
            if (_tabController.index == 0) ...[
              SizedBox(height: 12.ui),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.ui),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'My Bank Favourites',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _favoriteRecipients.isEmpty
                          ? null
                          : _showAllFavorites,
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                      ),
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 120.ui,
                child: _favoriteRecipients.isEmpty
                    ? Center(
                        child: Text(
                          'No favourites yet',
                          style: TextStyle(
                            fontSize: 16.ui,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    : ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 15.ui),
                        itemCount: _favoriteRecipients.length,
                        separatorBuilder: (_, _) => SizedBox(width: 18.ui),
                        itemBuilder: (context, index) {
                          final favorite = _favoriteRecipients[index];
                          return InkWell(
                            onTap: () {
                              _openFavoriteRecipient(favorite);
                            },
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              width: 80.ui,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 54.ui,
                                    height: 54.ui,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.brandGreen,
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        initialsFor(favorite.recipientName),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 6.ui),
                                  Text(
                                    favorite.recipientName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.ui,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
            SizedBox(height: 10.5.ui),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.ui),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F4F6),
                  borderRadius: BorderRadius.circular(25.5.ui),
                ),
                padding: EdgeInsets.symmetric(horizontal: 13.5.ui),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search Bank by Name',
                    hintStyle: const TextStyle(
                      fontSize: 23,
                      color: Color(0xFF5F5C6E),
                    ),
                    suffixIcon: Icon(
                      Icons.search_rounded,
                      size: 24.ui,
                      color: const Color(0xFFB6B6B8),
                    ),
                  ),
                  style: const TextStyle(fontSize: 23),
                ),
              ),
            ),
            SizedBox(height: 13.5.ui),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.separated(
                    padding: EdgeInsets.fromLTRB(9.ui, 3.ui, 9.ui, 13.5.ui),
                    itemCount: _filteredBanks.length,
                    separatorBuilder: (_, _) =>
                        const Divider(height: 1, color: Color(0xFFEDEDF1)),
                    itemBuilder: (context, index) {
                      final bank = _filteredBanks[index];
                      return BankTile(
                        bank: bank,
                        highlighted:
                            bank.name == widget.initialHighlightedBankName,
                        onTap: () {
                          showNavigationLoader(context, () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => TransferFormScreen(
                                  bankName: bank.name,
                                  logoAsset: bank.asset,
                                ),
                              ),
                            );
                          });
                        },
                      );
                    },
                  ),
                  const Center(
                    child: Text(
                      'History will be wired here next.',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({
    super.key,
    required this.mode,
    required this.rememberedEmail,
    required this.onRememberEmail,
    required this.onUnlockSuccess,
    required this.onRequestClose,
  });

  final _AuthPromptMode mode;
  final String? rememberedEmail;
  final Future<void> Function(String email) onRememberEmail;
  final VoidCallback onUnlockSuccess;
  final VoidCallback onRequestClose;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _pinController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  bool get _pinMode => widget.mode == _AuthPromptMode.pin;

  @override
  void initState() {
    super.initState();
    if (widget.rememberedEmail != null) {
      _emailController.text = widget.rememberedEmail!;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  Future<void> _submitCredentials() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    try {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code != 'user-not-found') rethrow;
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      await widget.onRememberEmail(email);
      widget.onUnlockSuccess();
      if (mounted) Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication failed')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _submitPin() async {
    final pin = _pinController.text.trim();
    final email = widget.rememberedEmail;
    if (email == null || pin.length != 6) return;
    setState(() => _isLoading = true);
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pin,
      );
      widget.onUnlockSuccess();
      if (mounted) Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Authentication failed')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _appendPinDigit(String digit) {
    if (_isLoading) return;
    final current = _pinController.text;
    if (current.length >= 6) return;
    setState(() {
      _pinController.text = '$current$digit';
    });
  }

  void _removePinDigit() {
    if (_isLoading) return;
    final current = _pinController.text;
    if (current.isEmpty) return;
    setState(() {
      _pinController.text = current.substring(0, current.length - 1);
    });
  }

  Future<void> _submitPinFromPad() async {
    if (_isLoading || _pinController.text.length != 6) return;
    await _submitPin();
  }

  Widget _pinBox(int index) {
    final filled = _pinController.text.length > index;
    return Container(
      width: 44,
      height: 44,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFBFBFC5), width: 1.2),
      ),
      child: Text(
        filled ? '*' : '',
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _pinPadCell({
    required Widget child,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Center(child: child),
    );
  }

  Widget _buildBottomPinPad() {
    final doneEnabled = !_isLoading && _pinController.text.length == 6;
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 232,
          child: Table(
            border: const TableBorder(
              top: BorderSide(color: Color(0xFFE3E5E8), width: 1),
              horizontalInside: BorderSide(color: Color(0xFFE3E5E8), width: 1),
              verticalInside: BorderSide(color: Color(0xFFE3E5E8), width: 1),
            ),
            children: [
              TableRow(
                children: [
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '1',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('1'),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '2',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('2'),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '3',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('3'),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '4',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('4'),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '5',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('5'),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '6',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('6'),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '7',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('7'),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '8',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('8'),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '9',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('9'),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Icon(
                        Icons.backspace_outlined,
                        color: AppColors.textPrimary,
                        size: 24,
                      ),
                      onTap: _removePinDigit,
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: const Text(
                        '0',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      onTap: () => _appendPinDigit('0'),
                    ),
                  ),
                  SizedBox(
                    height: 58,
                    child: _pinPadCell(
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: doneEnabled
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                        ),
                      ),
                      onTap: doneEnabled ? _submitPinFromPad : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editEmail() async {
    final emailController = TextEditingController(text: widget.rememberedEmail ?? _emailController.text);
    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Enter email'),
          content: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Email address'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(emailController.text.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
    if (!mounted) return;
    if (result == null || result.isEmpty) return;
    _emailController.text = result;
    await widget.onRememberEmail(result);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final rememberedEmail = widget.rememberedEmail ?? _emailController.text.trim();
    final showEmail = !_pinMode;
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Align(
            alignment: _pinMode ? Alignment.bottomCenter : Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, _pinMode ? 300 : 0),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 18),
                constraints: const BoxConstraints(maxWidth: 420),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x22000000),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          Image.asset(
                            AppAssets.authLockLogo,
                            height: 156,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.lock_rounded,
                                size: 136,
                                color: AppColors.brandGreen,
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _pinMode ? 'ENTER YOUR 6 DIGIT PIN' : 'SIGN IN TO YOUR ACCOUNT',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary,
                              letterSpacing: 0.3,
                            ),
                          ),
                          if (showEmail) ...[
                            const SizedBox(height: 10),
                            Text(
                              rememberedEmail.isEmpty
                                  ? 'Last email will appear here'
                                  : rememberedEmail,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                          const SizedBox(height: 16),
                          if (_pinMode) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(6, _pinBox),
                            ),
                          ] else ...[
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) => (value == null || !value.contains('@') || !value.contains('.'))
                                        ? 'Enter a valid email'
                                        : null,
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscurePassword,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: '6 digit password',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                                        icon: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_outlined
                                              : Icons.visibility_off_outlined,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      final text = value?.trim() ?? '';
                                      if (text.length != 6 || int.tryParse(text) == null) {
                                        return 'Enter a 6 digit password';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 18),
                          SizedBox(
                            width: double.infinity,
                            height: 44,
                            child: FilledButton(
                              onPressed: _isLoading
                                  ? null
                                  : _pinMode
                                      ? (_pinController.text.length == 6
                                          ? _submitPinFromPad
                                          : null)
                                      : _submitCredentials,
                              style: FilledButton.styleFrom(
                                backgroundColor: _pinMode
                                    ? (_pinController.text.length == 6
                                        ? AppColors.brandGreen
                                        : const Color(0xFFB9B9BF))
                                    : AppColors.brandGreen,
                                disabledBackgroundColor: const Color(0xFFB9B9BF),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: _isLoading
                                  ? const SizedBox(
                                      height: 18,
                                      width: 18,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('PROCEED'),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: _editEmail,
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: AppColors.textPrimary,
                                    side: const BorderSide(color: Color(0xFF8BC9A7)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    minimumSize: const Size.fromHeight(44),
                                  ),
                                  child: const Text('FORGOT PIN'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: OutlinedButton(
                                  onPressed: _editEmail,
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    foregroundColor: AppColors.brandGreen,
                                    side: const BorderSide(color: Color(0xFF8BC9A7)),
                                    shape: const CircleBorder(),
                                  ),
                                  child: const Icon(Icons.fingerprint_rounded),
                                ),
                              ),
                            ],
                          ),
                          if (!_pinMode) ...[
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: _editEmail,
                              child: const Text('Use account email'),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: IconButton(
                        onPressed: widget.onRequestClose,
                        icon: const Icon(Icons.close_rounded, color: AppColors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_pinMode)
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildBottomPinPad(),
            ),
        ],
      ),
    );
  }
}

class OtherWalletsScreen extends StatelessWidget {
  const OtherWalletsScreen({super.key});

  static const List<BankOption> _wallets = [
    BankOption(
      name: 'JazzCash',
      asset: AppAssets.jazzCash,
      fallbackColor: AppColors.brandGreen,
    ),
    BankOption(
      name: 'Sadapay',
      asset: AppAssets.sadapay,
      fallbackColor: Color(0xFF1B5B4E),
    ),
    BankOption(
      name: 'Nayapay',
      asset: AppAssets.nayapay,
      fallbackColor: Color(0xFF1F4FB8),
    ),
    BankOption(
      name: 'U Microfinance Bank',
      asset: AppAssets.uMicrofinanceBank,
      fallbackColor: Color(0xFF1D6C91),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SimpleAppBar(
              title: 'Other Wallets',
              onBack: () => Navigator.of(context).pop(),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select a wallet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(10, 6, 10, 12),
                itemCount: _wallets.length,
                separatorBuilder: (_, _) =>
                    const Divider(height: 1, color: Color(0xFFEDEDF1)),
                itemBuilder: (context, index) {
                  final wallet = _wallets[index];
                  return BankTile(
                    bank: wallet,
                    onTap: () {
                      showNavigationLoader(context, () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => TransferFormScreen(
                              bankName: wallet.name,
                              logoAsset: wallet.asset,
                            ),
                          ),
                        );
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BankTile extends StatelessWidget {
  const BankTile({
    super.key,
    required this.bank,
    required this.onTap,
    this.highlighted = false,
  });

  final BankOption bank;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.5.ui, vertical: 22.ui),
        child: Row(
          children: [
            BankLogo(
              name: bank.name,
              asset: bank.asset,
              fallbackColor: bank.fallbackColor,
              size: 80.ui,
              greenOutline: highlighted,
            ),
            SizedBox(width: 15.ui),
            Expanded(
              child: Text(
                bank.name,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 7.5.ui),
            Icon(
              Icons.chevron_right_rounded,
              size: 28.5.ui,
              color: const Color(0xFF454054),
            ),
          ],
        ),
      ),
    );
  }
}

class BankLogo extends StatelessWidget {
  const BankLogo({
    super.key,
    required this.name,
    required this.asset,
    required this.fallbackColor,
    required this.size,
    this.circle = false,
    this.greenOutline = false,
  });

  final String name;
  final String asset;
  final Color fallbackColor;
  final double size;
  final bool circle;
  final bool greenOutline;

  @override
  Widget build(BuildContext context) {
    final fallback = circle
        ? _BrandInitialsCircle(
            initials: initialsFor(name),
            size: size,
            backgroundColor: fallbackColor.withValues(alpha: 0.12),
            foregroundColor: fallbackColor,
          )
        : _BrandInitialsBox(
            initials: initialsFor(name),
            size: size,
            backgroundColor: fallbackColor.withValues(alpha: 0.10),
            foregroundColor: fallbackColor,
          );

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(circle ? 999 : 9.ui),
            child: Image.asset(
              asset,
              width: size,
              height: size,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => fallback,
            ),
          ),
          if (greenOutline)
            DecoratedBox(
              decoration: BoxDecoration(
                shape: circle ? BoxShape.circle : BoxShape.rectangle,
                border: Border.all(color: AppColors.brandGreen, width: 3.ui),
                borderRadius: circle ? null : BorderRadius.circular(9.ui),
              ),
            ),
        ],
      ),
    );
  }
}

class _BrandInitialsBox extends StatelessWidget {
  const _BrandInitialsBox({
    required this.initials,
    required this.size,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String initials;
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(9.ui),
      ),
      child: Text(
        initials,
        style: TextStyle(
          color: foregroundColor,
          fontSize: size * 0.24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _BrandInitialsCircle extends StatelessWidget {
  const _BrandInitialsCircle({
    required this.initials,
    required this.size,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String initials;
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Text(
        initials,
        style: TextStyle(
          color: foregroundColor,
          fontSize: size * 0.24,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class TransferFormScreen extends StatefulWidget {
  const TransferFormScreen({
    super.key,
    required this.bankName,
    required this.logoAsset,
    this.initialAccountNumber,
    this.initialRecipientName,
  });

  final String bankName;
  final String logoAsset;
  final String? initialAccountNumber;
  final String? initialRecipientName;

  @override
  State<TransferFormScreen> createState() => _TransferFormScreenState();
}

class _TransferFormScreenState extends State<TransferFormScreen> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _recipientNameController =
      TextEditingController();
  final TextEditingController _purposeController = TextEditingController(
    text: 'Others',
  );
  final int _selectedReceiverDetail = 0;

  @override
  void initState() {
    super.initState();
    _accountController.text = widget.initialAccountNumber ?? '';
    _recipientNameController.text = widget.initialRecipientName ?? '';
  }

  @override
  void dispose() {
    _accountController.dispose();
    _recipientNameController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  bool get _canContinue =>
      _accountController.text.trim().isNotEmpty &&
      _recipientNameController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SimpleAppBar(
              title: 'Send Money',
              onBack: () => Navigator.of(context).pop(),
            ),
            Container(
              width: double.infinity,
              color: const Color(0xFFF3FBF4),
              padding: EdgeInsets.fromLTRB(15.ui, 13.5.ui, 15.ui, 25.5.ui),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sending to Bank Account',
                    style: TextStyle(
                      color: Color(0xFF4B4218),
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      BankLogo(
                        name: widget.bankName,
                        asset: widget.logoAsset,
                        fallbackColor: AppColors.brandGreen,
                        size: 82.5.ui,
                        circle: true,
                        greenOutline: true,
                      ),
                      SizedBox(width: 13.5.ui),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                widget.bankName,
                                style: const TextStyle(
                                  fontSize: 22.4,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: 7.5.ui),
                            Icon(
                              Icons.account_balance_outlined,
                              color: AppColors.brandGreen,
                              size: 28.5.ui,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(18.ui, 31.5.ui, 18.ui, 21.ui),
                children: [
                  const Text(
                    "Select Receiver's Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 19.5.ui),

                  SizedBox(height: 43.5.ui),
                  const Text(
                    'Enter Account Number',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 12.ui),
                  Container(
                    height: 66.ui,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.5.ui),
                      border: Border.all(
                        color: const Color(0xFFE0E0E4),
                        width: 1.6,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _accountController,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 13.5,
                                vertical: 18,
                              ),
                              hintText: 'Enter Account Number',
                              hintStyle: TextStyle(
                                color: Color(0xFFC7C7CD),
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21.ui),
                  const Text(
                    'Enter Recipient Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 12.ui),
                  Container(
                    height: 66.ui,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(13.5.ui),
                      border: Border.all(
                        color: const Color(0xFFE0E0E4),
                        width: 1.6,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _recipientNameController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words,
                            onChanged: (_) => setState(() {}),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 13.5,
                                vertical: 18,
                              ),
                              hintText: 'Enter Recipient Name',
                              hintStyle: TextStyle(
                                color: Color(0xFFC7C7CD),
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21.ui),
                  const Text(
                    'Select Purpose of Payment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 12.ui),
                  InkWell(
                    onTap: () => setState(() {}),
                    borderRadius: BorderRadius.circular(13.5.ui),
                    child: Container(
                      height: 61.5.ui,
                      padding: EdgeInsets.symmetric(horizontal: 15.ui),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13.5.ui),
                        border: Border.all(
                          color: const Color(0xFFE0E0E4),
                          width: 1.6,
                        ),
                      ),
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Others',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 33,
                            color: Color(0xFF454054),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 36.ui),
                  SizedBox(
                    height: 51.ui,
                    child: FilledButton(
                      onPressed: _canContinue
                          ? () {
                              showNavigationLoader(context, () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (_) => AmountEntryScreen(
                                      bankName: widget.bankName,
                                      logoAsset: widget.logoAsset,
                                      accountNumber: _accountController.text
                                          .trim(),
                                      recipientName: _recipientNameController
                                          .text
                                          .trim(),
                                    ),
                                  ),
                                );
                              });
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.brandGreen,
                        disabledBackgroundColor: const Color(0xFFD9DDE1),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.5.ui),
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: _canContinue ? Colors.white : Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RadioRow extends StatelessWidget {
  const _RadioRow({
    required this.selected,
    required this.label,
    required this.onTap,
  });

  final bool selected;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? AppColors.brandGreen
                    : const Color(0xFF6D6881),
                width: 2.2,
              ),
            ),
            padding: const EdgeInsets.all(5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              decoration: BoxDecoration(
                color: selected ? AppColors.brandGreen : Colors.transparent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class AmountEntryScreen extends StatefulWidget {
  const AmountEntryScreen({
    super.key,
    required this.bankName,
    required this.logoAsset,
    required this.accountNumber,
    required this.recipientName,
  });

  final String bankName;
  final String logoAsset;
  final String accountNumber;
  final String recipientName;

  @override
  State<AmountEntryScreen> createState() => _AmountEntryScreenState();
}

class _AmountEntryScreenState extends State<AmountEntryScreen> {
  late final TextEditingController _amountController;

  int get _amount => int.tryParse(_amountController.text) ?? 0;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '0');
    _amountController.selection = const TextSelection(
      baseOffset: 0,
      extentOffset: 1,
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SimpleAppBar(
              title: 'Send Money',
              onBack: () => Navigator.of(context).pop(),
            ),
            Container(
              width: double.infinity,
              color: const Color.fromARGB(255, 251, 254, 252),
              padding: const EdgeInsets.fromLTRB(20, 18, 20, 34),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sending to Bank Account',
                    style: TextStyle(
                      color: Color.fromARGB(255, 37, 37, 37),
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      BankLogo(
                        name: widget.bankName,
                        asset: widget.logoAsset,
                        fallbackColor: AppColors.brandGreen,
                        size: 70,
                        circle: true,
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.bankName,
                                    style: const TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.account_balance_outlined,
                                  color: AppColors.brandGreen,
                                  size: 21,
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.accountNumber,
                              style: const TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 30, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Enter Amount',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 54),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Rs. ',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 14, 13, 15),
                          ),
                        ),
                        SizedBox(
                          width: 230,
                          child: TextField(
                            controller: _amountController,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (_) => setState(() {}),
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            style: const TextStyle(
                              fontSize: 54,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 62),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton(
                        onPressed: _amount > 0
                            ? () {
                                showNavigationLoader(context, () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute<void>(
                                      builder: (_) => ReviewTransferScreen(
                                        amount: _amount.toDouble(),
                                        bankName: widget.bankName,
                                        logoAsset: widget.logoAsset,
                                        accountNumber: widget.accountNumber,
                                        recipientName: widget.recipientName,
                                      ),
                                    ),
                                  );
                                });
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.brandGreen,
                          disabledBackgroundColor: const Color(0xFFD9DDE1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(36),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewTransferScreen extends StatefulWidget {
  const ReviewTransferScreen({
    super.key,
    required this.amount,
    required this.bankName,
    required this.logoAsset,
    required this.accountNumber,
    required this.recipientName,
  });

  final double amount;
  final String bankName;
  final String logoAsset;
  final String accountNumber;
  final String recipientName;

  @override
  State<ReviewTransferScreen> createState() => _ReviewTransferScreenState();
}

class _ReviewTransferScreenState extends State<ReviewTransferScreen> {
  bool _favorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final isFavorite = await FavoriteRecipientsStore.contains(
      bankName: widget.bankName,
      accountNumber: widget.accountNumber,
    );
    if (!mounted) return;
    setState(() => _favorite = isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F8),
      appBar: AppBar(
        title: const Text(
          'Send Money',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 30),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
        children: [
          const Text(
            'Pay From',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          _ReviewCard(
            child: Row(
              children: [
                BankLogo(
                  name: 'easypaisa',
                  asset: AppAssets.moneyBag,
                  fallbackColor: AppColors.brandGreen,
                  size: 44,
                  circle: true,
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'easypaisa Account:\n',
                          style: TextStyle(
                            fontSize: 23,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        TextSpan(
                          text: 'Balance Rs. 25000.44',
                          style: TextStyle(
                            fontSize: 24,
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Text(
            'Pay To',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _ReviewCard(
            child: Column(
              children: [
                _ReviewRow(label: 'Account Title', value: widget.recipientName),
                const SizedBox(height: 24),
                _ReviewRow(
                  label: 'Account Number',
                  value: widget.accountNumber,
                ),
                const SizedBox(height: 24),
                _ReviewRow(
                  label: 'IBAN',
                  value: 'PK41JCMA0604923191981267',
                  valueStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Payment Summary',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          _ReviewCard(
            child: Column(
              children: [
                _ReviewRow(
                  label: 'Transfer Amount',
                  value: 'Rs. ${widget.amount.toStringAsFixed(0)}',
                ),
                const SizedBox(height: 24),
                _ReviewRow(label: 'Fee (including tax)', value: 'Free'),
                const SizedBox(height: 24),
                _ReviewRow(
                  label: 'Total Amount',
                  value: 'Rs. ${widget.amount.toStringAsFixed(2)}',
                  valueStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  labelStyle: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _FavoriteContactCard(
            selected: _favorite,
            onTap: () => setState(() => _favorite = !_favorite),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF3F3E52), width: 2),
            ),
            child: const Row(
              children: [
                Icon(Icons.info, color: Color(0xFF3F3E52), size: 24),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'Please review the details carefully before sending money.',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 120),
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 6, 24, 24),
          child: SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: () {
                showNavigationLoader(context, () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => SendingScreen(
                        amount: widget.amount,
                        bankName: widget.bankName,
                        logoAsset: widget.logoAsset,
                        recipientAccount: widget.accountNumber,
                        recipientName: widget.recipientName,
                        markAsFavorite: _favorite,
                      ),
                    ),
                  );
                });
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.brandGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
              ),
              child: Text(
                'Send Rs. ${widget.amount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  const _ReviewCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: Text(
            label,
            style:
                labelStyle ??
                const TextStyle(fontSize: 24, color: AppColors.textPrimary),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
            style:
                valueStyle ??
                const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
          ),
        ),
      ],
    );
  }
}

class _FavoriteContactCard extends StatelessWidget {
  const _FavoriteContactCard({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                border: Border.all(
                  color: selected
                      ? AppColors.brandGreen
                      : const Color(0xFFBDBDC4),
                  width: 2.4,
                ),
                color: selected ? AppColors.brandGreen : Colors.white,
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 10,
                    )
                  : null,
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Favourite Contact',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Add this recipient as a favourite for easypayments in the future.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFABA7B1),
                      height: 1.15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SendingScreen extends StatefulWidget {
  const SendingScreen({
    super.key,
    required this.amount,
    required this.bankName,
    required this.logoAsset,
    required this.recipientAccount,
    required this.recipientName,
    required this.markAsFavorite,
  });

  final double amount;
  final String bankName;
  final String logoAsset;
  final String recipientAccount;
  final String recipientName;
  final bool markAsFavorite;

  @override
  State<SendingScreen> createState() => _SendingScreenState();
}

class _SendingScreenState extends State<SendingScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 2200), () {
      if (!mounted) return;
      showNavigationLoader(context, () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute<void>(
            builder: (_) => TransferSuccessScreen(
              amount: widget.amount,
              bankName: widget.bankName,
              logoAsset: widget.logoAsset,
              recipientAccount: widget.recipientAccount,
              recipientName: widget.recipientName,
              markAsFavorite: widget.markAsFavorite,
            ),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 18),
              const Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.close_rounded,
                  size: 44,
                  color: Color(0xFFBBBBBB),
                ),
              ),
              const Spacer(flex: 2),
              Column(
                children: [
                  const Text(
                    'Sending',
                    style: TextStyle(
                      fontSize: 70,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Rs.${widget.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 34),
                  Text(
                    'to ${widget.recipientName}\n${widget.recipientAccount}',
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      height: 1.14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const Spacer(flex: 2),
              SizedBox(
                height: 140,
                child: Center(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(seconds: 2),
                    builder: (context, value, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Transform.rotate(
                            angle: value * 2 * math.pi,
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: AppColors.brandGreen,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          const Positioned(
                            left: 22,
                            child: Icon(
                              Icons.account_balance_wallet_outlined,
                              color: AppColors.brandGreen,
                              size: 84,
                            ),
                          ),
                          const Positioned(
                            right: 18,
                            child: Icon(
                              Icons.account_balance_outlined,
                              color: AppColors.brandGreen,
                              size: 78,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const Spacer(flex: 2),
              const Text(
                'Please wait',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}

class TransferSuccessScreen extends StatefulWidget {
  const TransferSuccessScreen({
    super.key,
    required this.amount,
    required this.bankName,
    required this.logoAsset,
    required this.recipientAccount,
    required this.recipientName,
    required this.markAsFavorite,
  });

  final double amount;
  final String bankName;
  final String logoAsset;
  final String recipientAccount;
  final String recipientName;
  final bool markAsFavorite;

  @override
  State<TransferSuccessScreen> createState() => _TransferSuccessScreenState();
}

class _TransferSuccessScreenState extends State<TransferSuccessScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _contentController;
  late final Animation<double> _contentOpacity;
  late final Animation<Offset> _contentSlide;
  bool _transactionSaved = false;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
    _contentOpacity = CurvedAnimation(
      parent: _contentController,
      curve: const Interval(0.48, 1, curve: Curves.easeOut),
    );
    _contentSlide =
        Tween<Offset>(begin: const Offset(0, 0.12), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _contentController,
            curve: const Interval(0.48, 1, curve: Curves.easeOutCubic),
          ),
        );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _persistTransaction();
    });
  }

  Future<void> _persistTransaction() async {
    if (_transactionSaved) return;
    _transactionSaved = true;

    if (widget.markAsFavorite) {
      try {
        await FavoriteRecipientsStore.upsert(
          FavoriteRecipient(
            recipientName: widget.recipientName,
            accountNumber: widget.recipientAccount,
            bankName: widget.bankName,
            logoAsset: widget.logoAsset,
            savedAtMs: DateTime.now().millisecondsSinceEpoch,
          ),
        );
      } catch (_) {
        // Favorites are best-effort and should not block transfer success.
      }
    }

    if (Firebase.apps.isEmpty) return;
    try {
      final transactionsCollection = await accountCollection('transactions');
      if (transactionsCollection == null) return;
      await transactionsCollection.add({
        'title': 'Money Transfer via Raast - ${widget.recipientName}',
        'amount': widget.amount,
        'recipientName': widget.recipientName,
        'recipientAccount': widget.recipientAccount,
        'bankName': widget.bankName,
        'iban': 'PK41JCMA0604923191981267',
        'fee': 0,
        'status': 'success',
        'type': 'debit',
        'timestamp': FieldValue.serverTimestamp(),
        'clientTimestamp': Timestamp.fromDate(DateTime.now()),
        'receiptId': 'ID#515320532390',
        'savedForEmail': FirebaseAuth.instance.currentUser?.email,
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Transaction saved locally, but sync failed.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void returnHome() {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }

    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) returnHome();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ListView(
                padding: const EdgeInsets.fromLTRB(0, 12, 0, 24),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: returnHome,
                        icon: const Icon(
                          Icons.close_rounded,
                          size: 38,
                          color: Color(0xFFBBBBBB),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Center(child: _SuccessBadge()),
                  const SizedBox(height: 26),
                  FadeTransition(
                    opacity: _contentOpacity,
                    child: SlideTransition(
                      position: _contentSlide,
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 22.0),
                                  child: const Text(
                                    'Rs ',
                                    style: TextStyle(
                                      fontFamily: 'Google Sans',
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Color.fromARGB(255, 14, 14, 15),
                                    ),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: widget.amount.toStringAsFixed(0),
                                style: const TextStyle(
                                  fontFamily: 'Google Sanssf',
                                  fontSize: 52,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  height: 1,
                                ),
                              ),
                              const TextSpan(
                                text: '.00',
                                style: TextStyle(
                                  fontFamily: 'Google Sans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  height: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeTransition(
                    opacity: _contentOpacity,
                    child: SlideTransition(
                      position: _contentSlide,
                      child: const Center(
                        child: Text(
                          'Successfully Sent to',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 14, 14, 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(
                            2,
                          ), // Space between logo and border
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.brandGreen,
                              width: 2,
                            ),
                          ),
                          child: BankLogo(
                            name: widget.bankName,
                            asset: widget.logoAsset,
                            fallbackColor: AppColors.brandGreen,
                            size: 55,
                            circle: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      widget.recipientName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 15, 14, 15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      widget.recipientAccount,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                  // const SizedBox(height: 26),
                  const SizedBox(height: 26),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    child: Text(
                      'Important Details for you',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(height: 1, color: const Color(0xFFEDEDF1)),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26),
                    child: Text(
                      "Money has been sent from easypaisa to receiver's bank account. To confirm check with the receiver",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        height: 1.15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  _SuccessActionRow(
                    icon: Icons.receipt_long_outlined,
                    label: 'View Receipt',
                    onTap: () => showReceiptDialog(
                      context,
                      amount: widget.amount,
                      bankName: widget.bankName,
                      recipientName: widget.recipientName,
                      recipientAccount: widget.recipientAccount,
                    ),
                  ),
                  _SuccessActionRow(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    onTap: () => showReceiptDialog(
                      context,
                      amount: widget.amount,
                      bankName: widget.bankName,
                      recipientName: widget.recipientName,
                      recipientAccount: widget.recipientAccount,
                    ),
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Native version of the green success check shown after a transfer completes.
/// The circle pops into place and the checkmark is drawn from left to right.
class _SuccessBadge extends StatelessWidget {
  const _SuccessBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92,
      height: 92,
      decoration: const BoxDecoration(
        color: AppColors.brandGreen,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.check_rounded,
        color: Colors.white,
        size: 54,
      ),
    );
  }
}

class _SuccessActionRow extends StatelessWidget {
  const _SuccessActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(height: 1, thickness: 1, color: Color(0xFFEDEDF1)),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 29,
                  color: const Color.fromARGB(255, 53, 52, 53),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 42,
                  color: AppColors.textPrimary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

String _formatReceiptDateTime(DateTime dateTime) {
  const monthNames = <String>[
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour >= 12 ? 'PM' : 'AM';
  return '${dateTime.day} ${monthNames[dateTime.month - 1]} ${dateTime.year} '
      '${hour.toString().padLeft(2, '0')}:$minute $period';
}

class _TornReceiptClipper extends CustomClipper<Path> {
  const _TornReceiptClipper();

  static const double tearDepth = 2;
  static const double toothWidth = 3;

  @override
  Path getClip(Size size) {
    final path = Path()..moveTo(0, tearDepth);

    var index = 0;
    for (double x = 0; x <= size.width; x += toothWidth) {
      path.lineTo(x, index.isEven ? 0 : tearDepth);
      index++;
    }

    path.lineTo(size.width, size.height - tearDepth);

    index = 0;
    for (double x = size.width; x >= 0; x -= toothWidth) {
      path.lineTo(x, index.isEven ? size.height : size.height - tearDepth);
      index++;
    }

    path.lineTo(0, tearDepth);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _TornReceiptClipper oldClipper) => false;
}

Future<void> showReceiptDialog(
  BuildContext context, {
  required double amount,
  String? bankName,
  required String recipientName,
  required String recipientAccount,
}) async {
  final receiptDateTime = _formatReceiptDateTime(DateTime.now());
  final profile = await resolveUserProfile();
  final receiptKey = GlobalKey();
  var isProcessing = false;

  Future<Uint8List> captureReceipt() async {
    await WidgetsBinding.instance.endOfFrame;
    final renderObject = receiptKey.currentContext?.findRenderObject();
    if (renderObject is! RenderRepaintBoundary) {
      throw StateError('The receipt is not ready to capture.');
    }

    final image = await renderObject.toImage(pixelRatio: 3);
    try {
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) {
        throw StateError('Unable to create the receipt image.');
      }
      return data.buffer.asUint8List();
    } finally {
      image.dispose();
    }
  }

  void showResultMessage(String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> runReceiptAction(
    VoidCallback refresh,
    Future<void> Function(Uint8List bytes) action,
  ) async {
    if (isProcessing) return;
    isProcessing = true;
    refresh();
    try {
      await action(await captureReceipt());
    } catch (_) {
      showResultMessage('Unable to process the receipt. Please try again.');
    } finally {
      isProcessing = false;
      refresh();
    }
  }

  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Transaction Successful',
    barrierColor: Colors.black45,
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      return StatefulBuilder(
        builder: (dialogContext, setState) => Center(
          child: Material(
            color: Colors.transparent,
            child: RepaintBoundary(
              key: receiptKey,
              child: ClipPath(
                clipper: const _TornReceiptClipper(),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: MediaQuery.of(context).size.height * 0.88,
                  color: Colors.white,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(28, 36, 28, 22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 18),
                            const Center(
                              child: Icon(
                                Icons.check_circle,
                                size: 52,
                                color: AppColors.brandGreen,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Center(
                              child: SizedBox(
                                width: 150,
                                height: 40,
                                child: Image(
                                  image: AssetImage(AppAssets.easypaisaJpg),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            const Center(
                              child: Text(
                                'Transaction Successful',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.brandGreen,
                                ),
                              ),
                            ),
                            const Center(
                              child: Text(
                                'Money has been sent.',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFF9A9A9A),
                                ),
                              ),
                            ),
                            const SizedBox(height: 36),
                            Text(
                              receiptDateTime,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Color(0xFF9A9A9A),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'ID#515320532390',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF9A9A9A),
                              ),
                            ),
                            const SizedBox(height: 26),
                            const Text(
                              'Sent to',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              recipientName,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              recipientAccount,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              bankName ?? 'Bank transfer',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 26),
                            const Text(
                              'Sent By',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              profile.displayName,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              profile.phoneNumber,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 26),
                            const Text(
                              'Amount',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              amount.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Color(0xFF7D7D7D),
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              'Fee / Charge',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF8E8E8E),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 26,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF66C2FF),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text(
                                'Free',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 22),
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: AppColors.brandGreen,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Rs. ${amount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 67, 65, 73),
                              ),
                            ),
                            const SizedBox(height: 28),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _ReceiptAction(
                                  icon: Icons.share_outlined,
                                  label: 'Share',
                                  busy: isProcessing,
                                  onTap: () => runReceiptAction(
                                    () => setState(() {}),
                                    (bytes) async {
                                      final result = await Share.shareXFiles(
                                        [
                                          XFile.fromData(
                                            bytes,
                                            mimeType: 'image/png',
                                          ),
                                        ],
                                        subject:
                                            'easypaisa Transaction Receipt',
                                        fileNameOverrides: const [
                                          'easypaisa_transaction_receipt.png',
                                        ],
                                      );
                                      if (result.status ==
                                          ShareResultStatus.success) {
                                        showResultMessage(
                                          'Receipt shared successfully.',
                                        );
                                      }
                                    },
                                  ),
                                ),
                                _ReceiptAction(
                                  icon: Icons.photo_outlined,
                                  label: 'Save to Photos',
                                  busy: isProcessing,
                                  onTap: () => runReceiptAction(
                                    () => setState(() {}),
                                    (bytes) async {
                                      var hasAccess = await Gal.hasAccess();
                                      if (!hasAccess) {
                                        hasAccess = await Gal.requestAccess();
                                      }
                                      if (!hasAccess) {
                                        throw StateError(
                                          'Gallery permission was denied.',
                                        );
                                      }
                                      await Gal.putImageBytes(
                                        bytes,
                                        name: 'easypaisa_transaction_receipt',
                                      );
                                      showResultMessage(
                                        'Receipt saved to Photos.',
                                      );
                                    },
                                  ),
                                ),
                                _ReceiptAction(
                                  icon: Icons.picture_as_pdf_outlined,
                                  label: 'Save as PDF',
                                  busy: false,
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 18,
                        top: 14,
                        child: IconButton(
                          onPressed: () => Navigator.of(dialogContext).pop(),
                          icon: const Icon(Icons.close_rounded, size: 34),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class _ReceiptAction extends StatelessWidget {
  const _ReceiptAction({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.busy,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(
            busy ? Icons.hourglass_top_rounded : icon,
            size: 16,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 14),
          Text(
            label,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16, color: Color(0xFF8D8D8D)),
          ),
        ],
      ),
    );
  }
}

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({
    super.key,
    required this.profile,
    required this.onBackToHome,
    required this.onEditProfile,
  });

  final UserProfileData profile;
  final VoidCallback onBackToHome;
  final VoidCallback onEditProfile;

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SimpleAppBar(
              title: 'My Account',
              onBack: widget.onBackToHome,
            ),
            _AccountHeaderCard(controller: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView(
                    padding: const EdgeInsets.fromLTRB(18, 16, 18, 120),
                    children: [
                      _SummaryProfileCard(
                        profile: widget.profile,
                        onEditProfile: widget.onEditProfile,
                      ),
                      const SizedBox(height: 16),
                      _QuickAccountCard(profile: widget.profile),
                    ],
                  ),
                  const _LiveTransactionHistoryTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditProfileDialog extends StatefulWidget {
  const _EditProfileDialog({
    required this.profile,
    required this.onSave,
  });

  final UserProfileData profile;
  final Future<void> Function(
    String displayName,
    String phoneNumber,
    String? photoBase64,
  ) onSave;

  @override
  State<_EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<_EditProfileDialog> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  String? _photoBase64;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.displayName);
    _phoneController = TextEditingController(
      text: widget.profile.phoneNumber == 'Not set' ? '' : widget.profile.phoneNumber,
    );
    _photoBase64 = widget.profile.photoBase64;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter your name';
    if (value.trim().length < 2) return 'Name is too short';
    return null;
  }

  String? _validatePhone(String? value) {
    final normalized = normalizePhoneNumber(value ?? '');
    if (normalized.isEmpty) return 'Enter your phone number';
    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(normalized)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await widget.onSave(_nameController.text, _phoneController.text, _photoBase64);
      if (!mounted) return;
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to save profile')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickPhoto() async {
    if (_saving) return;
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1024,
    );
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    if (!mounted) return;
    setState(() {
      _photoBase64 = base64Encode(bytes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _saving ? null : _pickPhoto,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 74,
                          height: 74,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFDCEFE3), width: 2),
                          ),
                          child: ClipOval(
                            child: _photoBase64 == null
                                ? Image.asset(
                                    AppAssets.profileAvatar,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: const Color(0xFFF4FBF7),
                                      alignment: Alignment.center,
                                      child: Text(
                                        initialsFor(_nameController.text.isEmpty
                                            ? widget.profile.displayName
                                            : _nameController.text),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  )
                                : Image.memory(
                                    base64Decode(_photoBase64!),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(
                                      color: const Color(0xFFF4FBF7),
                                      alignment: Alignment.center,
                                      child: Text(
                                        initialsFor(_nameController.text.isEmpty
                                            ? widget.profile.displayName
                                            : _nameController.text),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: AppColors.brandGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Tap the photo to upload a profile picture',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Edit Profile',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _nameController,
                enabled: !_saving,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Full name',
                  border: OutlineInputBorder(),
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _phoneController,
                enabled: !_saving,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  border: OutlineInputBorder(),
                ),
                validator: _validatePhone,
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _saving ? null : _submit,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(48),
                    backgroundColor: AppColors.brandGreen,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_saving ? 'Saving...' : 'Save changes'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveTransactionHistoryTab extends StatelessWidget {
  const _LiveTransactionHistoryTab();

  @override
  Widget build(BuildContext context) {
    if (Firebase.apps.isEmpty) {
      return ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
        children: [
          _EStatementCard(),
          SizedBox(height: 20),
          _EmptyHistoryState(
            title: 'History is loading',
            subtitle:
                'Firebase is not initialized in this environment yet, so live history cannot load.',
          ),
        ],
      );
    }

    return FutureBuilder<String?>(
      future: activeAccountId(),
      builder: (context, accountSnapshot) {
        if (accountSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.brandGreen),
          );
        }

        final accountId = accountSnapshot.data;
        if (accountId == null) {
          return ListView(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
            children: const [
              _EStatementCard(),
              SizedBox(height: 20),
              _EmptyHistoryState(
                title: 'Sign in to view history',
                subtitle: 'Each account has its own Firestore history after sign-in.',
              ),
            ],
          );
        }

        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(accountId)
              .collection('transactions')
              .orderBy('clientTimestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.brandGreen),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'Unable to load transaction history.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                  ),
                ),
              );
            }

            final records = (snapshot.data?.docs ?? const [])
                .map(TransactionRecord.fromFirestore)
                .toList();

            if (records.isEmpty) {
              return ListView(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
                children: const [
                  _EStatementCard(),
                  SizedBox(height: 20),
                  _EmptyHistoryState(),
                ],
              );
            }

            final grouped = <String, List<TransactionRecord>>{};
            for (final record in records) {
              grouped
                  .putIfAbsent(record.dateLabel, () => <TransactionRecord>[])
                  .add(record);
            }

            final latest = records.first;
            return ListView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 120),
              children: [
                const _EStatementCard(),
                const SizedBox(height: 16),
                _SyncRow(
                  dateLabel: latest.dateLabel,
                  lastSyncLabel:
                      '${latest.timestamp.day.toString().padLeft(2, '0')}-${_shortMonth(latest.timestamp.month)}-${latest.timestamp.year}',
                ),
                const SizedBox(height: 14),
                ...grouped.entries.expand(
                  (entry) => [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 10),
                      child: Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    ...entry.value.map(
                      (record) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TransactionCard(record: record),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }

}

String _shortMonth(int month) {
  const months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return months[month - 1];
}

class _SyncRow extends StatelessWidget {
  const _SyncRow({
    required this.dateLabel,
    required this.lastSyncLabel,
  });

  final String dateLabel;
  final String lastSyncLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            dateLabel,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Text(
          'Last sync :$lastSyncLabel',
          style: const TextStyle(fontSize: 16, color: Color(0xFF8B8B91)),
        ),
        const SizedBox(width: 6),
        const Icon(Icons.refresh_rounded, size: 20, color: Color(0xFF8B8B91)),
      ],
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.record});

  final TransactionRecord record;

  @override
  Widget build(BuildContext context) {
    final amountColor = record.isCredit
        ? AppColors.brandGreen
        : AppColors.danger;
    return InkWell(
      onTap: () => showReceiptDialog(
        context,
        amount: record.amount,
        bankName: record.bankName,
        recipientName: record.recipientName,
        recipientAccount: record.recipientAccount,
      ),
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 16, 12, 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD7D7DC)),
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F7),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: const Color(0xFFE5E5E8)),
                  ),
                  child: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xFF44404F),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.title,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.1,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        record.time,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF8B8B91),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Rs. ${record.amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    color: amountColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 30,
                  color: Color(0xFF4A4458),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHistoryState extends StatelessWidget {
  const _EmptyHistoryState({
    this.title = 'No transactions yet',
    this.subtitle =
        'Completed transfers will appear here automatically.',
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD7D7DC)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.receipt_long_outlined,
            size: 44,
            color: AppColors.brandGreen,
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _EStatementCard extends StatelessWidget {
  const _EStatementCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD0D0D4)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFFFECEC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.picture_as_pdf_rounded,
              color: Color(0xFFEA6E6E),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Download e-statement',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountHeaderCard extends StatelessWidget {
  const _AccountHeaderCard({required this.controller});

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 6, 18, 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: const Color(0xFFD6D6DB), width: 1.5),
        ),
      ),
      child: TabBar(
        controller: controller,
        labelColor: AppColors.textPrimary,
        unselectedLabelColor: const Color(0xFFB4B4B8),
        indicatorColor: AppColors.brandGreen,
        indicatorWeight: 4,
        labelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        tabs: const [
          Tab(text: 'Summary'),
          Tab(text: 'Transaction History'),
        ],
      ),
    );
  }
}

class _SummaryProfileCard extends StatelessWidget {
  const _SummaryProfileCard({
    required this.profile,
    required this.onEditProfile,
  });

  final UserProfileData profile;
  final VoidCallback onEditProfile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0A7768),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: ProfileAvatar(
              profile: profile,
              size: 72,
              fallbackBackgroundColor: Colors.white24,
              fallbackIconColor: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.displayName,
                  style: const TextStyle(
                    fontSize: 23,
                    height: 1.05,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  profile.phoneNumber,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(
                  profile.email,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 6),
                const Text(
                  'IBAN: PK02TMFB0000000067264660',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: onEditProfile,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFBDE7D0)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, size: 16, color: AppColors.brandGreen),
                  SizedBox(width: 6),
                  Text(
                    'Edit',
                    style: TextStyle(fontSize: 15, color: AppColors.textPrimary),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAccountCard extends StatelessWidget {
  const _QuickAccountCard({required this.profile});

  final UserProfileData profile;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E0E4)),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFF6F6F7),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFDCDCDF)),
            ),
            child: const Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'easypaisa Account',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.phoneNumber,
                  style: const TextStyle(fontSize: 16, color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.keyboard_arrow_down_rounded, size: 34),
        ],
      ),
    );
  }
}

class _SimpleLogoLine extends StatelessWidget {
  const _SimpleLogoLine({
    required this.asset,
    required this.fallback,
    required this.height,
  });

  final String asset;
  final Widget fallback;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      height: height,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => fallback,
    );
  }
}

class EasyPaisaWordmark extends StatelessWidget {
  const EasyPaisaWordmark({super.key, this.height = 42});

  final double height;

  @override
  Widget build(BuildContext context) {
    return _SimpleLogoLine(
      asset: AppAssets.easypaisaWordmark,
      height: height,
      fallback: const _EasyPaisaFallback(),
    );
  }
}

class _EasyPaisaFallback extends StatelessWidget {
  const _EasyPaisaFallback();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 22.5.ui,
              height: 22.5.ui,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.textPrimary,
                  width: 5.25.ui,
                ),
                shape: BoxShape.circle,
              ),
            ),
            Positioned(
              bottom: 2.25.ui,
              child: Container(
                width: 22.5.ui,
                height: 10.5.ui,
                decoration: const BoxDecoration(
                  color: AppColors.brandGreen,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(width: 6.ui),
        const Text(
          'easypaisa',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -1.0,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class DigitalBankWordmark extends StatelessWidget {
  const DigitalBankWordmark({super.key, this.height = 152});

  final double height;

  @override
  Widget build(BuildContext context) {
    return _SimpleLogoLine(
      asset: AppAssets.digitalBankLogo,
      height: height,
      fallback: const _DigitalBankFallback(),
    );
  }
}

class SimpleAppBar extends StatelessWidget {
  const SimpleAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.rightText,
    this.rightWidget,
    this.backgroundColor = Colors.white,
    this.titleColor = AppColors.textPrimary,
  });

  final String title;
  final VoidCallback? onBack;
  final String? rightText;
  final Widget? rightWidget;
  final Color backgroundColor;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: 54.ui,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 3.ui,
                child: IconButton(
                  onPressed: onBack ?? () => Navigator.of(context).maybePop(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 25.5.ui,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22.5,
                    fontWeight: FontWeight.w500,
                    color: titleColor,
                  ),
                ),
              ),
              Positioned(
                right: 13.5.ui,
                child:
                    rightWidget ??
                    (rightText == null
                        ? SizedBox(width: 36.ui, height: 36.ui)
                        : Text(
                            rightText!,
                            style: const TextStyle(
                              fontSize: 19.5,
                              color: AppColors.textPrimary,
                            ),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CashPointsScreen extends StatelessWidget {
  const CashPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Cash Points',
      subtitle: 'This tab is ready for the next screen we wire up.',
      icon: Icons.location_on_outlined,
    );
  }
}

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlaceholderScreen(
      title: 'Promotions',
      subtitle: 'This area is reserved for promotional cards and offers.',
      icon: Icons.campaign_outlined,
    );
  }
}

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: const Center(
        child: Text(
          'Coming soon',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 116,
                height: 116,
                decoration: BoxDecoration(
                  color: AppColors.brandGreen.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 72, color: AppColors.brandGreen),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  color: AppColors.textSecondary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeviceSessionData {
  const DeviceSessionData({
    required this.deviceId,
    required this.deviceLabel,
    required this.deviceName,
    required this.platform,
    required this.email,
    required this.displayName,
    required this.accountId,
    required this.isAdmin,
    required this.isActive,
    required this.logoutRequested,
    required this.lastSeenAt,
  });

  final String deviceId;
  final String deviceLabel;
  final String deviceName;
  final String platform;
  final String email;
  final String displayName;
  final String accountId;
  final bool isAdmin;
  final bool isActive;
  final bool logoutRequested;
  final DateTime? lastSeenAt;

  factory DeviceSessionData.fromFirestore(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data();
    return DeviceSessionData(
      deviceId: (data['deviceId'] as String?)?.trim().isNotEmpty == true
          ? (data['deviceId'] as String).trim()
          : doc.id,
      deviceLabel: (data['deviceLabel'] as String?)?.trim().isNotEmpty == true
          ? (data['deviceLabel'] as String).trim()
          : 'Device',
      deviceName: (data['deviceName'] as String?)?.trim().isNotEmpty == true
          ? (data['deviceName'] as String).trim()
          : (data['deviceLabel'] as String?)?.trim().isNotEmpty == true
              ? (data['deviceLabel'] as String).trim()
              : 'Device',
      platform: (data['platform'] as String?)?.trim() ?? 'unknown',
      email: (data['email'] as String?)?.trim() ?? '',
      displayName: (data['displayName'] as String?)?.trim() ?? '',
      accountId: (data['accountId'] as String?)?.trim() ?? '',
      isAdmin: data['isAdmin'] == true,
      isActive: data['isActive'] != false,
      logoutRequested: data['logoutRequested'] == true,
      lastSeenAt: (data['lastSeenAt'] as Timestamp?)?.toDate(),
    );
  }
}

class AdminPanelScreen extends StatelessWidget {
  const AdminPanelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (!isAdminEmail(currentUser?.email)) {
      return Scaffold(
        appBar: AppBar(title: const Text('Admin Panel')),
        body: const Center(
          child: Text(
            'You do not have admin access.',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      appBar: AppBar(
        title: const Text('Admin Panel'),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('device_sessions')
            .orderBy('lastSeenAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.brandGreen),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Unable to load device sessions.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final sessions = (snapshot.data?.docs ?? const [])
              .map(DeviceSessionData.fromFirestore)
              .toList();

          if (sessions.isEmpty) {
            return const Center(
              child: Text(
                'No device sessions yet.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: sessions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final session = sessions[index];
              final lastSeen = session.lastSeenAt == null
                  ? 'Unknown'
                  : '${session.lastSeenAt!.year}-${session.lastSeenAt!.month.toString().padLeft(2, '0')}-${session.lastSeenAt!.day.toString().padLeft(2, '0')}';
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            session.deviceName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Chip(
                          label: Text(session.isActive ? 'Active' : 'Signed out'),
                          backgroundColor: session.isActive
                              ? const Color(0xFFE3F8EC)
                              : const Color(0xFFF2F2F4),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text('Email: ${session.email}'),
                    Text('Device ID: ${session.deviceId}'),
                    Text('Account ID: ${session.accountId.isEmpty ? "-" : session.accountId}'),
                    Text('Platform: ${session.platform}'),
                    Text('Last seen: $lastSeen'),
                    if (session.logoutRequested)
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          'Logout requested',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.danger,
                          ),
                        ),
                      ),
                    if (session.isAdmin) ...[
                      const SizedBox(height: 6),
                      const Text(
                        'Admin device',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.brandGreenDark,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton.icon(
                        onPressed: session.isActive && !session.logoutRequested
                            ? () async {
                                await requestDeviceLogout(
                                  deviceId: session.deviceId,
                                  email: session.email,
                                );
                              }
                            : null,
                        icon: const Icon(Icons.logout_rounded, size: 18),
                        label: const Text('Log out device'),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
