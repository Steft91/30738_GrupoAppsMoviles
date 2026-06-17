import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/tema_fondos.dart';
import '../viewmodel/historial_viewmodel.dart';
import '../widgets/organismos/lista_historial.dart';

class HistorialView
    extends StatefulWidget {
  const HistorialView({super.key});

  @override
  State<HistorialView> createState() =>
      _HistorialViewState();
}

class _HistorialViewState
    extends State<HistorialView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          context
              .read<HistorialViewModel>()
              .cargarHistorial();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HistorialViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'HISTORIAL',
            ),
            actions: [
              if (!viewModel.estaVacio)
                IconButton(
                  onPressed: () {
                    _confirmarEliminacion(
                      context,
                      viewModel,
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
            ],
          ),
          body: Container(
            decoration:
                TemaFondos.fondoComic,
            child: _construirContenido(
              viewModel,
            ),
          ),
        );
      },
    );
  }

  Widget _construirContenido(
    HistorialViewModel viewModel,
  ) {
    if (viewModel.estaCargando) {
      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    if (viewModel.mensajeError != null) {
      return Center(
        child: Padding(
          padding:
              const EdgeInsets.all(24),
          child: Text(
            viewModel.mensajeError!,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (viewModel.estaVacio) {
      return Center(
        child: Padding(
          padding:
              const EdgeInsets.all(30),
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Icon(
                Icons.history_rounded,
                size: 80,
              ),
              const SizedBox(height: 18),
              Text(
                'Todavía no existen registros.',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge,
                textAlign:
                    TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Tus actividades diarias aparecerán aquí.',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
                textAlign:
                    TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListaHistorial(
      historial: viewModel.historial,
    );
  }

  Future<void> _confirmarEliminacion(
    BuildContext context,
    HistorialViewModel viewModel,
  ) async {
    final confirmar =
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Eliminar historial',
              ),
              content: const Text(
                'Esta acción eliminará todos los registros guardados.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      false,
                    );
                  },
                  child: const Text(
                    'CANCELAR',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      true,
                    );
                  },
                  child: const Text(
                    'ELIMINAR',
                  ),
                ),
              ],
            );
          },
        );

    if (confirmar == true) {
      await viewModel
          .eliminarHistorial();
    }
  }
}