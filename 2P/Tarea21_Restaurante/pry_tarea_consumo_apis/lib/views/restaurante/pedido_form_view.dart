import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/pedido.dart';
import '../../models/plato.dart';
import '../../viewmodels/pedido_viewmodel.dart';
import '../../widgets/atomos/boton_principal.dart';
import '../../widgets/atomos/campo_formulario.dart';
import '../../widgets/moleculas/resumen_producto.dart';
import '../../widgets/moleculas/tarjeta_resumen.dart';

class PedidoFormView extends StatefulWidget {
  final Plato plato;

  const PedidoFormView({
    super.key,
    required this.plato,
  });

  @override
  State<PedidoFormView> createState() => _PedidoFormViewState();
}

class _PedidoFormViewState extends State<PedidoFormView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _clienteController =
      TextEditingController();

  final TextEditingController _cantidadController =
      TextEditingController();

  double _total = 0;

  @override
  void initState() {
    super.initState();
    _cantidadController.addListener(_calcularTotal);
  }

  @override
  void dispose() {
    _clienteController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  void _calcularTotal() {
    final cantidad =
        int.tryParse(_cantidadController.text.trim()) ?? 0;

    setState(() {
      _total = cantidad * widget.plato.precio;
    });
  }

  Future<void> _registrarPedido() async {
    if (!_formKey.currentState!.validate()) return;

    final pedidoViewModel = context.read<PedidoViewModel>();

    final pedido = Pedido(
      cliente: _clienteController.text.trim(),
      cantidad: int.parse(
        _cantidadController.text.trim(),
      ),
      platoId: widget.plato.id!,
    );

    final ok = await pedidoViewModel.crearPedido(pedido);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Pedido registrado correctamente'
              : pedidoViewModel.errorMessage ??
                  'No se pudo registrar el pedido',
        ),
      ),
    );

    if (ok) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pedidoViewModel = context.watch<PedidoViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar pedido'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ResumenProducto(
                titulo: widget.plato.nombre,
                descripcion:
                    widget.plato.descripcion ?? 'Sin descripción',
                precio: widget.plato.precio,
                disponible: widget.plato.disponible,
                icono: Icons.restaurant_rounded,
              ),
              const SizedBox(height: 18),
              CampoFormulario(
                controlador: _clienteController,
                etiqueta: 'Nombre del cliente',
                icono: Icons.person_outline_rounded,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese el nombre del cliente';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              CampoFormulario(
                controlador: _cantidadController,
                etiqueta: 'Cantidad',
                icono: Icons.numbers_rounded,
                tipoTeclado: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Ingrese la cantidad';
                  }

                  final cantidad = int.tryParse(value.trim());

                  if (cantidad == null) {
                    return 'Ingrese un número válido';
                  }

                  if (cantidad <= 0) {
                    return 'La cantidad debe ser mayor a 0';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              TarjetaResumen(
                titulo: 'Total del pedido',
                valor: '\$${_total.toStringAsFixed(2)}',
                icono: Icons.payments_outlined,
              ),
              const SizedBox(height: 24),
              BotonPrincipal(
                texto: pedidoViewModel.isLoading
                    ? 'Registrando...'
                    : 'Confirmar pedido',
                icono: Icons.check_circle_outline_rounded,
                cargando: pedidoViewModel.isLoading,
                anchoCompleto: true,
                alPresionar: pedidoViewModel.isLoading
                    ? null
                    : _registrarPedido,
              ),
            ],
          ),
        ),
      ),
    );
  }
}