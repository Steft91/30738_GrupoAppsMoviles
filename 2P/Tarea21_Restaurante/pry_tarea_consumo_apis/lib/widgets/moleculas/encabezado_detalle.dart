import 'package:flutter/material.dart';

import '../atomos/etiqueta_estado.dart';

class EncabezadoDetalle extends StatelessWidget {
  final String titulo;
  final String? subtitulo;
  final bool? activo;
  final String? textoEstado;
  final IconData icono;

  const EncabezadoDetalle({
    super.key,
    required this.titulo,
    this.subtitulo,
    this.activo,
    this.textoEstado,
    this.icono = Icons.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.deepOrange.shade50,
          foregroundColor: Colors.deepOrange,
          child: Icon(icono),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (subtitulo != null) ...[
                const SizedBox(height: 4),
                Text(subtitulo!),
              ],
              if (activo != null && textoEstado != null) ...[
                const SizedBox(height: 8),
                EtiquetaEstado(texto: textoEstado!, activo: activo!),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
