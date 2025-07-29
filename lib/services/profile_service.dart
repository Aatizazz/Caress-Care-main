import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';

class ProfileService {
  static const String _userKey = 'user';
  final _firestore = FirebaseFirestore.instance;

  /// Save user data to Firestore and cache locally
  Future<void> saveUser(UserModel user) async {
    if (user.uid == null) return;

    final userMap = user.toJson();

    try {
      // Save to Firestore
      await _firestore.collection('users').doc(user.uid).set(userMap);

      // Cache locally
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonEncode(userMap));
    } catch (e) {
      print('Error saving user: $e');
    }
  }

  /// Load user data from Firestore if available, fallback to cache
  Future<UserModel?> loadUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) return null;

    try {
      final doc =
          await _firestore.collection('users').doc(currentUser.uid).get();

      if (doc.exists && doc.data() != null) {
        final user = UserModel.fromJson(doc.data()!);

        // Cache it for offline use
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_userKey, jsonEncode(user.toJson()));

        return user;
      }
    } catch (e) {
      print('Error fetching user from Firestore: $e');
    }

    // Fallback to local cache
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    }

    return null;
  }

  /// Clears locally cached user data
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
