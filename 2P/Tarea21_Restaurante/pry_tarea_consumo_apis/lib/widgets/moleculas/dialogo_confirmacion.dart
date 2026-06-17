import 'package:flutter/material.dart';

import '../../themes/esquema_color.dart';

Future<bool> mostrarDialogoConfirmacion({
  required BuildContext context,
  required String titulo,
  required String mensaje,
  String textoConfirmar = 'Confirmar',
  String textoCancelar = 'Cancelar',
  bool esDestructivo = false,
}) async {
  final respuesta = await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text(textoCancelar),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: esDestructivo
                  ? EsquemaColor.rojoComic
                  : EsquemaColor.amarilloPrincipal,
              foregroundColor: esDestructivo
                  ? EsquemaColor.blancoPapel
                  : EsquemaColor.negroTinta,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(textoConfirmar),
          ),
        ],
      );
    },
  );

  return respuesta ?? false;
}