import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/esquema_color.dart';
import '../theme/tema_fondos.dart';
import '../viewmodel/pasos_viewmodel.dart';
import '../widgets/atoms/boton_seguimiento.dart';
import '../widgets/organismos/panel_progreso.dart';
import '../widgets/organismos/resumen_actividad.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PasosViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        if (viewModel.estaCargando) {
          return const Scaffold(
            body: Center(
              child:
                  CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'CONTADOR DE PASOS',
            ),
          ),
          body: Container(
            decoration:
                TemaFondos.fondoComic,
            child: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.all(
                      18,
                    ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¡Hola, ${viewModel.perfil.nombre}!',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'Continúa avanzando hacia tu meta.',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge,
                    ),
                    const SizedBox(height: 22),
                    PanelProgreso(
                      pasos:
                          viewModel.pasos,
                      meta: viewModel
                          .perfil
                          .metaPasos,
                      pasosRestantes:
                          viewModel
                              .pasosRestantes,
                      progreso:
                          viewModel.progreso,
                      metaAlcanzada:
                          viewModel
                              .metaAlcanzada,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'RESUMEN DE ACTIVIDAD',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge,
                    ),
                    const SizedBox(height: 14),
                    ResumenActividad(
                      distanciaKm:
                          viewModel
                              .distanciaKm,
                      calorias:
                          viewModel.calorias,
                    ),
                    const SizedBox(height: 26),
                    BotonSeguimiento(
                      estaActivo:
                          viewModel
                              .estaActivo,
                      estaCargando: false,
                      onPressed: () async {
                        if (viewModel
                            .estaActivo) {
                          await viewModel
                              .detenerConteo();
                        } else {
                          await viewModel
                              .iniciarConteo();
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () async {
                        await viewModel
                            .reiniciarConteo();
                      },
                      icon: const Icon(
                        Icons.restart_alt,
                      ),
                      label: const Text(
                        'REINICIAR DÍA',
                      ),
                    ),
                    if (viewModel
                            .mensajeError !=
                        null) ...[
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        width:
                            double.infinity,
                        padding:
                            const EdgeInsets.all(
                              14,
                            ),
                        decoration:
                            TemaFondos.fondoSeccion(
                              color:
                                  EsquemaColor
                                      .naranjaClaro,
                            ),
                        child: Text(
                          viewModel
                              .mensajeError!,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}