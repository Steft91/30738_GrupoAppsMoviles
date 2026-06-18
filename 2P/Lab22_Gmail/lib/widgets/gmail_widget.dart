import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/correo_viewmodel.dart';
import 'atoms/badge_no_leidos.dart';
import 'atoms/gmail_search_bar.dart';
import 'moleculas/correo_tile.dart';

class GmailWidget extends StatefulWidget {
  const GmailWidget({super.key});

  @override
  State<GmailWidget> createState() => _GmailWidgetState();
}

class _GmailWidgetState extends State<GmailWidget> {
  final _paraController = TextEditingController();
  final _asuntoController = TextEditingController();
  final _cuerpoController = TextEditingController();

  @override
  void dispose() {
    _paraController.dispose();
    _asuntoController.dispose();
    _cuerpoController.dispose();
    super.dispose();
  }

  Future<void> _mostrarDialogRedactar() async {
    final correoVm = context.read<CorreoViewModel>();
    final authVm = context.read<AuthViewModel>();

    _paraController.clear();
    _asuntoController.clear();
    _cuerpoController.clear();

    bool isSending = false;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Redactar'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _paraController,
                      decoration: const InputDecoration(hintText: 'Para'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _asuntoController,
                      decoration: const InputDecoration(hintText: 'Asunto'),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _cuerpoController,
                      minLines: 5,
                      maxLines: 10,
                      decoration: const InputDecoration(hintText: 'Cuerpo'),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSending
                      ? null
                      : () {
                          Navigator.pop(context);
                        },
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: isSending
                      ? null
                      : () async {
                          setDialogState(() => isSending = true);

                          final para = _paraController.text.trim();
                          final asunto = _asuntoController.text.trim();
                          final cuerpo = _cuerpoController.text.trim();

                          if (para.isEmpty ||
                              asunto.isEmpty ||
                              cuerpo.isEmpty) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Completa Para/Asunto/Cuerpo'),
                                ),
                              );
                            }
                            setDialogState(() => isSending = false);
                            return;
                          }

                          final token = authVm.accessToken;
                          if (token == null || token.isEmpty) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'No hay token de Gmail. Inicia sesión.',
                                  ),
                                ),
                              );
                            }
                            setDialogState(() => isSending = false);
                            return;
                          }

                          final enviado = await correoVm.enviarCorreoReal(
                            token,
                            para: para,
                            asunto: asunto,
                            cuerpo: cuerpo,
                            de: authVm.emailUsuario.isNotEmpty
                                ? authVm.emailUsuario
                                : null,
                          );

                          if (!enviado) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(correoVm.mensajeError ?? 'Error'),
                                ),
                              );
                            }
                            setDialogState(() => isSending = false);
                            return;
                          }

                          // Requisito: cerrar el apartado de enviar y mostrar bandeja.
                          if (context.mounted) Navigator.pop(context);
                        },
                  child: isSending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Enviar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final correoVm = context.watch<CorreoViewModel>();
    final authVm = context.watch<AuthViewModel>();

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: GmailSearchBar(
              fotoUsuario: authVm.fotoUsuario,
              onAvatarTap: () {},
              onMenuTap: () {},
              onChanged: (q) => correoVm.buscar(q),
              onClear: () => correoVm.limpiarBusqueda(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                IconButton(
                  tooltip: 'Redactar',
                  icon: const Icon(Icons.edit, color: Colors.red),
                  onPressed: _mostrarDialogRedactar,
                ),
                const SizedBox(width: 8),
                const Text('No leídos'),
                const Spacer(),
                BadgeNoLeidos(cantidad: correoVm.noLeidos),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Marcar todo como leído',
                  icon: const Icon(Icons.done_all),
                  onPressed: correoVm.marcarTodosLeidos,
                ),
              ],
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Gmail',
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
            ),
          ),

          Expanded(
            child: correoVm.estaCargando
                ? const Center(child: CircularProgressIndicator())
                : correoVm.correos.isEmpty
                ? const Center(child: Text('No hay correos para mostrar'))
                : ListView.builder(
                    itemCount: correoVm.correos.length,
                    itemBuilder: (context, index) {
                      final correo = correoVm.correos[index];
                      return CorreoTile(
                        correo: correo,
                        onTap: () => correoVm.marcarComoLeido(correo.id),
                        onStarToggle: () => correoVm.toggleDestacado(correo.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
