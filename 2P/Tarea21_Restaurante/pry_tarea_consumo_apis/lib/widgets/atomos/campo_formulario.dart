import 'package:flutter/material.dart';

class CampoFormulario extends StatelessWidget {
  final TextEditingController controlador;
  final String etiqueta;
  final IconData? icono;
  final TextInputType? tipoTeclado;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool ocultarTexto;
  final bool habilitado;

  const CampoFormulario({
    super.key,
    required this.controlador,
    required this.etiqueta,
    this.icono,
    this.tipoTeclado,
    this.validator,
    this.maxLines = 1,
    this.ocultarTexto = false,
    this.habilitado = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controlador,
      keyboardType: tipoTeclado,
      validator: validator,
      maxLines: ocultarTexto ? 1 : maxLines,
      obscureText: ocultarTexto,
      enabled: habilitado,
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: icono == null
            ? null
            : Icon(icono),
      ),
    );
  }
}