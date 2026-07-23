import 'package:flutter/material.dart';
import '../themes/app_styles.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 20),
              const SizedBox(width: 10),
            ],
            Text(text, style: AppStyles.buttonText),
          ],
        ),
      ),
    );
  }
}
