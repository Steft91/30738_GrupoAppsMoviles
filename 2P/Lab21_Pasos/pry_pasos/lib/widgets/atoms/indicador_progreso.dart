import 'package:flutter/material.dart';

import '../../theme/esquema_color.dart';

class IndicadorProgreso
    extends StatelessWidget {
  final double progreso;
  final String valorCentral;

  const IndicadorProgreso({
    super.key,
    required this.progreso,
    required this.valorCentral,
  });

  @override
  Widget build(BuildContext context) {
    final progresoValido =
        progreso.clamp(0.0, 1.0);

    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: progresoValido,
              strokeWidth: 15,
              backgroundColor:
                  EsquemaColor.grisClaro,
              color: EsquemaColor.azulComic,
              strokeCap: StrokeCap.round,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                valorCentral,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge,
              ),
              Text(
                'PASOS',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}