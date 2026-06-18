import 'package:flutter/material.dart';

import 'gmail_colors.dart';

class GmailTipografia {
  static const TextTheme temaTexto = TextTheme(
    // Títulos grandes (nombre de la app, encabezados principales)
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: GmailColors.textoOscuro,
      letterSpacing: 0,
    ),
    // Subtítulos de sección
    headlineMedium: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w400,
      color: GmailColors.textoOscuro,
      letterSpacing: 0,
    ),
    // Títulos de correo (remitente en lista)
    titleLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: GmailColors.textoOscuro,
      letterSpacing: 0.15,
    ),
    // Remitente no leído
    titleMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: GmailColors.textoOscuro,
      letterSpacing: 0.1,
    ),
    // Remitente leído
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: GmailColors.textoSecundario,
      letterSpacing: 0.1,
    ),
    // Asunto del correo en lista
    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: GmailColors.textoOscuro,
      height: 1.4,
      letterSpacing: 0.25,
    ),
    // Preview del cuerpo / texto secundario
    bodyMedium: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
      color: GmailColors.textoSecundario,
      height: 1.4,
      letterSpacing: 0.25,
    ),
    // Texto pequeño (fechas, badges)
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: GmailColors.textoTerciario,
      letterSpacing: 0.4,
    ),
    // Etiquetas (botones, chips)
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: GmailColors.azulGoogle,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: GmailColors.textoSecundario,
      letterSpacing: 0.5,
    ),
  );
}
