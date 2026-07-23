import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  static const TextStyle title = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
    letterSpacing: -0.4,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.darkTextMuted,
    height: 1.35,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    letterSpacing: 0.2,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.darkTextMuted,
    letterSpacing: 1.2,
  );
}
