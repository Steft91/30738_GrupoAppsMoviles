import 'package:flutter/material.dart';
// Importa aquí el archivo donde creaste tu ConversionPage
import 'package:ej2_memoria/view/memoria_view.dart';
import 'view/memoria_view.dart';


void main() {
  runApp(Conversordememoria());
}

class Conversordememoria extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // configura el diseño global
    return MaterialApp(
      title: 'Conversor de memoria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, // Color principal de la app
        useMaterial3: true, // Activa el diseño moderno de Google
      ),

      home: MemoriaView(),
    );
  }
}