import 'package:flutter/material.dart';
import '../../../themes/esquema_color.dart';

class CampoTextoPersonalizado extends StatelessWidget {
  final String etiqueta;
  final IconData icono;
  final TextEditingController controlador;
  final bool ocultarTexto;

  const CampoTextoPersonalizado({
    super.key,
    required this.etiqueta,
    required this.icono,
    required this.controlador,
    this.ocultarTexto = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controlador,
      obscureText: ocultarTexto,
      style: const TextStyle(
        color: EsquemaColor.textoPrincipal,
      ),
      decoration: InputDecoration(
        labelText: etiqueta,
        prefixIcon: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: EsquemaColor.lavanda.withOpacity(0.18),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icono,
            color: EsquemaColor.lavanda,
          ),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.68),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 17,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(
            color: EsquemaColor.lavanda,
            width: 1.8,
          ),
        ),
      ),
    );
  }
}