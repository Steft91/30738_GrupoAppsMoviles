import 'package:flutter/material.dart';

import '../../themes/index.dart';
import '../../views/restaurante/pedido_resume_view.dart';
import '../../views/restaurante/plato_form_view.dart';
import '../../views/restaurante/plato_list_view.dart';

enum RestauranteSeccion {
  catalogo,
  pedidos,
  nuevoPlato,
}

class RestauranteScaffold extends StatelessWidget {
  final String titulo;
  final RestauranteSeccion seccionActual;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const RestauranteScaffold({
    super.key,
    required this.titulo,
    required this.seccionActual,
    required this.body,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: TemaFondos.fondoRestaurante,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final mostrarBarraFija = constraints.maxWidth >= 820;

          return Scaffold(
            backgroundColor: Colors.transparent,
            drawer: mostrarBarraFija
                ? null
                : _BarraRestaurante(
                    seccionActual: seccionActual,
                  ),
            appBar: AppBar(
              title: Text(titulo),
              actions: actions,
            ),
            body: mostrarBarraFija
                ? Row(
                    children: [
                      _BarraRestaurante(
                        seccionActual: seccionActual,
                        fija: true,
                      ),
                      Expanded(child: body),
                    ],
                  )
                : body,
            floatingActionButton: floatingActionButton,
          );
        },
      ),
    );
  }
}

class _BarraRestaurante extends StatelessWidget {
  final RestauranteSeccion seccionActual;
  final bool fija;

  const _BarraRestaurante({
    required this.seccionActual,
    this.fija = false,
  });

  @override
  Widget build(BuildContext context) {
    final contenido = SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _EncabezadoBarra(),
            const SizedBox(height: 18),
            _OpcionBarra(
              icono: Icons.restaurant_menu_rounded,
              texto: 'Catálogo',
              seleccionada:
                  seccionActual == RestauranteSeccion.catalogo,
              alPresionar: () => _irACatalogo(context),
            ),
            const SizedBox(height: 8),
            _OpcionBarra(
              icono: Icons.receipt_long_rounded,
              texto: 'Pedidos',
              seleccionada:
                  seccionActual == RestauranteSeccion.pedidos,
              alPresionar: () => _irAPedidos(context),
            ),
            const SizedBox(height: 8),
            _OpcionBarra(
              icono: Icons.add_circle_outline_rounded,
              texto: 'Nuevo plato',
              seleccionada:
                  seccionActual == RestauranteSeccion.nuevoPlato,
              alPresionar: () => _irANuevoPlato(context),
            ),
            const Spacer(),
            const Divider(color: EsquemaColor.blancoPapel),
            const SizedBox(height: 10),
            const Text(
              'Gestión de restaurante',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: EsquemaColor.blancoPapel,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );

    if (fija) {
      return Container(
        width: 250,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: EsquemaColor.negroTinta,
          border: Border(
            right: BorderSide(
              color: EsquemaColor.amarilloPrincipal,
              width: 3,
            ),
          ),
        ),
        child: contenido,
      );
    }

    return Drawer(
      backgroundColor: EsquemaColor.negroTinta,
      child: contenido,
    );
  }

  void _irACatalogo(BuildContext context) {
    _cerrarDrawerSiExiste(context);

    if (seccionActual == RestauranteSeccion.catalogo) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PlatoListView(),
      ),
    );
  }

  void _irAPedidos(BuildContext context) {
    _cerrarDrawerSiExiste(context);

    if (seccionActual == RestauranteSeccion.pedidos) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const PedidoResumenView(),
      ),
    );
  }

  void _irANuevoPlato(BuildContext context) {
    _cerrarDrawerSiExiste(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const PlatoFormView(),
      ),
    );
  }

  void _cerrarDrawerSiExiste(BuildContext context) {
    if (!fija && Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}

class _EncabezadoBarra extends StatelessWidget {
  const _EncabezadoBarra();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: EsquemaColor.amarilloPrincipal,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: EsquemaColor.blancoPapel,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: EsquemaColor.negroTinta,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_dining_rounded,
              color: EsquemaColor.amarilloPrincipal,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Restaurante',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: EsquemaColor.negroTinta,
                    fontWeight: FontWeight.w900,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Panel operativo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: EsquemaColor.negroSecundario,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OpcionBarra extends StatelessWidget {
  final IconData icono;
  final String texto;
  final bool seleccionada;
  final VoidCallback alPresionar;

  const _OpcionBarra({
    required this.icono,
    required this.texto,
    required this.seleccionada,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: seleccionada
          ? EsquemaColor.amarilloPrincipal
          : Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: alPresionar,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: seleccionada
                  ? EsquemaColor.amarilloPrincipal
                  : EsquemaColor.blancoPapel,
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icono,
                color: seleccionada
                    ? EsquemaColor.negroTinta
                    : EsquemaColor.blancoPapel,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  texto,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: seleccionada
                        ? EsquemaColor.negroTinta
                        : EsquemaColor.blancoPapel,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
