import 'package:flutter/material.dart';
import 'app_colors.dart'; // Ensure this exists and includes AppColors.white

class AppTextStyles {
  static const TextStyle heading20White = TextStyle(
    fontFamily: 'Poppins',

    fontSize: 20,
    color: AppColors.textPrimary,
  );

  static const TextStyle body16 = TextStyle(
    fontFamily: 'Poppins',

    fontSize: 16,
    color: AppColors.textPrimary, // You should define this in AppColors
  );
  static const TextStyle body14 = TextStyle(
    fontFamily: 'Poppins',

    fontSize: 14,
    color: AppColors.textSecondary, // You should define this in AppColors
  );
  static const TextStyle heading20 = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    color: AppColors.textPrimary,
  );
  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.black,
  );

  // Add more styles as needed
}
