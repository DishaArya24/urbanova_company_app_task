import 'package:flutter/material.dart';

class AppColors {
  // Urbanova Brand Colors
  static const Color deepBlue = Color(0xFF003EBE);
  static const Color skyBlue = Color(0xFF0761DA);
  static const Color navyBlue = Color(0xFF001465);

  static const Color emeraldGreen = Color(0xFF089934);
  static const Color limeGreen = Color(0xFF7CD523);

  // Gradient Colors
  static const Color blueGradientStart = Color(0xFF001465);
  static const Color blueGradientEnd = Color(0xFF0761DA);

  static const Color greenGradientStart = Color(0xFF7CD523);
  static const Color greenGradientEnd = Color(0xFF089934);

  // Reusable Urbanova Gradients
  static const LinearGradient blueGradient = LinearGradient(
    colors: [
      navyBlue,
      deepBlue,
      skyBlue,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [
      greenGradientStart,
      greenGradientEnd,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}