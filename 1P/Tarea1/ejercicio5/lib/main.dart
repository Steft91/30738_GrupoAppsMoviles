import 'package:flutter/material.dart';
import 'package:ejercicio5/view/descuento_view.dart';

void main() {
  runApp(Descuento());
}

class Descuento extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Descuento Supermercado',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      debugShowCheckedModeBanner: false,
      home: DescuentoPage(),
    );
  }
}
