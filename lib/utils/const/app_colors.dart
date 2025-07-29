import 'package:flutter/material.dart';

class AppColors {
  // Primary Gradient Colors (Soft Pastel Elegance)
  static const Color gradientTop = Color(
    0xFFDAD6FF,
  ); // Lavender Mist (very soft purple)
  static const Color gradientMid = Color(
    0xFFA3CEF1,
  ); // Powder Blue (soft pastel blue)
  static const Color gradientBottom = Color(
    0xFFFFC1CC,
  ); // Blush Pink (soft pastel pink)

  /// Gradient List used in background decorations
  static const List<Color> mainGradient = [gradientTop, gradientMid];

  // Background and Surface Colors
  static const Color deepPurple = Color(
    0xFFFFE5CC,
  ); // Soft Peach (warm pastel peach)
  static const Color background = Color(
    0xFFF7F8FA,
  ); // Extra Light Gray (clean, subtle)
  static const Color white = Colors.white; // Pure White

  // Shadows
  static const Color shadow = Color(
    0x22000000,
  ); // Soft black shadow (transparent)

  // Neutral Colors
  static const Color black = Color(
    0xFF1A1A1A,
  ); // Almost black, less harsh than pure black
  static const Color grey = Color(0xFF8A8A8A); // Soft medium gray
  static const Color lightgrey = Color(
    0xFFE1E1E1,
  ); // Light gray for subtle UI elements

  // Text Colors
  static const Color textPrimary = Color(
    0xFF2C2C2C,
  ); // Dark Gray, great readability
  static const Color textSecondary = Color(
    0xFF6E6E6E,
  ); // Medium Gray, softer for subtitles
}
