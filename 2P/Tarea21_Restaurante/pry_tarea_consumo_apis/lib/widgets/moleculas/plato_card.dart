import 'package:flutter/material.dart';

import '../../models/plato.dart';
import '../../themes/index.dart';
import '../atomos/boton_icono.dart';
import '../atomos/boton_principal.dart';
import '../atomos/etiqueta_estado.dart';
import '../atomos/texto_precio.dart';

class PlatoCard extends StatelessWidget {
  final Plato plato;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onPedido;

  const PlatoCard({
    super.key,
    required this.plato,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    required this.onPedido,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: TemaTarjetas.tarjetaPrincipal,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: EsquemaColor.azulComic,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: EsquemaColor.negroTinta,
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: EsquemaColor.negroTinta,
                        offset: Offset(3, 3),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      const Center(
                        child: Icon(
                          Icons.restaurant_menu_rounded,
                          size: 70,
                          color: EsquemaColor.negroTinta,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: EtiquetaEstado(
                          texto: plato.disponible
                              ? 'Disponible'
                              : 'Agotado',
                          tipo: plato.disponible
                              ? TipoEstado.exito
                              : TipoEstado.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Text(
                plato.nombre,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: EsquemaColor.negroTinta,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                plato.descripcion ?? 'Sin descripción',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: EsquemaColor.grisTexto,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 8),

              TextoPrecio(
                valor: plato.precio,
                destacado: true,
                tamano: 16,
              ),

              const SizedBox(height: 10),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  BotonIcono(
                    icono: Icons.edit_outlined,
                    tooltip: 'Editar',
                    tipo: TipoBotonIcono.editar,
                    alPresionar: onEdit,
                  ),
                  BotonIcono(
                    icono: Icons.delete_outline,
                    tooltip: 'Eliminar',
                    tipo: TipoBotonIcono.eliminar,
                    alPresionar: onDelete,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              BotonPrincipal(
                texto: 'Pedir',
                icono: Icons.shopping_cart_outlined,
                anchoCompleto: true,
                alPresionar: plato.disponible ? onPedido : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
