import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemaAppBar {
  static AppBarTheme get lightAppBar {
    return const AppBarTheme(
      backgroundColor: EsquemaColor.blancoPapel,
      foregroundColor: EsquemaColor.negroTinta,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: EsquemaColor.negroTinta,
        fontSize: 19,
        fontWeight: FontWeight.w900,
      ),
      iconTheme: IconThemeData(
        color: EsquemaColor.negroTinta,
      ),
    );
  }

  static AppBarTheme get darkAppBar {
    return const AppBarTheme(
      backgroundColor: EsquemaColor.negroTinta,
      foregroundColor: EsquemaColor.blancoPapel,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyle(
        color: EsquemaColor.blancoPapel,
        fontSize: 19,
        fontWeight: FontWeight.w900,
      ),
      iconTheme: IconThemeData(
        color: EsquemaColor.blancoPapel,
      ),
    );
  }

  static AppBarTheme get clearAppBar {
    return lightAppBar;
  }
}