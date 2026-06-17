import 'package:flutter/material.dart';

import 'esquema_color.dart';

class TemaNavegacion {
  static BottomNavigationBarThemeData get bottomNavigationTheme {
    return const BottomNavigationBarThemeData(
      backgroundColor: EsquemaColor.negroTinta,
      selectedItemColor: EsquemaColor.amarilloPrincipal,
      unselectedItemColor: EsquemaColor.blancoPapel,
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedLabelStyle: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w900,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static NavigationBarThemeData get navigationBarTheme {
    return NavigationBarThemeData(
      backgroundColor: EsquemaColor.negroTinta,
      indicatorColor: EsquemaColor.amarilloPrincipal,
      elevation: 0,
      height: 72,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              color: EsquemaColor.amarilloPrincipal,
              fontSize: 11,
              fontWeight: FontWeight.w900,
            );
          }

          return const TextStyle(
            color: EsquemaColor.blancoPapel,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          );
        },
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(
              color: EsquemaColor.negroTinta,
            );
          }

          return const IconThemeData(
            color: EsquemaColor.blancoPapel,
          );
        },
      ),
    );
  }
}