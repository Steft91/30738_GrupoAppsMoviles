import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';
import 'boton_principal.dart';

class MensajeEstado extends StatelessWidget {
  final String mensaje;
  final IconData icono;
  final String? textoAccion;
  final VoidCallback? alPresionar;

  const MensajeEstado({
    super.key,
    required this.mensaje,
    required this.icono,
    this.textoAccion,
    this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: EsquemaColor.blancoPapel,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: EsquemaColor.negroTinta,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                color: EsquemaColor.negroTinta,
                offset: Offset(5, 5),
                blurRadius: 0,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 84,
                height: 84,
                decoration: BoxDecoration(
                  color: EsquemaColor.azulComic,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: EsquemaColor.negroTinta,
                    width: 2,
                  ),
                ),
                child: Icon(
                  icono,
                  size: 42,
                  color: EsquemaColor.negroTinta,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                mensaje,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: EsquemaColor.negroTinta,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              if (textoAccion != null &&
                  alPresionar != null) ...[
                const SizedBox(height: 20),
                BotonPrincipal(
                  texto: textoAccion!,
                  icono: Icons.refresh_rounded,
                  alPresionar: alPresionar,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}