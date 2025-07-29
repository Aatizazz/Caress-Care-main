import 'dart:async';
import 'dart:io';
import 'package:caress_care/routes/app_routes.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:caress_care/glass_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:caress_care/controller/profile_ctrls.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ModSelectionScreen extends StatefulWidget {
  const ModSelectionScreen({super.key});

  @override
  State<ModSelectionScreen> createState() => _ModSelectionScreenState();
}

class _ModSelectionScreenState extends State<ModSelectionScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _quotes = [
    "You are stronger than you think.",
    "Keep going. You're doing great!",
    "Small steps every day lead to big change.",
    "Your mental health matters.",
    "Believe in your inner calm.",
  ];

  int _currentQuoteIndex = 0;
  Timer? _quoteTimer;
  late AnimationController _controller;
  late Animation<Offset> _slideUp;

  @override
  void initState() {
    super.initState();
    _quoteTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideUp = Tween<Offset>(
      begin: const Offset(0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _quoteTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child:
              GlassBox(
                padding: const EdgeInsets.all(20),
                borderRadius: 30,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16),
                        Image.asset(
                              'assets/images/calm_zone_logo.png',
                              height: 100,
                            )
                            .animate(
                              onPlay:
                                  (controller) =>
                                      controller.repeat(reverse: true),
                            )
                            .scale(
                              begin: const Offset(1, 1),
                              end: const Offset(1.3, 1.3),
                            )
                            .fade(begin: 0.3, end: 1.0),
                        const SizedBox(height: 16),
                        Text(
                          "Caress Care",
                          style: AppTextStyles.heading20.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "This app helps you track your mood, stay motivated, and connect with emotional care tools. It's your companion in mental wellness.",
                          style: AppTextStyles.body16.copyWith(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ).animate().fade(duration: const Duration(milliseconds: 300)).scale(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<ProfileController>(context).user;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: AppColors.mainGradient,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  /// --- Header ---
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            'Welcome back, ${user?.firstName ?? "User"}',
                            style: AppTextStyles.heading20.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.profileScreen),
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: AppColors.gradientMid,
                            backgroundImage:
                                (user?.avatarPath != null &&
                                        user!.avatarPath!.isNotEmpty)
                                    ? (user.avatarPath!.startsWith('http')
                                        ? NetworkImage(user.avatarPath!)
                                        : FileImage(File(user.avatarPath!))
                                            as ImageProvider)
                                    : null,
                            child:
                                (user?.avatarPath == null ||
                                        user!.avatarPath!.isEmpty)
                                    ? const Icon(
                                      Icons.person,
                                      color: AppColors.textPrimary,
                                    )
                                    : null,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// --- Quote Box ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SizedBox(
                      height: 140,
                      child: GlassBox(
                        borderRadius: 30,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 600),
                            child: Text(
                              _quotes[_currentQuoteIndex],
                              key: ValueKey(_quotes[_currentQuoteIndex]),
                              style: AppTextStyles.body16.copyWith(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                  Text(
                    "How's your mood today?",
                    style: AppTextStyles.heading20.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  /// --- Mood Options ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: const [
                        Expanded(
                          child: MoodOption(
                            mood: 'Happy',
                            emoji: '😊',
                            onTap: AppRoutes.motivation,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: MoodOption(
                            mood: 'Sad',
                            emoji: '😞',
                            onTap: AppRoutes.checklistScreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// --- Bottom Navigation ---
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: SlideTransition(
              position: _slideUp,
              child: GlassBox(
                borderRadius: 30,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _NavButton(
                      icon: Icons.book_rounded,
                      label: "Journal",
                      onTap: () => Get.toNamed(AppRoutes.journal),
                    ),
                    _NavButton(
                      icon: Icons.people_rounded,
                      label: "Community",
                      onTap: () => Get.toNamed(AppRoutes.community),
                    ),
                    _NavButton(
                      icon: Icons.info_rounded,
                      label: "About",
                      onTap: () => _showAboutDialog(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class MoodOption extends StatelessWidget {
  final String mood;
  final String emoji;
  final String onTap;

  const MoodOption({
    super.key,
    required this.mood,
    required this.emoji,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(onTap),
      child: GlassBox(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BouncingEmoji(emoji: emoji),
            const SizedBox(height: 12),
            Text(
              mood,
              style: AppTextStyles.body16.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BouncingEmoji extends StatefulWidget {
  final String emoji;

  const BouncingEmoji({super.key, required this.emoji});

  @override
  State<BouncingEmoji> createState() => _BouncingEmojiState();
}

class _BouncingEmojiState extends State<BouncingEmoji>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _bounce;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat(reverse: true);

    _bounce = Tween<double>(
      begin: 0.0,
      end: -6.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _bounce,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounce.value),
          child: Text(widget.emoji, style: const TextStyle(fontSize: 50)),
        );
      },
    );
  }
}
