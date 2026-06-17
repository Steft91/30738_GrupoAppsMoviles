import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';

enum TipoEstado {
  exito,
  error,
  advertencia,
  informacion,
}

class EtiquetaEstado extends StatelessWidget {
  final String texto;
  final TipoEstado tipo;

  const EtiquetaEstado({
    super.key,
    required this.texto,
    this.tipo = TipoEstado.informacion,
  });

  Color get colorFondo {
    switch (tipo) {
      case TipoEstado.exito:
        return EsquemaColor.verdeComic;

      case TipoEstado.error:
        return EsquemaColor.rojoComic;

      case TipoEstado.advertencia:
        return EsquemaColor.amarilloPrincipal;

      case TipoEstado.informacion:
        return EsquemaColor.azulComic;
    }
  }

  Color get colorTexto {
    if (tipo == TipoEstado.error) {
      return EsquemaColor.blancoPapel;
    }

    return EsquemaColor.negroTinta;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: colorFondo,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: EsquemaColor.negroTinta,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: EsquemaColor.negroTinta,
            offset: Offset(2, 2),
            blurRadius: 0,
          ),
        ],
      ),
      child: Text(
        texto,
        style: TextStyle(
          color: colorTexto,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}