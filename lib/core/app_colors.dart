import 'package:flutter/material.dart';

class AppColors {
  // Urbanova Brand Colors
  static const Color primaryBlue = Color(0xFF003EBE);
  static const Color brightBlue = Color(0xFF0761DA);
  static const Color darkBlue = Color(0xFF001465);

  static const Color primaryGreen = Color(0xFF089934);
  static const Color limeGreen = Color(0xFF7CD523);

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Urbanova Gradients

  static const LinearGradient blueGradient = LinearGradient(
    colors: [
      darkBlue,
      primaryBlue,
      brightBlue,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGreenGradient = LinearGradient(
    colors: [
      brightBlue,
      primaryGreen,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [
      primaryGreen,
      limeGreen,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkBlueGradient = LinearGradient(
    colors: [
      darkBlue,
      primaryBlue,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}