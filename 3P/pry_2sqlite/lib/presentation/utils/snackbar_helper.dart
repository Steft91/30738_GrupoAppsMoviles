import 'package:flutter/material.dart';

class SnackbarHelper {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void contactoGuardado(BuildContext context) =>
      show(context, 'Contacto guardado');
  static void contactoActualizado(BuildContext context) =>
      show(context, 'Contacto actualizado');
  static void contactoEliminado(BuildContext context) =>
      show(context, 'Contacto eliminado');
  static void errorGuardar(BuildContext context) =>
      show(context, 'Error al guardar el contacto');
  static void modoOscuroActivado(BuildContext context) =>
      show(context, 'Modo oscuro activado');
  static void modoOscuroDesactivado(BuildContext context) =>
      show(context, 'Modo oscuro desactivado');
}
