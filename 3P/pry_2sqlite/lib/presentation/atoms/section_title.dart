import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? action;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtitleColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;
    final titleColor = isDark ? AppColors.darkText : AppColors.lightText;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.subtitle.copyWith(
                  fontSize: 20,
                  color: titleColor,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: TextStyle(
                    color: subtitleColor,
                    height: 1.3,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (action != null) ...[action!],
      ],
    );
  }
}
