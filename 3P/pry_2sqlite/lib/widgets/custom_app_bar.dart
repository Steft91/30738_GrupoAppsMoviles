import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? icon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final foreground = isDark ? AppColors.darkText : AppColors.lightText;

    return AppBar(
      leading: icon,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: -0.3),
      ),
      backgroundColor: Colors.transparent,
      foregroundColor: foreground,
      elevation: 0,
      centerTitle: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
