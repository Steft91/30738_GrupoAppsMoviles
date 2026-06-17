import 'package:flutter/material.dart';

class EtiquetaDato extends StatelessWidget {
  final String texto;
  final Color? color;

  const EtiquetaDato({
    super.key,
    required this.texto,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: Theme.of(
        context,
      ).textTheme.bodyMedium?.copyWith(
        color: color,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }
}