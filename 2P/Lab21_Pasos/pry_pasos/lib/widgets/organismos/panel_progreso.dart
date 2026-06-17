import 'package:flutter/material.dart';

import '../../theme/esquema_color.dart';
import '../../theme/tema_tarjetas.dart';
import '../atoms/indicador_progreso.dart';

class PanelProgreso extends StatelessWidget {
  final int pasos;
  final int meta;
  final int pasosRestantes;
  final double progreso;
  final bool metaAlcanzada;

  const PanelProgreso({
    super.key,
    required this.pasos,
    required this.meta,
    required this.pasosRestantes,
    required this.progreso,
    required this.metaAlcanzada,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration:
          TemaTarjetas.tarjetaDestacada,
      child: Column(
        children: [
          Text(
            metaAlcanzada
                ? '¡META COMPLETADA!'
                : 'META DEL DÍA',
            style: Theme.of(context)
                .textTheme
                .titleLarge,
          ),
          const SizedBox(height: 20),
          IndicadorProgreso(
            progreso: progreso,
            valorCentral: pasos.toString(),
          ),
          const SizedBox(height: 20),
          Text(
            metaAlcanzada
                ? 'Superaste tu meta de $meta pasos.'
                : 'Faltan $pasosRestantes de $meta pasos.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progreso,
            minHeight: 9,
            borderRadius:
                BorderRadius.circular(20),
            backgroundColor:
                EsquemaColor.blancoPapel,
            color: EsquemaColor.azulComic,
          ),
        ],
      ),
    );
  }
}