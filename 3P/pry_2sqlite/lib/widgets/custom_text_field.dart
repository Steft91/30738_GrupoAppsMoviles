import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? hintText;
  final Widget? prefixIcon;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.hintText,
    this.prefixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        prefixIcon: prefixIcon,
      ),
    );
  }
}
