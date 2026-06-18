import 'package:flutter/material.dart';

import '../../model/correo_model.dart';
import '../../theme/gmail_colors.dart';
import '../atoms/correo_avatar.dart';

/// Tile individual de un correo en la lista (molécula).
/// Compuesto por: Avatar + Remitente + Asunto + Preview + Fecha + Estrella.
class CorreoTile extends StatelessWidget {
  final CorreoModel correo;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final VoidCallback? onStarToggle;

  const CorreoTile({
    super.key,
    required this.correo,
    this.onTap,
    this.onLongPress,
    this.onStarToggle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: correo.leido
            ? GmailColors.superficieBlanca
            : GmailColors.fondoPrincipal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: CorreoAvatar(nombre: correo.remitente),
            ),
            const SizedBox(width: 12),

            // Contenido principal
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fila: Remitente + Fecha
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          correo.remitente,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: correo.leido
                                ? FontWeight.w400
                                : FontWeight.w700,
                            color: GmailColors.textoOscuro,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatearFecha(correo.fecha),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: correo.leido
                              ? FontWeight.w400
                              : FontWeight.w600,
                          color: correo.leido
                              ? GmailColors.textoTerciario
                              : GmailColors.textoOscuro,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),

                  // Asunto
                  Text(
                    correo.asunto,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: correo.leido
                          ? FontWeight.w400
                          : FontWeight.w600,
                      color: GmailColors.textoOscuro,
                    ),
                  ),
                  const SizedBox(height: 1),

                  // Preview del cuerpo
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          correo.cuerpo.replaceAll('\n', ' '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: GmailColors.textoSecundario,
                          ),
                        ),
                      ),

                      // Estrella
                      GestureDetector(
                        onTap: onStarToggle,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Icon(
                            correo.destacado ? Icons.star : Icons.star_border,
                            size: 20,
                            color: correo.destacado
                                ? GmailColors.favoritoActivo
                                : GmailColors.favoritoInactivo,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formatea la fecha en estilo Gmail:
  /// Hoy → hora, esta semana → día, otro → fecha corta.
  String _formatearFecha(DateTime fecha) {
    final ahora = DateTime.now();
    final diferencia = ahora.difference(fecha);

    if (diferencia.inDays == 0 && fecha.day == ahora.day) {
      // Hoy: mostrar hora
      final hora = fecha.hour.toString().padLeft(2, '0');
      final minuto = fecha.minute.toString().padLeft(2, '0');
      return '$hora:$minuto';
    } else if (diferencia.inDays < 7) {
      // Esta semana: día de la semana
      const dias = ['lun.', 'mar.', 'mié.', 'jue.', 'vie.', 'sáb.', 'dom.'];
      return dias[fecha.weekday - 1];
    } else if (fecha.year == ahora.year) {
      // Este año: día y mes
      final dia = fecha.day.toString();
      const meses = [
        'ene.',
        'feb.',
        'mar.',
        'abr.',
        'may.',
        'jun.',
        'jul.',
        'ago.',
        'sep.',
        'oct.',
        'nov.',
        'dic.',
      ];
      return '$dia ${meses[fecha.month - 1]}';
    } else {
      // Otro año
      return '${fecha.day}/${fecha.month}/${fecha.year}';
    }
  }
}
