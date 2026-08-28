import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  });

  final String displayName;
  final String phoneNumber;
  final String email;
  final String accountId;

  String get initials => initialsFor(displayName.isEmpty ? 'U' : displayName);

  factory UserProfileData.fallback(User? user, String? accountId) {
    return UserProfileData(
      displayName: _bestProfileName(user?.displayName, user?.email),
      phoneNumber: _bestProfilePhone(user?.phoneNumber),
      email: user?.email?.trim() ?? '',
      accountId: accountId ?? '',
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
    return UserProfileData(
      displayName: (rawName == null || rawName.isEmpty) ? fallback.displayName : rawName,
      phoneNumber: (rawPhone == null || rawPhone.isEmpty) ? fallback.phoneNumber : rawPhone,
      email: (rawEmail == null || rawEmail.isEmpty) ? fallback.email : rawEmail,
      accountId: (rawAccountId == null || rawAccountId.isEmpty)
          ? fallback.accountId
          : rawAccountId,
    );
  }

  Map<String, dynamic> toFirestore() => {
        'displayName': displayName,
        'phoneNumber': phoneNumber,
        'email': email,
        'accountId': accountId,
        'updatedAt': FieldValue.serverTimestamp(),
      };
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

String accountIdKeyForEmail(String email) {
  return 'account_id_for_${base64Url.encode(utf8.encode(email.trim().toLowerCase()))}';
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

Future<void> saveUserProfile({
  required UserProfileData profile,
  required String displayName,
  required String phoneNumber,
}) async {
  final doc = await userProfileDoc();
  if (doc == null) return;
  await doc.set({
    'displayName': displayName.trim(),
    'phoneNumber': normalizePhoneNumber(phoneNumber),
    'email': profile.email,
    'accountId': profile.accountId,
    'updatedAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));

  final currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null && displayName.trim().isNotEmpty) {
    await currentUser.updateDisplayName(displayName.trim());
  }
}
