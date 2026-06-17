import 'package:flutter/material.dart';

import '../../model/actividad_diaria.dart';
import '../../theme/esquema_color.dart';
import '../../theme/tema_tarjetas.dart';

class ItemHistorial extends StatelessWidget {
  final ActividadDiaria actividad;

  const ItemHistorial({
    super.key,
    required this.actividad,
  });

  String _formatearFecha(DateTime fecha) {
    final dia = fecha.day
        .toString()
        .padLeft(2, '0');

    final mes = fecha.month
        .toString()
        .padLeft(2, '0');

    return '$dia/$mes/${fecha.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration:
          TemaTarjetas.tarjetaPrincipal,
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color:
                  EsquemaColor.amarilloPrincipal,
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(
                  color:
                      EsquemaColor.negroTinta,
                  width: 2,
                ),
              ),
            ),
            child: Icon(
              actividad.metaAlcanzada
                  ? Icons.emoji_events_rounded
                  : Icons.directions_walk_rounded,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  _formatearFecha(
                    actividad.fecha,
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium,
                ),
                const SizedBox(height: 5),
                Text(
                  '${actividad.pasos} pasos',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge,
                ),
                Text(
                  '${actividad.distanciaKm.toStringAsFixed(2)} km · '
                  '${actividad.calorias.toStringAsFixed(1)} kcal',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium,
                ),
              ],
            ),
          ),
          Icon(
            actividad.metaAlcanzada
                ? Icons.check_circle_rounded
                : Icons.timelapse_rounded,
            color: actividad.metaAlcanzada
                ? EsquemaColor.verdeComic
                : EsquemaColor.naranjaComic,
            size: 30,
          ),
        ],
      ),
    );
  }
}