import 'package:flutter/material.dart';

class TextoValor extends StatelessWidget {
  final String valor;
  final double tamanio;
  final Color? color;

  const TextoValor({
    super.key,
    required this.valor,
    this.tamanio = 28,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      valor,
      style: TextStyle(
        fontSize: tamanio,
        fontWeight: FontWeight.w900,
        color:
            color ??
            Theme.of(context).colorScheme.onSurface,
        height: 1,
      ),
    );
  }
}