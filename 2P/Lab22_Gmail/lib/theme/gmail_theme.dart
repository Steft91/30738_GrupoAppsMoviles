import 'package:flutter/material.dart';

import 'gmail_colors.dart';
import 'gmail_tipografia.dart';

class GmailTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: GmailColors.esquemaGmail,
      scaffoldBackgroundColor: GmailColors.fondoPrincipal,
      textTheme: GmailTipografia.temaTexto,

      // AppBar estilo Gmail
      appBarTheme: const AppBarTheme(
        backgroundColor: GmailColors.fondoPrincipal,
        foregroundColor: GmailColors.textoOscuro,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          color: GmailColors.textoOscuro,
        ),
      ),

      // FAB estilo Gmail (Redactar)
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: GmailColors.fondoBusqueda,
        foregroundColor: GmailColors.azulGoogle,
        elevation: 2,
        highlightElevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        extendedTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
      ),

      // Botones elevados
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: GmailColors.azulGoogle,
          foregroundColor: GmailColors.textoBlanco,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Botones de texto
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: GmailColors.azulGoogle,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Botones outlined
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: GmailColors.azulGoogle,
          side: const BorderSide(color: GmailColors.borde),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),

      // Tarjetas
      cardTheme: CardThemeData(
        color: GmailColors.superficieBlanca,
        elevation: 0,
        margin: EdgeInsets.zero,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: GmailColors.divisor,
            width: 1,
          ),
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: GmailColors.superficieBlanca,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: GmailColors.borde),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: GmailColors.borde),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: GmailColors.azulGoogle,
            width: 2,
          ),
        ),
        hintStyle: const TextStyle(
          color: GmailColors.textoTerciario,
          fontSize: 14,
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: GmailColors.divisor,
        thickness: 1,
        space: 0,
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        backgroundColor: GmailColors.textoOscuro,
        contentTextStyle: const TextStyle(
          color: GmailColors.textoBlanco,
          fontSize: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: GmailColors.superficieBlanca,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: GmailColors.textoOscuro,
        ),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: GmailColors.superficieBlanca,
        selectedItemColor: GmailColors.azulGoogle,
        unselectedItemColor: GmailColors.textoSecundario,
        elevation: 3,
        type: BottomNavigationBarType.fixed,
      ),

      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
