import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:caress_care/controller/profile_ctrls.dart';
import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/customs/custom_text_feild.dart';
import 'package:caress_care/model/user_model.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final dobCtrl = TextEditingController();
  String? selectedGender;
  File? _pickedImage;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<ProfileController>(context, listen: false).user;
    if (user != null) {
      firstNameCtrl.text = user.firstName ?? '';
      lastNameCtrl.text = user.lastName ?? '';
      emailCtrl.text = user.email ?? '';
      dobCtrl.text = user.dob ?? '';
      selectedGender =
          ['Male', 'Female', 'Other'].contains(user.gender)
              ? user.gender
              : null;
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProfileController>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: AppColors.mainGradient),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => Get.back(),
                                icon: const Icon(Icons.arrow_back_ios),
                              ),
                              Text(
                                " Edit Profile",
                                style: AppTextStyles.heading20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 62,
                                  backgroundColor: AppColors.gradientTop,
                                  backgroundImage:
                                      _pickedImage != null
                                          ? FileImage(_pickedImage!)
                                          : (controller.user?.avatarPath !=
                                                  null &&
                                              controller
                                                  .user!
                                                  .avatarPath!
                                                  .isNotEmpty)
                                          ? NetworkImage(
                                            controller.user!.avatarPath!,
                                          )
                                          : null as ImageProvider?,
                                  child:
                                      (_pickedImage == null &&
                                              (controller.user?.avatarPath ==
                                                      null ||
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
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: _pickImage,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: AppColors.gradientMid,
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            controller: firstNameCtrl,
                            hintText: 'First Name',
                          ),
                          CustomTextField(
                            controller: lastNameCtrl,
                            hintText: 'Last Name',
                          ),
                          CustomTextField(
                            controller: emailCtrl,
                            hintText: 'Email',
                          ),
                          GestureDetector(
                            onTap: () async {
                              final pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  dobCtrl.text = DateFormat(
                                    'MMMM dd, yyyy',
                                  ).format(pickedDate);
                                });
                              }
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: dobCtrl,
                                hintText: 'Select Date of Birth',
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.white,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonFormField<String>(
                              value: selectedGender,
                              hint: const Text('Select Gender'),
                              dropdownColor: AppColors.white,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                              ),
                              items:
                                  ['Male', 'Female', 'Other']
                                      .map(
                                        (gender) => DropdownMenuItem<String>(
                                          value: gender,
                                          child: Text(gender),
                                        ),
                                      )
                                      .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value;
                                });
                              },
                            ),
                          ),
                          const Spacer(),

                          /// ✅ Save Button
                          CustomButton(
                            onTap: () async {
                              final uid =
                                  FirebaseAuth.instance.currentUser?.uid;
                              if (uid == null) {
                                Get.snackbar("Error", "User not logged in.");
                                return;
                              }

                              String? imageUrl;
                              try {
                                if (_pickedImage != null) {
                                  final ref = FirebaseStorage.instance
                                      .ref()
                                      .child('user_profiles/$uid.jpg');

                                  await ref.putFile(_pickedImage!);
                                  imageUrl = await ref.getDownloadURL();
                                }
                              } catch (e) {
                                Get.snackbar(
                                  "Upload Failed",
                                  e.toString(),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              final updatedUser = UserModel(
                                uid: uid,
                                firstName: firstNameCtrl.text.trim(),
                                lastName: lastNameCtrl.text.trim(),
                                email: emailCtrl.text.trim(),
                                dob: dobCtrl.text.trim(),
                                gender: selectedGender ?? '',
                                avatarPath:
                                    imageUrl ??
                                    controller.user?.avatarPath ??
                                    '',
                              );

                              try {
                                await controller.updateUser(updatedUser);
                                Get.snackbar(
                                  "Success",
                                  "Profile updated!",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                );
                                Get.back();
                              } catch (e) {
                                Get.snackbar(
                                  "Update Error",
                                  e.toString(),
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            },
                            text: "Save",
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
