import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;

  const CustomCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final surfaceAlt =
        isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [surface, surfaceAlt],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: child,
      ),
    );
  }
}
