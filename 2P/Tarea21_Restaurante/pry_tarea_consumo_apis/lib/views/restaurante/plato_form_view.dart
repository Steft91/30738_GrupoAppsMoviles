import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/plato.dart';
import '../../viewmodels/plato_viewmodel.dart';
import '../../widgets/atomos/boton_principal.dart';
import '../../widgets/atomos/campo_formulario.dart';
import '../../widgets/atomos/selector_disponibilidad.dart';
import '../../widgets/organismos/restaurante_scaffold.dart';

class PlatoFormView extends StatefulWidget {
  final Plato? plato;

  const PlatoFormView({
    super.key,
    this.plato,
  });

  @override
  State<PlatoFormView> createState() => _PlatoFormViewState();
}

class _PlatoFormViewState extends State<PlatoFormView> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;

  bool _disponible = true;

  bool get _esEdicion => widget.plato != null;

  @override
  void initState() {
    super.initState();

    _nombreController = TextEditingController(
      text: widget.plato?.nombre ?? '',
    );

    _descripcionController = TextEditingController(
      text: widget.plato?.descripcion ?? '',
    );

    _precioController = TextEditingController(
      text: widget.plato?.precio.toString() ?? '',
    );

    _disponible = widget.plato?.disponible ?? true;
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    super.dispose();
  }

  Future<void> _guardarPlato() async {
    if (!_formKey.currentState!.validate()) return;

    final viewModel = context.read<PlatoViewModel>();

    final plato = Plato(
      nombre: _nombreController.text.trim(),
      descripcion: _descripcionController.text.trim(),
      precio: double.parse(_precioController.text.trim()),
      disponible: _disponible,
    );

    bool ok;

    if (_esEdicion) {
      ok = await viewModel.actualizarPlato(
        widget.plato!.id!,
        plato,
      );
    } else {
      ok = await viewModel.crearPlato(plato);
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? _esEdicion
                  ? 'Plato actualizado correctamente'
                  : 'Plato creado correctamente'
              : viewModel.errorMessage ??
                  'No se pudo guardar el plato',
        ),
      ),
    );

    if (ok) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PlatoViewModel>();

    return RestauranteScaffold(
      titulo: _esEdicion ? 'Editar plato' : 'Nuevo plato',
      seccionActual: RestauranteSeccion.nuevoPlato,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CampoFormulario(
                controlador: _nombreController,
                etiqueta: 'Nombre del plato',
                icono: Icons.restaurant_rounded,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el nombre del plato';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              CampoFormulario(
                controlador: _descripcionController,
                etiqueta: 'Descripción',
                icono: Icons.description_outlined,
                maxLines: 3,
              ),
              const SizedBox(height: 14),
              CampoFormulario(
                controlador: _precioController,
                etiqueta: 'Precio',
                icono: Icons.attach_money_rounded,
                tipoTeclado: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el precio';
                  }

                  final precio = double.tryParse(value.trim());

                  if (precio == null) {
                    return 'Ingrese un número válido';
                  }

                  if (precio <= 0) {
                    return 'El precio debe ser mayor a 0';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 18),
              SelectorDisponibilidad(
                valor: _disponible,
                titulo: 'Disponible',
                descripcionActiva: 'El plato puede ser pedido',
                descripcionInactiva:
                    'El plato no estará disponible',
                alCambiar: (value) {
                  setState(() {
                    _disponible = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              BotonPrincipal(
                texto: viewModel.isLoading
                    ? 'Guardando...'
                    : _esEdicion
                        ? 'Actualizar plato'
                        : 'Crear plato',
                icono: Icons.save_rounded,
                cargando: viewModel.isLoading,
                anchoCompleto: true,
                alPresionar:
                    viewModel.isLoading ? null : _guardarPlato,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
