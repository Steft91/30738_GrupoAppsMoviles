import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';

class EmptyContactsState extends StatelessWidget {
  final AppLanguage language;

  const EmptyContactsState({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subtitleColor =
        isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.playlist_add_circle_rounded,
            size: 68,
            color: AppColors.primary,
          ),
          const SizedBox(height: 12),
          Text(
            AppStrings.emptyStateTitle(language),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: titleColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.emptyStateSubtitle(language),
            textAlign: TextAlign.center,
            style: TextStyle(color: subtitleColor),
          ),
        ],
      ),
    );
  }
}
