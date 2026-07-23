import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class ContactDashboardTemplate extends StatelessWidget {
  final Widget child;

  const ContactDashboardTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF111318), AppColors.background],
          stops: [0.0, 0.45],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}
