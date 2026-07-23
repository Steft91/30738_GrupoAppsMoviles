import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final Color? backgroundColor;

  const CustomIcon({
    super.key,
    required this.icon,
    this.size = 30,
    this.color = AppColors.primary,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = backgroundColor ??
        (isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt);

    return Container(
      height: size * 1.9,
      width: size * 1.9,
      decoration: BoxDecoration(
        color: background,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: size,
        color: color,
      ),
    );
  }
}
