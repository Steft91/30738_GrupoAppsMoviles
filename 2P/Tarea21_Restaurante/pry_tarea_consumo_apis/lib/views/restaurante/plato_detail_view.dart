import 'package:flutter/material.dart';

import '../../models/plato.dart';
import '../../widgets/atomos/boton_principal.dart';
import '../../widgets/moleculas/resumen_producto.dart';

import 'pedido_form_view.dart';

class PlatoDetailView extends StatelessWidget {
  final Plato plato;

  const PlatoDetailView({
    super.key,
    required this.plato,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del plato'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            ResumenProducto(
              titulo: plato.nombre,
              descripcion: plato.descripcion ?? 'Sin descripción',
              precio: plato.precio,
              disponible: plato.disponible,
              icono: Icons.restaurant_rounded,
            ),
            const SizedBox(height: 24),
            BotonPrincipal(
              texto: 'Realizar pedido',
              icono: Icons.shopping_cart_rounded,
              anchoCompleto: true,
              alPresionar: plato.disponible
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PedidoFormView(
                            plato: plato,
                          ),
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}