import 'package:flutter/material.dart';

class GmailColors {
  // Colores principales de Google/Gmail
  static const Color rojoGmail = Color(0xFFEA4335);
  static const Color azulGoogle = Color(0xFF4285F4);
  static const Color verdeGoogle = Color(0xFF34A853);
  static const Color amarilloGoogle = Color(0xFFFBBC05);

  // Superficies y fondos
  static const Color fondoPrincipal = Color(0xFFF6F8FC);
  static const Color superficieBlanca = Color(0xFFFFFFFF);
  static const Color fondoBusqueda = Color(0xFFEAF1FB);
  static const Color fondoSeleccionado = Color(0xFFC2E7FF);
  static const Color fondoHover = Color(0xFFE8EAED);

  // Texto
  static const Color textoOscuro = Color(0xFF202124);
  static const Color textoSecundario = Color(0xFF5F6368);
  static const Color textoTerciario = Color(0xFF9AA0A6);
  static const Color textoBlanco = Color(0xFFFFFFFF);

  // Acciones
  static const Color favoritoActivo = Color(0xFFF4B400);
  static const Color favoritoInactivo = Color(0xFFDADCE0);
  static const Color noLeido = Color(0xFF1A73E8);
  static const Color leido = Color(0xFF5F6368);

  // Bordes y divisores
  static const Color borde = Color(0xFFDADCE0);
  static const Color divisor = Color(0xFFE8EAED);

  // Colores de avatar (Material colors variados)
  static const List<Color> avatarColors = [
    Color(0xFFEF5350), // Rojo
    Color(0xFFEC407A), // Rosa
    Color(0xFFAB47BC), // Púrpura
    Color(0xFF7E57C2), // Deep Purple
    Color(0xFF5C6BC0), // Índigo
    Color(0xFF42A5F5), // Azul
    Color(0xFF29B6F6), // Azul claro
    Color(0xFF26C6DA), // Cian
    Color(0xFF26A69A), // Teal
    Color(0xFF66BB6A), // Verde
    Color(0xFF9CCC65), // Verde claro
    Color(0xFFFF7043), // Deep Orange
  ];

  // Esquema Material 3 para Gmail
  static const ColorScheme esquemaGmail = ColorScheme(
    brightness: Brightness.light,
    primary: azulGoogle,
    onPrimary: textoBlanco,
    primaryContainer: fondoBusqueda,
    onPrimaryContainer: textoOscuro,
    secondary: rojoGmail,
    onSecondary: textoBlanco,
    secondaryContainer: Color(0xFFFCE8E6),
    onSecondaryContainer: rojoGmail,
    tertiary: verdeGoogle,
    onTertiary: textoBlanco,
    error: rojoGmail,
    onError: textoBlanco,
    surface: superficieBlanca,
    onSurface: textoOscuro,
    surfaceContainerHighest: fondoHover,
    outline: borde,
    outlineVariant: divisor,
  );
}
