// ignore_for_file: deprecated_member_use

import 'package:caress_care/glass_box.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class DoctorRefScreen extends StatelessWidget {
  const DoctorRefScreen({super.key});

  static const List<Map<String, String>> dummyDoctors = [
    {
      "name": "Dr. Sarah Ali",
      "specialization": "Psychiatrist",
      "contact": "+92 300 1234567",
      "image":
          "https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=500&q=60",
      "experience": "12 years",
      "hospital": "City Hospital, Lahore",
      "about":
          "Expert in anxiety, depression, and mood disorders. Empathetic listener and CBT specialist.",
    },
    {
      "name": "Dr. Hamza Khan",
      "specialization": "Clinical Psychologist",
      "contact": "+92 345 9876543",
      "image":
          "https://plus.unsplash.com/premium_photo-1661634265749-20267b28e13d?w=500&auto=format&fit=crop&q=60",
      "experience": "8 years",
      "hospital": "Mind Care Clinic, Islamabad",
      "about":
          "Specializes in adolescent therapy and stress management. Uses modern therapy techniques.",
    },
    {
      "name": "Dr. Ayesha Noor",
      "specialization": "Therapist",
      "contact": "+92 333 4567890",
      "image":
          "https://images.unsplash.com/photo-1638202993928-7267aad84c31?w=500&auto=format&fit=crop&q=60",
      "experience": "10 years",
      "hospital": "Wellness Center, Islamabad",
      "about":
          "Focus on family counseling and trauma recovery. Known for her compassionate approach.",
    },
    {
      "name": "Dr. Bilal Ahmed",
      "specialization": "Psychiatrist",
      "contact": "+92 321 1122334",
      "image":
          "https://images.unsplash.com/photo-1612531386530-97286d97c2d2?w=500&auto=format&fit=crop&q=60",
      "experience": "15 years",
      "hospital": "Punjab Medical Complex, Islamabad",
      "about":
          "Renowned for treating severe mental illnesses and addiction recovery.",
    },
    {
      "name": "Dr. Maria Siddiqui",
      "specialization": "Clinical Psychologist",
      "contact": "+92 300 9988776",
      "image":
          "https://images.unsplash.com/photo-1659353888906-adb3e0041693?w=500&auto=format&fit=crop&q=60",
      "experience": "7 years",
      "hospital": "Hope Clinic, Islamabad",
      "about": "Expert in cognitive behavioral therapy and mindfulness.",
    },
    {
      "name": "Dr. Usman Tariq",
      "specialization": "Therapist",
      "contact": "+92 322 3344556",
      "image":
          "https://plus.unsplash.com/premium_photo-1664476459351-59625a0fef11?w=500&auto=format&fit=crop&q=60",
      "experience": "9 years",
      "hospital": "Peace Hospital, Islamabad",
      "about": "Focuses on relationship counseling and anger management.",
    },
    {
      "name": "Dr. Sana Javed",
      "specialization": "Psychiatrist",
      "contact": "+92 301 4455667",
      "image":
          "https://images.pexels.com/photos/19596247/pexels-photo-19596247.jpeg",
      "experience": "11 years",
      "hospital": "Shifa International, Islamabad",
      "about":
          "Specializes in women’s mental health and postpartum depression.",
    },
  ];

  void _launchCaller(String phoneNumber) async {
    final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
    var status = await Permission.phone.status;
    if (!status.isGranted) {
      status = await Permission.phone.request();
    }

    if (status.isGranted) {
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar("Error", "Cannot open dialer for this number.");
      }
    } else {
      Get.snackbar("Permission Denied", "Phone call permission is required.");
    }
  }

  void showDoctorPopup(BuildContext context, Map<String, String> doctor) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "DoctorProfile",
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder:
          (context, _, __) => Center(
            child: Material(
              color: Colors.transparent,
              child: GlassBox(
                borderRadius: 30,
                padding: const EdgeInsets.all(20),
                blurSigma: 30,
                color: Colors.white.withOpacity(0.2),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close, color: Colors.black87),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            doctor["image"] ?? "",
                            width: 100,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          doctor["name"] ?? "",
                          style: AppTextStyles.body16.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          doctor["specialization"] ?? "",
                          style: AppTextStyles.body14.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.local_hospital,
                              size: 16,
                              color: Colors.pink,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                doctor["hospital"] ?? "",
                                style: AppTextStyles.body14.copyWith(
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          doctor["about"] ?? "",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body14.copyWith(
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton.icon(
                          onPressed:
                              () => _launchCaller(doctor["contact"] ?? ""),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B2FF7),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.phone, color: Colors.white),
                          label: const Text(
                            "Call Now",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: AppColors.mainGradient),
          ),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => Get.back(),
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    "Doctor Reference",
                    style: AppTextStyles.heading20,
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: AppColors.mainGradient),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          itemCount: dummyDoctors.length,
          itemBuilder: (context, index) {
            final doctor = dummyDoctors[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => showDoctorPopup(context, doctor),
                child: GlassBox(
                  padding: const EdgeInsets.all(16),
                  borderRadius: 20,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          doctor["image"] ?? "",
                          width: 70,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                width: 70,
                                height: 90,
                                color: Colors.grey[300],
                                child: const Icon(
                                  Icons.person,
                                  size: 38,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor["name"] ?? "",
                              style: AppTextStyles.body16.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              doctor["specialization"] ?? "",
                              style: AppTextStyles.body14.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(
                                  Icons.work,
                                  size: 15,
                                  color: Colors.indigo,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  doctor["experience"] ?? "",
                                  style: AppTextStyles.body14.copyWith(
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.local_hospital,
                                  size: 15,
                                  color: Colors.pink,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    doctor["hospital"] ?? "",
                                    style: AppTextStyles.body14.copyWith(
                                      fontSize: 13,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              doctor["about"] ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.body14.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
