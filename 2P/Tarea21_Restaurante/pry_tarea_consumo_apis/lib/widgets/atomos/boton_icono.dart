import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';

enum TipoBotonIcono {
  normal,
  editar,
  eliminar,
  destacado,
}

class BotonIcono extends StatelessWidget {
  final IconData icono;
  final VoidCallback? alPresionar;
  final String tooltip;
  final TipoBotonIcono tipo;

  const BotonIcono({
    super.key,
    required this.icono,
    required this.alPresionar,
    this.tooltip = '',
    this.tipo = TipoBotonIcono.normal,
  });

  Color get colorFondo {
    switch (tipo) {
      case TipoBotonIcono.editar:
        return EsquemaColor.azulComic;

      case TipoBotonIcono.eliminar:
        return EsquemaColor.rojoComic;

      case TipoBotonIcono.destacado:
        return EsquemaColor.naranjaComic;

      case TipoBotonIcono.normal:
        return EsquemaColor.blancoPapel;
    }
  }

  Color get colorIcono {
    if (tipo == TipoBotonIcono.eliminar) {
      return EsquemaColor.blancoPapel;
    }

    return EsquemaColor.negroTinta;
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: alPresionar,
        child: Opacity(
          opacity: alPresionar == null ? 0.4 : 1,
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: colorFondo,
              shape: BoxShape.circle,
              border: Border.all(
                color: EsquemaColor.negroTinta,
                width: 2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: EsquemaColor.negroTinta,
                  offset: Offset(3, 3),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Icon(
              icono,
              size: 21,
              color: colorIcono,
            ),
          ),
        ),
      ),
    );
  }
}