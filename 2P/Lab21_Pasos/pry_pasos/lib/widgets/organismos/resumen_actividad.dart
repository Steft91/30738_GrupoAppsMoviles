import 'package:flutter/material.dart';

import '../../theme/esquema_color.dart';
import '../moleculas/tarjeta_estadistica.dart';

class ResumenActividad
    extends StatelessWidget {
  final double distanciaKm;
  final double calorias;

  const ResumenActividad({
    super.key,
    required this.distanciaKm,
    required this.calorias,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TarjetaEstadistica(
            icono: Icons.route_rounded,
            valor:
                distanciaKm.toStringAsFixed(2),
            etiqueta: 'Kilómetros',
            color:
                EsquemaColor.azulClaro,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TarjetaEstadistica(
            icono:
                Icons.local_fire_department,
            valor:
                calorias.toStringAsFixed(1),
            etiqueta: 'Calorías',
            color:
                EsquemaColor.naranjaClaro,
          ),
        ),
      ],
    );
  }
}