import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemaTarjetas {
  static CardThemeData get cardTheme {
    return CardThemeData(
      color: EsquemaColor.blancoPapel,
      elevation: 0,
      margin: EdgeInsets.zero,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
        side: const BorderSide(
          color: EsquemaColor.negroTinta,
          width: 2,
        ),
      ),
    );
  }

  static BoxDecoration get tarjetaPrincipal {
    return BoxDecoration(
      color: EsquemaColor.blancoPapel,
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

  static BoxDecoration get tarjetaOscura {
    return BoxDecoration(
      color: EsquemaColor.negroTinta,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: EsquemaColor.negroTinta,
        width: 2,
      ),
      boxShadow: const [
        BoxShadow(
          color: EsquemaColor.azulComic,
          offset: Offset(5, 5),
          blurRadius: 0,
        ),
      ],
    );
  }

  static BoxDecoration get tarjetaDestacada {
    return BoxDecoration(
      color: EsquemaColor.amarilloPrincipal,
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

  static BoxDecoration tarjetaColor({
    required Color color,
    Color sombra = EsquemaColor.negroTinta,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(22),
      border: Border.all(
        color: EsquemaColor.negroTinta,
        width: 2,
      ),
      boxShadow: [
        BoxShadow(
          color: sombra,
          offset: const Offset(5, 5),
          blurRadius: 0,
        ),
      ],
    );
  }
}