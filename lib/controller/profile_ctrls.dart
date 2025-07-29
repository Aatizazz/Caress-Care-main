import 'package:caress_care/services/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

class ProfileController extends ChangeNotifier {
  UserModel? user;

  // ✅ Made public to fix "red line under service"
  final ProfileService service = ProfileService();

  /// Loads the user from Firestore using FirebaseAuth UID
  Future<void> loadUser() async {
    user = await service.loadUser();
    notifyListeners();
  }

  /// Updates and saves the user data to Firestore with UID fallback
  Future<void> updateUser(UserModel updatedUser) async {
    if (updatedUser.uid == null) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        updatedUser = updatedUser.copyWith(uid: currentUser.uid);
      } else {
        return; // Cannot proceed without UID
      }
    }

    user = updatedUser;
    await service.saveUser(updatedUser);
    notifyListeners();
  }

  /// Clears local user state and Firestore entry (if implemented)
  Future<void> clearUser() async {
    user = null;
    await service.clearUser();
    notifyListeners();
  }
}
