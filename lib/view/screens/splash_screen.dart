import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // ✅ User already logged in, go to Home
        Get.offAllNamed(AppRoutes.home);
      } else {
        // 🚪 Not logged in, go to Agreement screen
        Get.offAllNamed(AppRoutes.agreementScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.mainGradient,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Center(
              child: Image.asset(Assets.images.calmZoneLogo.path, width: 300),
            ),
            const SizedBox(height: 30),

            // Title
            Text(
              'Welcome to Calm Zone',
              textAlign: TextAlign.center,
              style: AppTextStyles.heading20.copyWith(fontSize: 24),
            ),
            const SizedBox(height: 12),

            // Subtitle
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'Track your health, stay fit, and achieve wellness goals effortlessly.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
