import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';

class StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const StatTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tileColor =
        isDark ? AppColors.darkSurfaceAlt : AppColors.lightSurfaceAlt;
    final borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final titleColor = isDark ? AppColors.darkText : AppColors.lightText;
    final mutedColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 14),
            Text(
              value,
              style: AppStyles.title.copyWith(fontSize: 22, color: titleColor),
            ),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: mutedColor)),
          ],
        ),
      ),
    );
  }
}
