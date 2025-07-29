// Make sure the following import points to the file where ProfileController is defined
// If the class is named differently or in another file, update the import accordingly.
import 'package:caress_care/controller/profile_ctrls.dart';
import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:caress_care/view/screens/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_init) {
      Provider.of<ProfileController>(context, listen: false).loadUser();
      _init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProfileController>(context);

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: AppColors.mainGradient),
        ),
        child: SafeArea(
          child:
              controller.user == null
                  ? const Center(
                    child: CircularProgressIndicator(color: AppColors.white),
                  )
                  : Container(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 4),
                        Row(
                          spacing: 14,
                          children: [
                            IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.arrow_back_ios),
                            ),
                            Text(
                              "Profile Screen",
                              style: AppTextStyles.heading20,
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Center(
                          child: CircleAvatar(
                            radius: 72,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                controller.user?.avatarPath != null &&
                                        controller.user!.avatarPath!.isNotEmpty
                                    ? FileImage(
                                      File(controller.user!.avatarPath!),
                                    )
                                    : (controller.user?.avatarPath != null &&
                                            controller
                                                .user!
                                                .avatarPath!
                                                .isNotEmpty
                                        ? NetworkImage(
                                          controller.user!.avatarPath!,
                                        )
                                        : null),
                            child:
                                ((controller.user?.avatarPath == null ||
                                            controller
                                                .user!
                                                .avatarPath!
                                                .isEmpty) &&
                                        (controller.user?.avatarPath == null ||
                                            controller
                                                .user!
                                                .avatarPath!
                                                .isEmpty))
                                    ? Icon(
                                      Icons.person,
                                      size: 50,
                                      color: AppColors.textPrimary,
                                    )
                                    : null,
                          ),
                        ),
                        Text(
                          '${controller.user!.firstName} ${controller.user!.lastName}',
                          style: AppTextStyles.heading20White,
                        ),
                        const SizedBox(height: 10),
                        ProfileField(
                          label: "",
                          value: controller.user!.firstName,
                        ),
                        ProfileField(
                          label: "",
                          value: controller.user!.lastName,
                        ),
                        ProfileField(label: "", value: controller.user!.dob),
                        ProfileField(label: "", value: controller.user!.gender),
                        Spacer(),
                        CustomButton(
                          text: "Edit Profile",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EditProfileScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 16),
                        CustomButton(
                          text: "Logout",
                          onTap: () async {
                            await FirebaseAuth.instance.signOut();
                            Get.offAllNamed(AppRoutes.login);
                          },
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String? value;

  const ProfileField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text('$label  ', style: AppTextStyles.body16.copyWith(fontSize: 18)),
          Expanded(
            child: Text(
              value ?? '-',
              style: AppTextStyles.body14.copyWith(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
