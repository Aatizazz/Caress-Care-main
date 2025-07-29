import 'package:caress_care/controller/mod_ctrl.dart';
import 'package:caress_care/customs/custom_button.dart';
import 'package:caress_care/glass_box.dart';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen>
    with TickerProviderStateMixin {
  late final ChecklistController controller;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  Map<int, bool> expandedMap = {};

  @override
  void initState() {
    super.initState();
    controller = ChecklistController();
    controller.addListener(() => setState(() {}));

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    controller.removeListener(() {});
    _fadeController.dispose();
    super.dispose();
  }

  void handleSubmit() {
    final totalSelected = controller.totalSelected;

    Get.snackbar(
      "Checklist Completed",
      "You selected $totalSelected symptoms",
      backgroundColor: Colors.white,
      colorText: Colors.black,
    );

    if (totalSelected < 15) {
      Get.toNamed(AppRoutes.videoRefScreen);
    } else {
      Get.toNamed(AppRoutes.doctorRefScreen);
    }
  }

  Color getGlowColor(int index) {
    switch (index) {
      case 0:
        return Colors.blueAccent.withOpacity(0.5);
      case 1:
        return Colors.purpleAccent.withOpacity(0.5);
      case 2:
        return Colors.redAccent.withOpacity(0.5);
      default:
        return Colors.grey;
    }
  }

  List<List<dynamic>> get categories => [
    ['Anxiety Symptoms', controller.anxietyList],
    ['Depression Symptoms', controller.depressionList],
    ['Stress Symptoms', controller.stressList],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 8,
                  bottom: 8,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: AppColors.mainGradient),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.black,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Mental Health Checklist',
                        style: AppTextStyles.heading20,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: AppColors.mainGradient),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 120,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final title = categories[index][0] as String;
                      final questions = categories[index][1] as List;
                      final isExpanded = expandedMap[index] ?? false;
                      final displayList =
                          isExpanded ? questions : questions.take(4).toList();

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: GlassBox(
                              borderRadius: 20,
                              borderColor: getGlowColor(index),
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: AppTextStyles.body16.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizeTransition(
                                    sizeFactor: _fadeAnimation,
                                    child: Column(
                                      children: [
                                        ...displayList.map(
                                          (q) => AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            switchInCurve: Curves.easeInOut,
                                            switchOutCurve: Curves.easeInOut,
                                            transitionBuilder:
                                                (child, animation) =>
                                                    ScaleTransition(
                                                      scale: animation,
                                                      child: FadeTransition(
                                                        opacity: animation,
                                                        child: child,
                                                      ),
                                                    ),
                                            child: CheckboxListTile(
                                              key: ValueKey(q.isSelected),
                                              title: Text(
                                                q.text,
                                                style: AppTextStyles.body16,
                                              ),
                                              value: q.isSelected,
                                              activeColor: Colors.green,
                                              checkColor: AppColors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(22),
                                              ),
                                              onChanged: (val) {
                                                setState(
                                                  () =>
                                                      q.isSelected =
                                                          val ?? false,
                                                );
                                              },
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                              contentPadding: EdgeInsets.zero,
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                expandedMap[index] =
                                                    !(expandedMap[index] ??
                                                        false);
                                              });
                                            },
                                            icon: Icon(
                                              (expandedMap[index] ?? false)
                                                  ? Icons.expand_less
                                                  : Icons.expand_more,
                                              color: const Color(0xFF4A6FA5),
                                            ),
                                            label: Text(
                                              (expandedMap[index] ?? false)
                                                  ? 'Show Less'
                                                  : 'Show More',
                                              style: const TextStyle(
                                                color: Color(0xFF4A6FA5),
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .animate()
                            .fade(duration: 500.ms)
                            .scaleXY(duration: 500.ms),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          // Floating bottom progress box
          Positioned(
            left: 24,
            right: 24,
            bottom: 20,
            child: GlassBox(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              borderRadius: 20,
              blurSigma: 30,
              color: Colors.white.withOpacity(0.04),
              child: Row(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end:
                          controller.totalSelected /
                          (controller.anxietyList.length +
                              controller.depressionList.length +
                              controller.stressList.length),
                    ),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, value, _) {
                      return SizedBox(
                        width: 50,
                        height: 50,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CircularProgressIndicator(
                              value: value,
                              strokeWidth: 6,
                              backgroundColor: Colors.white.withOpacity(0.1),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.black, // ✅ Changed from green to black
                              ),
                            ),
                            Center(
                              child: Text(
                                "${(value * 100).toInt()}%",
                                style: AppTextStyles.body14.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color:
                                      Colors
                                          .black, // ✅ Changed from green to black
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Checklist Progress',
                          style: AppTextStyles.body14.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${controller.totalSelected} of ${controller.anxietyList.length + controller.depressionList.length + controller.stressList.length} selected",
                          style: AppTextStyles.body14.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 100,
                    child: CustomButton(text: "Submit", onTap: handleSubmit),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
