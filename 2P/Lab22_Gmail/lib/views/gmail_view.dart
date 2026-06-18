import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/auth_viewmodel.dart';
import '../viewmodels/correo_viewmodel.dart';
import 'gmail_widget.dart';

class GmailView extends StatefulWidget {
  const GmailView({super.key});

  @override
  State<GmailView> createState() => _GmailViewState();
}

class _GmailViewState extends State<GmailView> {
  bool _cargadoInicial = false;
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

  Future<void> _cargarSiHayToken() async {
    final authVm = context.read<AuthViewModel>();
    final correoVm = context.read<CorreoViewModel>();

    final token = authVm.accessToken;
    if (token == null || token.isEmpty) {
      return;
    }

    await correoVm.cargarCorreosReales(token);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_cargadoInicial) return;
    _cargadoInicial = true;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authVm = context.read<AuthViewModel>();
      if (!authVm.estaAutenticado) {
        await authVm.intentarSesionSilenciosa();
      }
      await _cargarSiHayToken();
    });
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
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Completa Para/Asunto/Cuerpo'),
                              ),
                            );
                            setDialogState(() => isSending = false);
                            return;
                          }

                          final token = authVm.accessToken;
                          if (token == null || token.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'No hay token de Gmail. Inicia sesión.',
                                ),
                              ),
                            );
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

  Future<void> _mostrarDialogBuscar() async {
    final correoVm = context.read<CorreoViewModel>();
    correoVm.limpiarBusqueda();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return Consumer<CorreoViewModel>(
          builder: (context, vm, child) {
            return AlertDialog(
              title: const Text('Buscar en el correo'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        hintText: 'Ingresa remitente, asunto o contenido...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        vm.buscar(value);
                      },
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: vm.estaCargando
                          ? const Center(child: CircularProgressIndicator())
                          : vm.correos.isEmpty
                              ? const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 20),
                                  child: Text('No se encontraron resultados'),
                                )
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: vm.correos.length,
                                  itemBuilder: (context, index) {
                                    final correo = vm.correos[index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.red[100],
                                        child: Text(
                                          correo.remitente.isNotEmpty
                                              ? correo.remitente[0].toUpperCase()
                                              : '?',
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                      ),
                                      title: Text(
                                        correo.remitente,
                                        style: TextStyle(
                                          fontWeight: correo.leido
                                              ? FontWeight.normal
                                              : FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            correo.asunto,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: correo.leido
                                                  ? FontWeight.normal
                                                  : FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            correo.cuerpo,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      trailing: Icon(
                                        correo.destacado ? Icons.star : Icons.star_border,
                                        color: correo.destacado ? Colors.amber : null,
                                      ),
                                      onTap: () {
                                        vm.marcarComoLeido(correo.id);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Leído: "${correo.asunto}"'),
                                            duration: const Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    vm.limpiarBusqueda();
                    Navigator.pop(context);
                  },
                  child: const Text('Cerrar'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      correoVm.limpiarBusqueda();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gmail'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: authVm.estaAutenticado
                ? () async {
                    await authVm.signOut();
                    if (mounted) {
                      setState(() => _cargadoInicial = false);
                    }
                  }
                : null,
          ),
        ],
      ),
      body: Center(
        child: authVm.estaAutenticado
            ? GmailWidget(
                onBuscarTap: _mostrarDialogBuscar,
                onRedactarTap: _mostrarDialogRedactar,
                onNoLeidosTap: () {
                  final correoVm = context.read<CorreoViewModel>();
                  correoVm.marcarTodosLeidos();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Todos los correos marcados como leídos'),
                    ),
                  );
                },
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (authVm.estaCargando)
                      const CircularProgressIndicator()
                    else ...[
                      Text(
                        'Inicia sesión con tu cuenta de Google para usar Gmail.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () async {
                          await authVm.signInWithGoogle();
                          await _cargarSiHayToken();
                        },
                        icon: const Icon(Icons.login),
                        label: const Text('Iniciar sesión con Google'),
                      ),
                      if (authVm.mensajeError != null) ...[
                        const SizedBox(height: 12),
                        Text(
                          authVm.mensajeError!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: authVm.limpiarMensajeError,
                          child: const Text('OK'),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
      ),
      floatingActionButton: authVm.estaAutenticado
          ? FloatingActionButton(
              onPressed: () {
                context.read<CorreoViewModel>().recibirCorreo();
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
