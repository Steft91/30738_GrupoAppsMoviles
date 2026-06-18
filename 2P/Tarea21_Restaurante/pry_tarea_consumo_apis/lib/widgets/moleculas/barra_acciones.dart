import 'package:flutter/material.dart';

import '../atomos/boton_icono.dart';

class BarraAcciones extends StatelessWidget {
  final VoidCallback? onEditar;
  final VoidCallback? onEliminar;
  final VoidCallback? onActualizar;
  final VoidCallback? onAgregar;

  const BarraAcciones({
    super.key,
    this.onEditar,
    this.onEliminar,
    this.onActualizar,
    this.onAgregar,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.end,
      children: [
        if (onActualizar != null)
          BotonIcono(
            icono: Icons.refresh,
            tooltip: 'Actualizar',
            alPresionar: onActualizar,
          ),
        if (onAgregar != null)
          BotonIcono(
            icono: Icons.add,
            tooltip: 'Agregar',
            alPresionar: onAgregar,
            tipo: TipoBotonIcono.destacado,
          ),
        if (onEditar != null)
          BotonIcono(
            icono: Icons.edit,
            tooltip: 'Editar',
            alPresionar: onEditar,
            tipo: TipoBotonIcono.editar,
          ),
        if (onEliminar != null)
          BotonIcono(
            icono: Icons.delete,
            tooltip: 'Eliminar',
            alPresionar: onEliminar,
            tipo: TipoBotonIcono.eliminar,
          ),
      ],
    );
  }
}
