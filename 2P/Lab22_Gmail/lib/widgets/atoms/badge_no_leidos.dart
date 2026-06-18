import 'package:flutter/material.dart';

import '../../theme/gmail_colors.dart';

/// Badge con contador de correos no leídos.
/// Widget atómico reutilizable estilo Gmail.
class BadgeNoLeidos extends StatelessWidget {
  final int cantidad;
  final double tamanio;

  const BadgeNoLeidos({
    super.key,
    required this.cantidad,
    this.tamanio = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (cantidad <= 0) return const SizedBox.shrink();

    final texto = cantidad > 99 ? '99+' : cantidad.toString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      constraints: BoxConstraints(
        minWidth: tamanio,
        minHeight: tamanio,
      ),
      decoration: BoxDecoration(
        color: GmailColors.rojoGmail,
        borderRadius: BorderRadius.circular(tamanio / 2),
      ),
      child: Center(
        child: Text(
          texto,
          style: TextStyle(
            color: GmailColors.textoBlanco,
            fontSize: tamanio * 0.55,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
