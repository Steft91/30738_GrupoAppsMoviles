import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/index.dart';
import '../../viewmodels/pedido_viewmodel.dart';
import '../../viewmodels/plato_viewmodel.dart';
import '../../widgets/atomos/indicador_carga.dart';
import '../../widgets/atomos/mensaje_estado.dart';
import '../../widgets/moleculas/dialogo_confirmacion.dart';
import '../../widgets/moleculas/plato_card.dart';
import '../../widgets/organismos/restaurante_scaffold.dart';

import 'pedido_form_view.dart';
import 'pedido_resume_view.dart';
import 'plato_detail_view.dart';
import 'plato_form_view.dart';

class PlatoListView extends StatefulWidget {
  const PlatoListView({super.key});

  @override
  State<PlatoListView> createState() => _PlatoListViewState();
}

class _PlatoListViewState extends State<PlatoListView> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<PlatoViewModel>().cargarPlatos();
      context.read<PedidoViewModel>().cargarPedidos();
    });
  }

  Future<void> _confirmarEliminar(int id) async {
    final confirmar = await mostrarDialogoConfirmacion(
      context: context,
      titulo: 'Eliminar plato',
      mensaje: '¿Seguro que deseas eliminar este plato?',
      textoConfirmar: 'Eliminar',
      esDestructivo: true,
    );

    if (!confirmar || !mounted) return;

    final viewModel = context.read<PlatoViewModel>();
    final ok = await viewModel.eliminarPlato(id);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Plato eliminado correctamente'
              : viewModel.errorMessage ??
                  'No se pudo eliminar el plato',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final platoViewModel = context.watch<PlatoViewModel>();
    final pedidoViewModel = context.watch<PedidoViewModel>();

    return RestauranteScaffold(
      titulo: 'Catálogo de platos',
      seccionActual: RestauranteSeccion.catalogo,
      actions: [
        IconButton(
          tooltip: 'Ver pedidos',
          icon: const Icon(Icons.receipt_long_rounded),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PedidoResumenView(),
              ),
            );
          },
        ),
        IconButton(
          tooltip: 'Actualizar',
          icon: const Icon(Icons.refresh_rounded),
          onPressed: () {
            platoViewModel.cargarPlatos();
            pedidoViewModel.cargarPedidos();
          },
        ),
      ],
      body: Builder(
        builder: (context) {
          if (platoViewModel.isLoading) {
            return const IndicadorCarga();
          }

          if (platoViewModel.errorMessage != null) {
            return MensajeEstado(
              mensaje: platoViewModel.errorMessage!,
              icono: Icons.error_outline_rounded,
              textoAccion: 'Reintentar',
              alPresionar: platoViewModel.cargarPlatos,
            );
          }

          if (platoViewModel.platos.isEmpty) {
            return const MensajeEstado(
              mensaje: 'No hay platos registrados',
              icono: Icons.restaurant_menu_rounded,
            );
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              int columnas = 1;

              if (constraints.maxWidth >= 900) {
                columnas = 4;
              } else if (constraints.maxWidth >= 600) {
                columnas = 3;
              } else if (constraints.maxWidth >= 420) {
                columnas = 2;
              }

              return GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
                itemCount: platoViewModel.platos.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnas,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: columnas == 1
                      ? 410
                      : columnas == 2
                          ? 390
                          : 360,
                ),
                itemBuilder: (context, index) {
                  final plato = platoViewModel.platos[index];

                  return PlatoCard(
                    plato: plato,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlatoDetailView(plato: plato),
                        ),
                      );
                    },
                    onEdit: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlatoFormView(plato: plato),
                        ),
                      );
                    },
                    onDelete: () {
                      if (plato.id != null) {
                        _confirmarEliminar(plato.id!);
                      }
                    },
                    onPedido: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PedidoFormView(plato: plato),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: EsquemaColor.amarilloPrincipal,
        foregroundColor: EsquemaColor.negroPrincipal,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const PlatoFormView(),
            ),
          );
        },
        child: const Icon(Icons.add_rounded),
      ),
    );
  }
}
