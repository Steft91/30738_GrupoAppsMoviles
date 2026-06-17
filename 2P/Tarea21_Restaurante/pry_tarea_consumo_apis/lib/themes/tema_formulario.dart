import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemaFormulario {
  static InputDecorationTheme get inputDecoration {
    return InputDecorationTheme(
      filled: true,
      fillColor: EsquemaColor.blancoPapel,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: EsquemaColor.negroTinta,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: EsquemaColor.negroTinta,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: EsquemaColor.azulComic,
          width: 3,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: EsquemaColor.rojoComic,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(24),
        borderSide: const BorderSide(
          color: EsquemaColor.rojoComic,
          width: 3,
        ),
      ),
      labelStyle: const TextStyle(
        color: EsquemaColor.negroTinta,
        fontWeight: FontWeight.w700,
      ),
      hintStyle: const TextStyle(
        color: EsquemaColor.grisTexto,
        fontWeight: FontWeight.w500,
      ),
      prefixIconColor: EsquemaColor.negroTinta,
      suffixIconColor: EsquemaColor.negroTinta,
    );
  }
}