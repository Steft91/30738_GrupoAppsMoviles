import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';

class SelectorDisponibilidad extends StatelessWidget {
  final bool valor;
  final String titulo;
  final String descripcionActiva;
  final String descripcionInactiva;
  final ValueChanged<bool> alCambiar;

  const SelectorDisponibilidad({
    super.key,
    required this.valor,
    required this.titulo,
    required this.descripcionActiva,
    required this.descripcionInactiva,
    required this.alCambiar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: valor
            ? EsquemaColor.amarilloSuave
            : EsquemaColor.blancoPapel,
        borderRadius: BorderRadius.circular(22),
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
      child: SwitchListTile(
        value: valor,
        onChanged: alCambiar,
        activeColor: EsquemaColor.negroTinta,
        activeTrackColor: EsquemaColor.amarilloPrincipal,
        inactiveThumbColor: EsquemaColor.grisTexto,
        inactiveTrackColor: EsquemaColor.grisClaro,
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Text(
          valor
              ? descripcionActiva
              : descripcionInactiva,
        ),
      ),
    );
  }
}