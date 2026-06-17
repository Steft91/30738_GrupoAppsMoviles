import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TipografiaApp {
  static const TextTheme temaTexto = TextTheme(
    displayLarge: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w900,
      color: EsquemaColor.negroTinta,
      letterSpacing: -1,
      height: 1,
    ),
    headlineMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.w900,
      color: EsquemaColor.negroTinta,
      letterSpacing: -0.5,
    ),
    titleLarge: TextStyle(
      fontSize: 21,
      fontWeight: FontWeight.w800,
      color: EsquemaColor.negroTinta,
    ),
    titleMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: EsquemaColor.negroTinta,
    ),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: EsquemaColor.negroTinta,
      height: 1.4,
    ),
    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: EsquemaColor.grisTexto,
      height: 1.4,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: EsquemaColor.negroTinta,
    ),
  );
}