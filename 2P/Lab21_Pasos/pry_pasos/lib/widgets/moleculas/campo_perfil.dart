import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoPerfil extends StatelessWidget {
  final TextEditingController controller;
  final String etiqueta;
  final String sugerencia;
  final IconData icono;
  final TextInputType tipoTeclado;
  final String? sufijo;
  final String? Function(String?)?
      validator;

  const CampoPerfil({
    super.key,
    required this.controller,
    required this.etiqueta,
    required this.sugerencia,
    required this.icono,
    this.tipoTeclado = TextInputType.text,
    this.sufijo,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final esNumerico =
        tipoTeclado ==
            TextInputType.number ||
        tipoTeclado ==
            const TextInputType.numberWithOptions(
              decimal: true,
            );

    return TextFormField(
      controller: controller,
      keyboardType: tipoTeclado,
      inputFormatters: esNumerico
          ? [
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d*\.?\d*'),
              ),
            ]
          : null,
      validator: validator,
      decoration: InputDecoration(
        labelText: etiqueta,
        hintText: sugerencia,
        prefixIcon: Icon(icono),
        suffixText: sufijo,
      ),
    );
  }
}