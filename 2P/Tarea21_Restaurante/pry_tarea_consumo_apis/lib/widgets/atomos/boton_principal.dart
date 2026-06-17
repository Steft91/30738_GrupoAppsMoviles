import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';

class BotonPrincipal extends StatelessWidget {
  final String texto;
  final IconData? icono;
  final VoidCallback? alPresionar;
  final bool cargando;
  final bool anchoCompleto;

  const BotonPrincipal({
    super.key,
    required this.texto,
    required this.alPresionar,
    this.icono,
    this.cargando = false,
    this.anchoCompleto = false,
  });

  @override
  Widget build(BuildContext context) {
    final contenido = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (cargando)
          const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: EsquemaColor.negroTinta,
            ),
          )
        else ...[
          if (icono != null) ...[
            Icon(
              icono,
              color: EsquemaColor.negroTinta,
            ),
            const SizedBox(width: 8),
          ],
          Text(
            texto,
            style: const TextStyle(
              color: EsquemaColor.negroTinta,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ],
    );

    final boton = GestureDetector(
      onTap: cargando ? null : alPresionar,
      child: Opacity(
        opacity: alPresionar == null ? 0.45 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: EsquemaColor.amarilloPrincipal,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: EsquemaColor.negroTinta,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                color: EsquemaColor.negroTinta,
                offset: Offset(4, 4),
                blurRadius: 0,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: contenido,
        ),
      ),
    );

    if (anchoCompleto) {
      return SizedBox(
        width: double.infinity,
        child: boton,
      );
    }

    return boton;
  }
}