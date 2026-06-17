import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemaFondos {
  static BoxDecoration get fondoPrincipal {
    return const BoxDecoration(
      color: EsquemaColor.fondoClaro,
    );
  }

  static BoxDecoration get fondoOscuro {
    return const BoxDecoration(
      color: EsquemaColor.negroTinta,
    );
  }

  static BoxDecoration get fondoAmarillo {
    return const BoxDecoration(
      color: EsquemaColor.amarilloPrincipal,
    );
  }

  static BoxDecoration get fondoDestacado {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          EsquemaColor.amarilloClaro,
          EsquemaColor.naranjaComic,
        ],
      ),
    );
  }

  static BoxDecoration get fondoComic {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          EsquemaColor.blancoPapel,
          Color(0xFFFFF4D6),
          Color(0xFFDDF5FF),
        ],
      ),
    );
  }

  static BoxDecoration fondoSeccion({
    Color color = EsquemaColor.blancoPapel,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: EsquemaColor.negroTinta,
        width: 2,
      ),
      boxShadow: const [
        BoxShadow(
          color: EsquemaColor.negroTinta,
          offset: Offset(5, 5),
          blurRadius: 0,
        ),
      ],
    );
  }
  static BoxDecoration get fondoRestaurante {
  return const BoxDecoration(
    gradient: RadialGradient(
      center: Alignment(-0.7, -0.8),
      radius: 1.5,
      colors: [
        Color(0xFFFFF3A3),
        Color(0xFFFFD93D),
        Color(0xFFF9B208),
      ],
      stops: [0.0, 0.55, 1.0],
    ),
  );
}
}