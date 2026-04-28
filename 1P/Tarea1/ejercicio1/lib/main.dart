import 'package:flutter/material.dart';
import 'package:ej1_conversion/view/conversion_view.dart';
import 'view/conversion_view.dart';


void main() {
  runApp(MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MaterialApp es el widget "raíz" configura el diseño global
    return MaterialApp(
      title: 'Mi Conversor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Color principal de la app
        useMaterial3: true, // Activa el diseño moderno de Google
      ),
      //primera pantalla que debe mostrar
      home: ConversionVista(),
    );
  }
}