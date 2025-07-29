import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/customs/custom_text_feild.dart';
import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/services/auth_service.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:caress_care/controller/profile_ctrls.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailCtrl = TextEditingController();
  final pwCtrl = TextEditingController();
  bool isLoggingIn = false;

  @override
  void dispose() {
    emailCtrl.dispose();
    pwCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.mainGradient),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Image.asset(
                    Assets.images.calmZoneLogo.path,
                    width: 300,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Welcome Back!',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading20White,
                ),
                const SizedBox(height: 20),

                /// Email Input
                CustomTextField(
                  controller: emailCtrl,
                  hintText: 'Enter Your Email',
                ),
                const SizedBox(height: 10),

                /// Password Input
                CustomTextField(
                  controller: pwCtrl,
                  isPassword: true,
                  hintText: 'Enter Your Password',
                ),
                const SizedBox(height: 20),

                /// Login Button
                isLoggingIn
                    ? const CircularProgressIndicator(color: Colors.white)
                    : CustomButton(
                      text: "Login",
                      onTap: () async {
                        if (!mounted) return;
                        setState(() => isLoggingIn = true);

                        try {
                          final userCredential = await AuthService.loginUser(
                            email: emailCtrl.text.trim(),
                            password: pwCtrl.text.trim(),
                          );

                          if (userCredential != null) {
                            await Provider.of<ProfileController>(
                              context,
                              listen: false,
                            ).loadUser();

                            if (mounted) {
                              Get.offAllNamed(AppRoutes.home);
                            }
                          } else {
                            Get.snackbar(
                              "Login Failed",
                              "Invalid email or password.",
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        } catch (e) {
                          Get.snackbar(
                            "Login Error",
                            e.toString(),
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                        } finally {
                          if (mounted) {
                            setState(() => isLoggingIn = false);
                          }
                        }
                      },
                    ),

                const SizedBox(height: 30),

                /// Registration Text
                Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    style: AppTextStyles.body16,
                    children: [
                      TextSpan(
                        text: 'Register',
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(AppRoutes.register);
                              },
                        style: AppTextStyles.body16.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
