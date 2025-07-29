import 'dart:math';
import 'package:caress_care/gen/assets.gen.dart';
import 'package:caress_care/utils/const/app_colors.dart';
import 'package:caress_care/utils/const/app_text.dart';
import 'package:caress_care/glass_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoRefScreen extends StatefulWidget {
  const VideoRefScreen({super.key});

  @override
  State<VideoRefScreen> createState() => _VideoRefScreenState();
}

class _VideoRefScreenState extends State<VideoRefScreen> {
  final List<Map<String, String>> youtubeVideos = [
    {
      'title': 'Overcome Anxiety – Motivation',
      'url': 'https://youtu.be/xRxT9cOKiM8',
      'thumbnail': 'https://img.youtube.com/vi/xRxT9cOKiM8/0.jpg',
    },
    {
      'title': 'Self Discipline – Daily Motivation',
      'url': 'https://youtu.be/1dbYduxIpwE',
      'thumbnail': 'https://img.youtube.com/vi/1dbYduxIpwE/0.jpg',
    },
    {
      'title': 'Focus Like a Monk – Motivation',
      'url': 'https://youtu.be/hAkgumAMOIg',
      'thumbnail': 'https://img.youtube.com/vi/hAkgumAMOIg/0.jpg',
    },
    {
      'title': 'Believe in Yourself – Uplifting',
      'url': 'https://youtu.be/H_uc-uQ3Nkc',
      'thumbnail': 'https://img.youtube.com/vi/H_uc-uQ3Nkc/0.jpg',
    },
  ];

  final List<Map<String, String>> activities = [
    {
      'text': 'Try these 5 fingers activite',
      'image': Assets.images.mvtIm1.path,
    },
    {'text': 'Write your thoughts .', 'image': Assets.images.mvtIm2.path},
    {
      'text': 'Dialogue with your inner critic.',
      'image': Assets.images.mvtIm3.path,
    },
    {'text': 'Blow of steam cloud.', 'image': Assets.images.mvtIm4.path},
    {'text': 'Try These activities.', 'image': Assets.images.mvtIm5.path},
    {
      'text': 'Stretch your body gently for 5 minutes.',
      'image': Assets.images.mvtIm6.path,
    },
    {
      'text': 'Drink a glass of water slowly and mindfully.',
      'image': Assets.images.mvtIm7.path,
    },
    {
      'text': 'Read an inspiring quote or passage.',
      'image': Assets.images.mvtIm8.path,
    },
  ];

  late Map<String, String> currentVideo;
  late Map<String, String> currentActivity;
  bool showAllVideos = false;
  bool showAllActivities = false;

  @override
  void initState() {
    super.initState();
    final random = Random();
    currentVideo = youtubeVideos[random.nextInt(youtubeVideos.length)];
    currentActivity = activities[random.nextInt(activities.length)];
  }

  void _launchVideo(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _shuffleSuggestions() {
    final random = Random();
    setState(() {
      currentVideo = youtubeVideos[random.nextInt(youtubeVideos.length)];
      currentActivity = activities[random.nextInt(activities.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: AppColors.mainGradient),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.textPrimary,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    Text('Motivational Space', style: AppTextStyles.heading20),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: AppColors.textPrimary,
                        size: 32,
                      ),
                      onPressed: _shuffleSuggestions,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Motivational Videos',
                            style: AppTextStyles.heading20,
                          ),
                        ),
                        _buildVideoCard(currentVideo),
                        if (showAllVideos)
                          ...youtubeVideos.map(
                            (video) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: _buildVideoCard(video),
                            ),
                          ),
                        TextButton.icon(
                          onPressed:
                              () => setState(
                                () => showAllVideos = !showAllVideos,
                              ),
                          icon: Icon(
                            showAllVideos
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.blue,
                            size: 32,
                          ),
                          label: Text(
                            showAllVideos
                                ? 'Show Less Videos'
                                : 'Show More Videos',
                            style: AppTextStyles.body16.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Divider(
                          height: 30,
                          thickness: 6,
                          color: Colors.blueGrey,
                          radius: BorderRadius.circular(32),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Mindful Activities',
                            style: AppTextStyles.heading20,
                          ),
                        ),
                        if (showAllActivities)
                          ...activities.map(
                            (activity) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: _buildActivityCard(activity),
                            ),
                          )
                        else
                          _buildActivityCard(currentActivity),
                        TextButton.icon(
                          onPressed:
                              () => setState(
                                () => showAllActivities = !showAllActivities,
                              ),
                          icon: Icon(
                            showAllActivities
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.blue,
                            size: 32,
                          ),
                          label: Text(
                            showAllActivities
                                ? 'Show Less Activities'
                                : 'Show More Activities',
                            style: AppTextStyles.body16.copyWith(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard(Map<String, String> video) {
    return GestureDetector(
      onTap: () => _launchVideo(video['url']!),
      child: GlassBox(
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                video['thumbnail']!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                video['title']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityCard(Map<String, String> activity) {
    return GestureDetector(
      onTap: () {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: "Popup",
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => const SizedBox(),
          transitionBuilder: (context, anim1, anim2, child) {
            return Transform.scale(
              scale: anim1.value,
              child: Opacity(
                opacity: anim1.value,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  child: GlassBox(
                    borderRadius: 28,
                    padding: const EdgeInsets.all(12),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                activity['image']!,
                                height: 240,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              activity['text']!,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.body16.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 6,
                          right: 6,
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: const CircleAvatar(
                              radius: 14,
                              backgroundColor: Colors.black54,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 18,
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
          },
        );
      },
      child: GlassBox(
        borderRadius: 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.asset(
                activity['image']!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                activity['text']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
