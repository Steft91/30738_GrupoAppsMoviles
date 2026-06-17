import 'package:flutter/material.dart';

class EsquemaColor {
  // Colores principales
  static const Color negroTinta = Color(0xFF1B1B1B);
  static const Color blancoPapel = Color(0xFFFFFDF8);

  static const Color amarilloPrincipal = Color(0xFFF9C80E);
  static const Color amarilloClaro = Color(0xFFFFDF57);
  static const Color amarilloSuave = Color(0xFFFFF2B2);

  static const Color azulComic = Color(0xFF51C4F6);
  static const Color azulClaro = Color(0xFFA8E4FC);

  static const Color naranjaComic = Color(0xFFF9844A);
  static const Color naranjaClaro = Color(0xFFFFB58E);

  static const Color rojoComic = Color(0xFFF94144);
  static const Color verdeComic = Color(0xFF70C174);

  // Colores neutrales
  static const Color fondoClaro = Color(0xFFF2F2F2);
  static const Color grisClaro = Color(0xFFE2E2E2);
  static const Color grisTexto = Color(0xFF6A6A6A);

  // Compatibilidad con widgets anteriores
  static const Color negroPrincipal = negroTinta;
  static const Color negroSecundario = Color(0xFF303030);
  static const Color negroSuave = Color(0xFF484848);
  static const Color blanco = blancoPapel;
  static const Color verdeExito = verdeComic;
  static const Color rojoError = rojoComic;

  static const ColorScheme esquemaClaro = ColorScheme(
    brightness: Brightness.light,
    primary: amarilloPrincipal,
    onPrimary: negroTinta,
    secondary: azulComic,
    onSecondary: negroTinta,
    tertiary: naranjaComic,
    onTertiary: negroTinta,
    error: rojoComic,
    onError: blancoPapel,
    surface: blancoPapel,
    onSurface: negroTinta,
  );
}