import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/tema_fondos.dart';
import '../viewmodel/pasos_viewmodel.dart';
import '../viewmodel/perfil_viewmodel.dart';
import '../widgets/organismos/formulario_perfil.dart';

class PerfilView extends StatefulWidget {
  const PerfilView({super.key});

  @override
  State<PerfilView> createState() =>
      _PerfilViewState();
}

class _PerfilViewState
    extends State<PerfilView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          context
              .read<PerfilViewModel>()
              .cargarPerfil();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PerfilViewModel>(
      builder: (
        context,
        viewModel,
        child,
      ) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'MI PERFIL',
            ),
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
    PerfilViewModel viewModel,
  ) {
    if (viewModel.estaCargando) {
      return const Center(
        child:
            CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'CONFIGURA TUS DATOS',
            style: Theme.of(context)
                .textTheme
                .headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Estos valores permiten estimar la distancia y las calorías.',
            style: Theme.of(context)
                .textTheme
                .bodyLarge,
          ),
          const SizedBox(height: 22),
          FormularioPerfil(
            perfil: viewModel.perfil,
            estaGuardando:
                viewModel.estaGuardando,
            onGuardar: ({
              required nombre,
              required pesoKg,
              required longitudPasoCm,
              required metaPasos,
            }) async {
              final guardado =
                  await viewModel
                      .guardarPerfil(
                        nombre: nombre,
                        pesoKg: pesoKg,
                        longitudPasoCm:
                            longitudPasoCm,
                        metaPasos:
                            metaPasos,
                      );

              if (!mounted) {
                return;
              }

              if (guardado) {
                await context
                    .read<
                      PasosViewModel
                    >()
                    .actualizarPerfil(
                      viewModel.perfil,
                    );
              }

              if (!mounted) {
                return;
              }

              final mensaje =
                  viewModel
                      .mensajeExito ??
                  viewModel
                      .mensajeError;

              if (mensaje != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  SnackBar(
                    content:
                        Text(mensaje),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}