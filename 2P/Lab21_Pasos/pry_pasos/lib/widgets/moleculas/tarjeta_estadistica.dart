import 'package:flutter/material.dart';

import '../../theme/esquema_color.dart';
import '../../theme/tema_tarjetas.dart';
import '../atoms/etiqueta_dato.dart';
import '../atoms/texto_valor.dart';

class TarjetaEstadistica
    extends StatelessWidget {
  final IconData icono;
  final String valor;
  final String etiqueta;
  final Color color;

  const TarjetaEstadistica({
    super.key,
    required this.icono,
    required this.valor,
    required this.etiqueta,
    this.color = EsquemaColor.blancoPapel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: TemaTarjetas.tarjetaColor(
        color: color,
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icono,
            size: 30,
            color: EsquemaColor.negroTinta,
          ),
          const SizedBox(height: 10),
          TextoValor(
            valor: valor,
            tamanio: 22,
          ),
          const SizedBox(height: 5),
          EtiquetaDato(texto: etiqueta),
        ],
      ),
    );
  }
}