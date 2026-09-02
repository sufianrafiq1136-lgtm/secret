import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

String initialsFor(String input) {
  final parts = input.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) return '?';
  if (parts.length == 1) {
    final word = parts.first;
    return word.isEmpty ? '?' : word.substring(0, 1).toUpperCase();
  }
  return (parts.first[0] + parts.last[0]).toUpperCase();
}

class UserProfileData {
  const UserProfileData({
    required this.displayName,
    required this.phoneNumber,
    required this.email,
    required this.accountId,
    this.photoBase64,
  });

  final String displayName;
  final String phoneNumber;
  final String email;
  final String accountId;
  final String? photoBase64;

  String get initials => initialsFor(displayName.isEmpty ? 'U' : displayName);

  Uint8List? get photoBytes {
    final raw = photoBase64;
    if (raw == null || raw.isEmpty) return null;
    try {
      return base64Decode(raw);
    } catch (_) {
      return null;
    }
  }

  factory UserProfileData.fallback(User? user, String? accountId) {
    return UserProfileData(
      displayName: _bestProfileName(user?.displayName, user?.email),
      phoneNumber: _bestProfilePhone(user?.phoneNumber),
      email: user?.email?.trim() ?? '',
      accountId: accountId ?? '',
      photoBase64: null,
    );
  }

  factory UserProfileData.fromFirestore(
    Map<String, dynamic>? data,
    User? user,
    String? accountId,
  ) {
    final fallback = UserProfileData.fallback(user, accountId);
    if (data == null) return fallback;
    final rawName = (data['displayName'] as String?)?.trim();
    final rawPhone = (data['phoneNumber'] as String?)?.trim();
    final rawEmail = (data['email'] as String?)?.trim();
    final rawAccountId = (data['accountId'] as String?)?.trim();
    final rawPhotoBase64 = (data['photoBase64'] as String?)?.trim();
    return UserProfileData(
      displayName: (rawName == null || rawName.isEmpty) ? fallback.displayName : rawName,
      phoneNumber: (rawPhone == null || rawPhone.isEmpty) ? fallback.phoneNumber : rawPhone,
      email: (rawEmail == null || rawEmail.isEmpty) ? fallback.email : rawEmail,
      accountId: (rawAccountId == null || rawAccountId.isEmpty)
          ? fallback.accountId
          : rawAccountId,
      photoBase64: (rawPhotoBase64 == null || rawPhotoBase64.isEmpty)
          ? fallback.photoBase64
          : rawPhotoBase64,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'email': email,
        'accountId': accountId,
        if (photoBase64 != null && photoBase64!.isNotEmpty) 'photoBase64': photoBase64,
        'updatedAt': FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> toLocalJson() => {
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'email': email,
        'accountId': accountId,
        'photoBase64': photoBase64,
      };

  factory UserProfileData.fromLocalJson(
    Map<String, dynamic>? data,
    User? user,
    String? accountId,
  ) {
    final fallback = UserProfileData.fallback(user, accountId);
    if (data == null) return fallback;
    final rawName = (data['displayName'] as String?)?.trim();
    final rawPhone = (data['phoneNumber'] as String?)?.trim();
    final rawEmail = (data['email'] as String?)?.trim();
    final rawAccountId = (data['accountId'] as String?)?.trim();
    final rawPhotoBase64 = (data['photoBase64'] as String?)?.trim();
    return UserProfileData(
      displayName: (rawName == null || rawName.isEmpty) ? fallback.displayName : rawName,
      phoneNumber: (rawPhone == null || rawPhone.isEmpty) ? fallback.phoneNumber : rawPhone,
      email: (rawEmail == null || rawEmail.isEmpty) ? fallback.email : rawEmail,
      accountId: (rawAccountId == null || rawAccountId.isEmpty)
          ? fallback.accountId
          : rawAccountId,
      photoBase64: (rawPhotoBase64 == null || rawPhotoBase64.isEmpty)
          ? fallback.photoBase64
          : rawPhotoBase64,
    );
  }
}

String _bestProfileName(String? displayName, String? email) {
  final candidate = displayName?.trim();
  if (candidate != null && candidate.isNotEmpty) return candidate;
  final emailCandidate = email?.trim();
  if (emailCandidate != null && emailCandidate.isNotEmpty) return emailCandidate;
  return 'Guest';
}

String _bestProfilePhone(String? phoneNumber) {
  final candidate = phoneNumber?.trim();
  return (candidate == null || candidate.isEmpty) ? 'Not set' : candidate;
}

String normalizePhoneNumber(String input) {
  final trimmed = input.trim();
  if (trimmed.isEmpty) return '';
  return trimmed.replaceAll(RegExp(r'\s+'), '');
}

const Set<String> kAdminEmails = {
  'sufianrafiq1136@gmail.com',
  'hamzaaley988@gmail.com',
};

bool isAdminEmail(String? email) {
  final normalized = email?.trim().toLowerCase();
  return normalized != null && kAdminEmails.contains(normalized);
}

String _deviceIdPrefsKey() => 'device_session_id';

String _randomDeviceId() {
  final now = DateTime.now().microsecondsSinceEpoch;
  final random = Random().nextInt(1 << 32);
  return base64Url.encode(utf8.encode('${now}_$random'));
}

Future<String> _getOrCreateDeviceId() async {
  final prefs = await SharedPreferences.getInstance();
  final existing = prefs.getString(_deviceIdPrefsKey())?.trim();
  if (existing != null && existing.isNotEmpty) return existing;
  final created = _randomDeviceId();
  await prefs.setString(_deviceIdPrefsKey(), created);
  return created;
}

String _platformLabel() {
  if (kIsWeb) return 'web';
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
      return 'android';
    case TargetPlatform.iOS:
      return 'ios';
    case TargetPlatform.macOS:
      return 'macos';
    case TargetPlatform.windows:
      return 'windows';
    case TargetPlatform.linux:
      return 'linux';
    case TargetPlatform.fuchsia:
      return 'fuchsia';
  }
}

Future<String> _deviceNameForCurrentPlatform() async {
  if (kIsWeb) return 'Web browser';

  final deviceInfo = DeviceInfoPlugin();
  try {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final info = await deviceInfo.androidInfo;
        final model = info.model.trim();
        final manufacturer = info.manufacturer.trim();
        if (manufacturer.isNotEmpty && model.isNotEmpty) {
          return '$manufacturer $model';
        }
        return model.isNotEmpty ? model : 'Android device';
      case TargetPlatform.iOS:
        final info = await deviceInfo.iosInfo;
        final name = info.name.trim();
        final model = info.utsname.machine.trim();
        if (name.isNotEmpty && model.isNotEmpty) return '$name ($model)';
        if (name.isNotEmpty) return name;
        if (model.isNotEmpty) return model;
        return 'iPhone/iPad';
      case TargetPlatform.macOS:
        final info = await deviceInfo.macOsInfo;
        final model = info.model.trim();
        return model.isNotEmpty ? model : 'Mac';
      case TargetPlatform.windows:
        final info = await deviceInfo.windowsInfo;
        final productName = info.productName.trim();
        return productName.isNotEmpty ? productName : 'Windows PC';
      case TargetPlatform.linux:
        final info = await deviceInfo.linuxInfo;
        final prettyName = info.prettyName.trim();
        return prettyName.isNotEmpty ? prettyName : 'Linux PC';
      case TargetPlatform.fuchsia:
        return 'Fuchsia device';
    }
  } catch (_) {
    return '${_platformLabel()} device';
  }
}

String accountIdKeyForEmail(String email) {
  return 'account_id_for_${base64Url.encode(utf8.encode(email.trim().toLowerCase()))}';
}

String profileCacheKeyForEmail(String email) {
  return 'profile_cache_${base64Url.encode(utf8.encode(email.trim().toLowerCase()))}';
}

String profilePhotoCacheKeyForEmail(String email) {
  return 'profile_photo_cache_${base64Url.encode(utf8.encode(email.trim().toLowerCase()))}';
}

String _encodedEmailId(String email) {
  return base64Url.encode(utf8.encode(email.trim().toLowerCase()));
}

Future<String?> activeAccountId() async {
  final currentUser = FirebaseAuth.instance.currentUser;
  final email = currentUser?.email?.trim();
  if (email == null || email.isEmpty) return null;

  final prefs = await SharedPreferences.getInstance();
  final key = accountIdKeyForEmail(email);
  final existing = prefs.getString(key)?.trim();
  if (existing != null && existing.isNotEmpty) {
    await FirebaseFirestore.instance
        .collection('_email_account_ids')
        .doc(_encodedEmailId(email))
        .set({
      'email': email.toLowerCase(),
      'accountId': existing,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    return existing;
  }

  final mappingDoc = FirebaseFirestore.instance
      .collection('_email_account_ids')
      .doc(_encodedEmailId(email));
  final mappingSnapshot = await mappingDoc.get();
  final mappedAccountId = (mappingSnapshot.data()?['accountId'] as String?)?.trim();
  if (mappedAccountId != null && mappedAccountId.isNotEmpty) {
    await prefs.setString(key, mappedAccountId);
    return mappedAccountId;
  }

  final deterministicAccountId = _encodedEmailId(email);
  await prefs.setString(key, deterministicAccountId);
  await mappingDoc.set({
    'email': email.toLowerCase(),
    'accountId': deterministicAccountId,
    'updatedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
  return deterministicAccountId;
}

Future<CollectionReference<Map<String, dynamic>>?> accountCollection(String name) async {
  final accountId = await activeAccountId();
  if (accountId == null) return null;
  return FirebaseFirestore.instance.collection('users').doc(accountId).collection(name);
}

Future<DocumentReference<Map<String, dynamic>>?> userProfileDoc() async {
  final accountId = await activeAccountId();
  if (accountId == null) return null;
  return FirebaseFirestore.instance
      .collection('users')
      .doc(accountId)
      .collection('profile')
      .doc('userProfile');
}

Future<UserProfileData> resolveUserProfile() async {
  final hasFirebaseApp = Firebase.apps.isNotEmpty;
  final currentUser = hasFirebaseApp ? FirebaseAuth.instance.currentUser : null;
  final accountId = hasFirebaseApp ? await activeAccountId() : null;
  if (!hasFirebaseApp || currentUser == null) {
    return UserProfileData.fallback(currentUser, accountId);
  }

  final prefs = await SharedPreferences.getInstance();
  final cacheKey = profileCacheKeyForEmail(currentUser.email ?? '');
  final cachedRaw = prefs.getString(cacheKey);
  if (cachedRaw != null && cachedRaw.isNotEmpty) {
    try {
      final decoded = jsonDecode(cachedRaw);
      if (decoded is Map) {
        var localProfile = UserProfileData.fromLocalJson(
          Map<String, dynamic>.from(decoded),
          currentUser,
          accountId,
        );
        final cachedPhoto = prefs.getString(profilePhotoCacheKeyForEmail(currentUser.email ?? ''));
        if (cachedPhoto != null && cachedPhoto.isNotEmpty && localProfile.photoBase64 == null) {
          localProfile = UserProfileData(
            displayName: localProfile.displayName,
            phoneNumber: localProfile.phoneNumber,
            email: localProfile.email,
            accountId: localProfile.accountId,
            photoBase64: cachedPhoto,
          );
        }
        return localProfile;
      }
    } catch (_) {
      // Fall through to Firestore or fallback.
    }
  }

  final profileDoc = await userProfileDoc();
  if (profileDoc == null) {
    return UserProfileData.fallback(currentUser, accountId);
  }

  final snapshot = await profileDoc.get();
  if (!snapshot.exists) {
    return UserProfileData.fallback(currentUser, accountId);
  }

  return UserProfileData.fromFirestore(snapshot.data(), currentUser, accountId);
}

Future<void> cacheUserProfile(UserProfileData profile) async {
  final prefs = await SharedPreferences.getInstance();
  final email = profile.email.trim().toLowerCase();
  if (email.isEmpty) return;
  await prefs.setString(profileCacheKeyForEmail(email), jsonEncode(profile.toLocalJson()));
  if (profile.photoBase64 != null && profile.photoBase64!.isNotEmpty) {
    await prefs.setString(profilePhotoCacheKeyForEmail(email), profile.photoBase64!);
  } else {
    await prefs.remove(profilePhotoCacheKeyForEmail(email));
  }
}

Future<void> saveUserProfile({
  required UserProfileData profile,
  required String displayName,
  required String phoneNumber,
  String? photoBase64,
}) async {
  final doc = await userProfileDoc();
  if (doc == null) return;
  await doc.set({
    'displayName': displayName.trim(),
    'phoneNumber': normalizePhoneNumber(phoneNumber),
    'email': profile.email,
    'accountId': profile.accountId,
    if (photoBase64 != null && photoBase64.isNotEmpty) 'photoBase64': photoBase64,
    'updatedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));

  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null && displayName.trim().isNotEmpty) {
    await currentUser.updateDisplayName(displayName.trim());
  }

  await cacheUserProfile(
    UserProfileData(
      displayName: displayName.trim(),
      phoneNumber: normalizePhoneNumber(phoneNumber),
      email: profile.email,
      accountId: profile.accountId,
      photoBase64: photoBase64 ?? profile.photoBase64,
    ),
  );
}

Future<void> recordDeviceSession({
  required User? user,
  required String? accountId,
}) async {
  if (user == null) return;
  final email = user.email?.trim();
  if (email == null || email.isEmpty) return;

  final deviceId = await _getOrCreateDeviceId();
  final deviceName = await _deviceNameForCurrentPlatform();
  final sessionDoc = FirebaseFirestore.instance.collection('device_sessions').doc(deviceId);
  await sessionDoc.set({
    'deviceId': deviceId,
    'deviceName': deviceName,
    'deviceLabel': '${_platformLabel()} device',
    'platform': _platformLabel(),
    'email': email.toLowerCase(),
    'displayName': user.displayName?.trim() ?? '',
    'accountId': accountId ?? '',
    'isAdmin': isAdminEmail(email),
    'isActive': true,
    'lastSeenAt': FieldValue.serverTimestamp(),
    'loggedInAt': FieldValue.serverTimestamp(),
    'logoutRequested': false,
    'logoutRequestedAt': null,
  }, SetOptions(merge: true));
}

Future<void> clearDeviceSession({required User? user}) async {
  if (user == null) return;
  final email = user.email?.trim();
  if (email == null || email.isEmpty) return;

  final prefs = await SharedPreferences.getInstance();
  final deviceId = prefs.getString(_deviceIdPrefsKey())?.trim();
  if (deviceId == null || deviceId.isEmpty) return;

  await FirebaseFirestore.instance.collection('device_sessions').doc(deviceId).set({
    'email': email.toLowerCase(),
    'isActive': false,
    'loggedOutAt': FieldValue.serverTimestamp(),
    'lastSeenAt': FieldValue.serverTimestamp(),
    'logoutRequested': false,
    'logoutRequestedAt': null,
  }, SetOptions(merge: true));
}

Future<void> requestDeviceLogout({
  required String deviceId,
  required String email,
}) async {
  await FirebaseFirestore.instance.collection('device_sessions').doc(deviceId).set({
    'email': email.toLowerCase().trim().toLowerCase(),
    'isActive': false,
    'logoutRequested': true,
    'logoutRequestedAt': FieldValue.serverTimestamp(),
    'lastSeenAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}
