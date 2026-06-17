import 'package:flutter/material.dart';

class BotonSeguimiento extends StatelessWidget {
  final bool estaActivo;
  final bool estaCargando;
  final VoidCallback? onPressed;

  const BotonSeguimiento({
    super.key,
    required this.estaActivo,
    required this.estaCargando,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed:
            estaCargando ? null : onPressed,
        icon: estaCargando
            ? const SizedBox(
                width: 20,
                height: 20,
                child:
                    CircularProgressIndicator(
                      strokeWidth: 3,
                    ),
              )
            : Icon(
                estaActivo
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
              ),
        label: Text(
          estaActivo
              ? 'DETENER CONTEO'
              : 'INICIAR CONTEO',
        ),
      ),
    );
  }
}