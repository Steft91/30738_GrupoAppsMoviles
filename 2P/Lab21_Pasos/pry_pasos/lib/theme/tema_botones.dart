import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemaBotones {
  static ElevatedButtonThemeData get elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(
          EsquemaColor.negroTinta,
        ),
        backgroundColor: const WidgetStatePropertyAll(
          EsquemaColor.amarilloPrincipal,
        ),
        elevation: const WidgetStatePropertyAll(0),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 15,
          ),
        ),
        textStyle: const WidgetStatePropertyAll(
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
        ),
        side: const WidgetStatePropertyAll(
          BorderSide(
            color: EsquemaColor.negroTinta,
            width: 2,
          ),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        shadowColor: const WidgetStatePropertyAll(
          EsquemaColor.negroTinta,
        ),
      ),
    );
  }

  static OutlinedButtonThemeData get outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: EsquemaColor.negroTinta,
        backgroundColor: EsquemaColor.blancoPapel,
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 14,
        ),
        side: const BorderSide(
          color: EsquemaColor.negroTinta,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  static TextButtonThemeData get textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: EsquemaColor.negroTinta,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w900,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}