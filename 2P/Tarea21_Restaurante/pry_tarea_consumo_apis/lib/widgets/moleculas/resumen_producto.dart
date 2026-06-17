import 'package:flutter/material.dart';

import '../../themes/index.dart';
import '../atomos/etiqueta_estado.dart';
import '../atomos/texto_precio.dart';

class ResumenProducto extends StatelessWidget {
  final String titulo;
  final String descripcion;
  final double precio;
  final bool disponible;
  final IconData icono;
  final String? imagenUrl;

  const ResumenProducto({
    super.key,
    required this.titulo,
    required this.descripcion,
    required this.precio,
    required this.disponible,
    required this.icono,
    this.imagenUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: TemaTarjetas.tarjetaPrincipal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (imagenUrl != null &&
              imagenUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                imagenUrl!,
                width: double.infinity,
                height: 190,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return _contenedorIcono();
                },
              ),
            )
          else
            _contenedorIcono(),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  titulo,
                  style: const TextStyle(
                    color: EsquemaColor.negroTinta,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              EtiquetaEstado(
                texto: disponible
                    ? 'Disponible'
                    : 'No disponible',
                tipo: disponible
                    ? TipoEstado.exito
                    : TipoEstado.error,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            descripcion,
            style: const TextStyle(
              color: EsquemaColor.grisTexto,
              fontSize: 15,
              height: 1.4,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          TextoPrecio(
            valor: precio,
            destacado: true,
          ),
        ],
      ),
    );
  }

  Widget _contenedorIcono() {
    return Container(
      width: double.infinity,
      height: 165,
      decoration: BoxDecoration(
        color: EsquemaColor.azulComic,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: EsquemaColor.negroTinta,
          width: 2,
        ),
      ),
      child: Icon(
        icono,
        size: 72,
        color: EsquemaColor.negroTinta,
      ),
    );
  }
}