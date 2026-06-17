import 'package:flutter/material.dart';

import '../../themes/index.dart';

class TarjetaResumen extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;

  const TarjetaResumen({
    super.key,
    required this.titulo,
    required this.valor,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: TemaTarjetas.tarjetaDestacada,
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: EsquemaColor.negroTinta,
              shape: BoxShape.circle,
              border: Border.all(
                color: EsquemaColor.negroTinta,
                width: 2,
              ),
            ),
            child: Icon(
              icono,
              color: EsquemaColor.amarilloPrincipal,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: EsquemaColor.negroSecundario,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  valor,
                  style: const TextStyle(
                    color: EsquemaColor.negroTinta,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}