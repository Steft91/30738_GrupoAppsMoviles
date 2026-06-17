import 'package:flutter/material.dart';

import 'esquema_color.dart';
import 'tipografia.dart';
import 'tema_appbar.dart';
import 'tema_botones.dart';
import 'tema_formulario.dart';
import 'tema_tarjetas.dart';
import 'tema_navegacion.dart';

class TemaGeneral {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: EsquemaColor.esquemaClaro,
      scaffoldBackgroundColor: EsquemaColor.fondoClaro,
      textTheme: TipografiaApp.temaTexto,
      appBarTheme: TemaAppBar.lightAppBar,
      elevatedButtonTheme: TemaBotones.elevatedButtonTheme,
      outlinedButtonTheme: TemaBotones.outlinedButtonTheme,
      textButtonTheme: TemaBotones.textButtonTheme,
      inputDecorationTheme: TemaFormulario.inputDecoration,
      cardTheme: TemaTarjetas.cardTheme,
      bottomNavigationBarTheme:
          TemaNavegacion.bottomNavigationTheme,
      navigationBarTheme:
          TemaNavegacion.navigationBarTheme,
      dividerColor: EsquemaColor.negroTinta,
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: EsquemaColor.azulComic,
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: EsquemaColor.naranjaComic,
        foregroundColor: EsquemaColor.negroTinta,
        elevation: 0,
        shape: CircleBorder(
          side: BorderSide(
            color: EsquemaColor.negroTinta,
            width: 2,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: EsquemaColor.negroTinta,
        contentTextStyle: const TextStyle(
          color: EsquemaColor.blancoPapel,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: EsquemaColor.blancoPapel,
          ),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: EsquemaColor.blancoPapel,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: const BorderSide(
            color: EsquemaColor.negroTinta,
            width: 2,
          ),
        ),
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}