import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';

class TextoPrecio extends StatelessWidget {
  final double valor;
  final double tamano;
  final bool destacado;
  final String prefijo;

  const TextoPrecio({
    super.key,
    required this.valor,
    this.tamano = 19,
    this.destacado = false,
    this.prefijo = '\$',
  });

  @override
  Widget build(BuildContext context) {
    final texto = Text(
      '$prefijo${valor.toStringAsFixed(2)}',
      style: TextStyle(
        color: EsquemaColor.negroTinta,
        fontSize: tamano,
        fontWeight: FontWeight.w900,
      ),
    );

    if (!destacado) {
      return texto;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: EsquemaColor.naranjaComic,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: EsquemaColor.negroTinta,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: EsquemaColor.negroTinta,
            offset: Offset(3, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: texto,
    );
  }
}