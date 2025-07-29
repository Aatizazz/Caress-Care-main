import 'package:caress_care/controller/profile_ctrls.dart';
import 'package:caress_care/model/user_model.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/services/profile_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register user
  static Future<void> registerUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String dob,
    required String? gender,
  }) async {
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        dob.isEmpty ||
        gender == null) {
      Get.snackbar('Error', 'All fields are required');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userModel = UserModel(
        uid: credential.user!.uid,
        firstName: firstName,
        lastName: lastName,
        email: email,
        dob: dob,
        gender: gender,
        avatarPath: '',
      );

      final context = Get.context!;
      await Provider.of<ProfileController>(
        context,
        listen: false,
      ).updateUser(userModel);

      Get.offAllNamed(AppRoutes.mood);
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'email-already-in-use':
          msg = 'Email is already registered';
          break;
        case 'invalid-email':
          msg = 'Invalid email format';
          break;
        case 'weak-password':
          msg = 'Password should be at least 6 characters';
          break;
        default:
          msg = e.message ?? 'An unknown error occurred';
      }
      Get.snackbar('Registration Failed', msg);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong during registration');
    }
  }

  // Login user and return UserCredential
  static Future<UserCredential?> loginUser({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required');
      return null;
    }

    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        final context = Get.context!;
        final profileController = Provider.of<ProfileController>(
          context,
          listen: false,
        );

        final profileService = ProfileService(); // ✅ FIXED: use service here
        final loadedUser = await profileService.loadUser();

        if (loadedUser != null) {
          await profileController.updateUser(loadedUser);
        } else {
          final fallbackUser = UserModel(
            uid: user.uid,
            firstName: user.displayName?.split(' ').first ?? 'User',
            lastName: user.displayName?.split(' ').last ?? '',
            email: user.email ?? '',
            dob: '',
            gender: '',
            avatarPath: '',
          );

          await profileController.updateUser(fallbackUser);
        }

        return credential;
      }
    } on FirebaseAuthException catch (e) {
      String msg;
      switch (e.code) {
        case 'invalid-email':
          msg = 'Invalid email format';
          break;
        case 'user-not-found':
          msg = 'No user found for that email';
          break;
        case 'wrong-password':
          msg = 'Incorrect password';
          break;
        default:
          msg = e.message ?? 'An unknown error occurred';
      }
      Get.snackbar('Login Failed', msg);
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong during login');
    }

    return null; // login failed
  }

  // Reset password
  static Future<void> resetPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar('Success', 'Password reset email sent');
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Could not send reset email');
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong during password reset');
    }
  }
}
