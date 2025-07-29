import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    // _checkAgreementStatus();
  }

  // Future<void> _checkAgreementStatus() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final accepted = prefs.getBool('agreementAccepted') ?? false;
  //   if (accepted) {
  //     // Skip this screen if already accepted
  //     Get.offAllNamed(AppRoutes.register);
  //   }
  // }

  Future<void> _onAccept() async {
    if (_isChecked) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('agreementAccepted', true);
      Get.offAllNamed(AppRoutes.register);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.mainGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 20),

                const SizedBox(height: 20),
                Text(
                  'User Agreement',
                  style: AppTextStyles.heading20.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: const Text(
                      '''Calm Zone is committed to providing a safe and supportive platform for young individuals seeking healthcare resources. To ensure age-appropriate use of our services, we enforce the following age policy:

• Only individuals between the ages of 13 and 23 are permitted to create and maintain an account on Calm Zone.

• Users over the age of 23 are not eligible to use the app and must discontinue use immediately upon reaching their 24th birthday.''',
                      style: AppTextStyles.body16,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.green,
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value ?? false;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        'I have read and agree to the terms.',
                        style: AppTextStyles.body16.copyWith(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isChecked ? _onAccept : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gradientMid,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 6,
                    ),
                    child: const Text(
                      'I Accept',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
