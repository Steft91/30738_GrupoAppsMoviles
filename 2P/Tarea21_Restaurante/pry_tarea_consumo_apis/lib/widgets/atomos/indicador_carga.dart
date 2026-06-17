import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';

class IndicadorCarga extends StatelessWidget {
  final String? mensaje;

  const IndicadorCarga({
    super.key,
    this.mensaje,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: EsquemaColor.azulComic,
            strokeWidth: 4,
          ),
          if (mensaje != null) ...[
            const SizedBox(height: 14),
            Text(
              mensaje!,
              style: const TextStyle(
                color: EsquemaColor.negroTinta,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
  }
}