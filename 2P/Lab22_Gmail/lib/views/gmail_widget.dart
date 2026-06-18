import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/correo_viewmodel.dart';
import '../viewmodels/auth_viewmodel.dart';

/* callback */
class GmailWidget extends StatelessWidget {
  final void Function()? onBuscarTap;
  final void Function()? onRedactarTap;
  final void Function()? onNoLeidosTap;

  const GmailWidget({
    super.key,
    this.onBuscarTap,
    this.onRedactarTap,
    this.onNoLeidosTap,
  });

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CorreoViewModel>(context);
    final authVm = Provider.of<AuthViewModel>(context);

    return Container(
      padding: const EdgeInsets.all(16),
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Cabecera del usuario
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: authVm.fotoUsuario != null && authVm.fotoUsuario!.isNotEmpty
                    ? NetworkImage(authVm.fotoUsuario!)
                    : null,
                backgroundColor: Colors.red[100],
                child: authVm.fotoUsuario == null || authVm.fotoUsuario!.isEmpty
                    ? Text(
                        authVm.nombreUsuario.isNotEmpty
                            ? authVm.nombreUsuario[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      authVm.nombreUsuario,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      authVm.emailUsuario,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(height: 1, color: Colors.black12),
          ),

          // Barra de búsqueda
          GestureDetector(
            onTap: onBuscarTap,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  const Icon(Icons.mail_outline, color: Colors.red),
                  const SizedBox(width: 10),
                  Text(
                    'Buscar en el correo',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Acciones
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: onRedactarTap,
                child: Column(
                  children: [
                    const Icon(Icons.edit, color: Colors.red),
                    const SizedBox(height: 5),
                    Text('Redactar', style: TextStyle(color: Colors.grey[600])),
                  ],
                ),
              ),

              GestureDetector(
                onTap: onNoLeidosTap,
                child: Column(
                  children: [
                    const Icon(Icons.mark_as_unread, color: Colors.red),
                    const SizedBox(height: 5),
                    Text(
                      'No leídos',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    Text(
                      '${vm.noLeidos}',
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Etiqueta
          const Text(
            'Gmail',
            style: TextStyle(color: Colors.green, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
