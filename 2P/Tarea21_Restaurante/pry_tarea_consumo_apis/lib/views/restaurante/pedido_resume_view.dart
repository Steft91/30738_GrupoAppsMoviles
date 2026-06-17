import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewmodels/pedido_viewmodel.dart';
import '../../widgets/atomos/indicador_carga.dart';
import '../../widgets/atomos/mensaje_estado.dart';
import '../../widgets/moleculas/dialogo_confirmacion.dart';
import '../../widgets/moleculas/tarjeta_registro.dart';
import '../../widgets/organismos/restaurante_scaffold.dart';

class PedidoResumenView extends StatefulWidget {
  const PedidoResumenView({super.key});

  @override
  State<PedidoResumenView> createState() =>
      _PedidoResumenViewState();
}

class _PedidoResumenViewState extends State<PedidoResumenView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PedidoViewModel>().cargarPedidos();
    });
  }

  Future<void> _confirmarEliminar(int id) async {
    final confirmar = await mostrarDialogoConfirmacion(
      context: context,
      titulo: 'Eliminar pedido',
      mensaje: '¿Seguro que deseas eliminar este pedido?',
      textoConfirmar: 'Eliminar',
      esDestructivo: true,
    );

    if (!confirmar || !mounted) return;

    final viewModel = context.read<PedidoViewModel>();
    final ok = await viewModel.eliminarPedido(id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Pedido eliminado correctamente'
              : viewModel.errorMessage ??
                  'No se pudo eliminar el pedido',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pedidoViewModel = context.watch<PedidoViewModel>();

    return RestauranteScaffold(
      titulo: 'Resumen de pedidos',
      seccionActual: RestauranteSeccion.pedidos,
      actions: [
        IconButton(
          tooltip: 'Actualizar',
          onPressed: pedidoViewModel.cargarPedidos,
          icon: const Icon(Icons.refresh_rounded),
        ),
      ],
      body: Builder(
        builder: (context) {
          if (pedidoViewModel.isLoading) {
            return const IndicadorCarga();
          }

          if (pedidoViewModel.errorMessage != null) {
            return MensajeEstado(
              mensaje: pedidoViewModel.errorMessage!,
              icono: Icons.error_outline_rounded,
              textoAccion: 'Reintentar',
              alPresionar: pedidoViewModel.cargarPedidos,
            );
          }

          if (pedidoViewModel.pedidos.isEmpty) {
            return const MensajeEstado(
              mensaje: 'No hay pedidos registrados',
              icono: Icons.receipt_long_outlined,
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            itemCount: pedidoViewModel.pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidoViewModel.pedidos[index];

              return TarjetaRegistro(
                titulo: pedido.cliente,
                icono: Icons.receipt_long_rounded,
                datos: [
                  'Plato: ${pedido.platoNombre ?? pedido.platoId}',
                  'Cantidad: ${pedido.cantidad}',
                  'Total: \$${pedido.total?.toStringAsFixed(2) ?? '0.00'}',
                ],
                iconoAccion: Icons.delete_outline_rounded,
                alPresionarAccion: pedido.id == null
                    ? null
                    : () => _confirmarEliminar(pedido.id!),
              );
            },
          );
        },
      ),
    );
  }
}
