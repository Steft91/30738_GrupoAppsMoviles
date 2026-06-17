import 'package:flutter/material.dart';

import '../../model/actividad_diaria.dart';
import '../moleculas/item_historial.dart';

class ListaHistorial
    extends StatelessWidget {
  final List<ActividadDiaria> historial;

  const ListaHistorial({
    super.key,
    required this.historial,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(
        18,
        18,
        18,
        30,
      ),
      itemCount: historial.length,
      itemBuilder: (context, index) {
        return ItemHistorial(
          actividad: historial[index],
        );
      },
    );
  }
}