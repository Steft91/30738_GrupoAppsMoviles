import 'package:flutter/material.dart';

import '../../theme/gmail_colors.dart';

/// Avatar circular con la inicial del remitente y color consistente.
/// Widget atómico reutilizable estilo Gmail.
class CorreoAvatar extends StatelessWidget {
  final String nombre;
  final double radio;

  const CorreoAvatar({
    super.key,
    required this.nombre,
    this.radio = 20,
  });

  @override
  Widget build(BuildContext context) {
    final inicial = nombre.isNotEmpty ? nombre[0].toUpperCase() : '?';
    final color = _colorParaNombre(nombre);

    return CircleAvatar(
      radius: radio,
      backgroundColor: color,
      child: Text(
        inicial,
        style: TextStyle(
          color: Colors.white,
          fontSize: radio * 0.9,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// Genera un color consistente basado en el nombre del remitente.
  Color _colorParaNombre(String nombre) {
    if (nombre.isEmpty) return GmailColors.textoTerciario;
    final index = nombre.codeUnitAt(0) % GmailColors.avatarColors.length;
    return GmailColors.avatarColors[index];
  }
}
