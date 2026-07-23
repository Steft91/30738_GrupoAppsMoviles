import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class BrandLogo extends StatelessWidget {
  final double size;

  const BrandLogo({super.key, this.size = 56});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: const Icon(Icons.library_music_rounded, color: Colors.white),
    );
  }
}
