import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contacto.dart';
import '../../themes/app_styles.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon.dart';
import '../../widgets/custom_text.dart';
import '../providers/contacto_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/phone_provider.dart';
import 'edit_contact_page.dart';
import '../utils/snackbar_helper.dart';

class ContactsPage extends ConsumerStatefulWidget {
  final void Function()? onEditAndGoHome;

  const ContactsPage({super.key, this.onEditAndGoHome});

  @override
  ConsumerState<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends ConsumerState<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  bool _alphabetical = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contactos = ref.watch(contactoNotifierProvider);

    // Filter by search query
    final filtered = contactos.where((c) {
      final nombre = c.nombre.toLowerCase();
      return nombre.contains(_query.toLowerCase());
    }).toList();

    // Sort if alphabetical requested
    if (_alphabetical) {
      filtered.sort(
        (a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.contacts, size: 28),
            SizedBox(width: 8),
            Text('Mis Contactos'),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Buscar por nombre',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Ordenar alfabéticamente',
                  icon: Icon(
                    Icons.sort_by_alpha,
                    color: _alphabetical
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  onPressed: () =>
                      setState(() => _alphabetical = !_alphabetical),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: filtered.isEmpty
                  ? const Center(
                      child: CustomText(
                        text: 'No existen contactos registrados',
                      ),
                    )
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final contacto = filtered[index];

                        return CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Información del contacto (arriba)
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Nombre
                                    Row(
                                      children: [
                                        const CustomIcon(icon: Icons.person_outline, size: 24),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: CustomText(
                                            text: contacto.nombre,
                                            style: AppStyles.subtitle,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    // Teléfono
                                    Row(
                                      children: [
                                        const CustomIcon(icon: Icons.phone, size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: CustomText(
                                            text: contacto.telefono,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Correo
                                    Row(
                                      children: [
                                        const CustomIcon(icon: Icons.email_outlined, size: 20),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: CustomText(
                                            text: contacto.correo,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 1),
                              // Botones de acción (abajo)
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Botón Llamar
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.call,
                                              color: Colors.green),
                                          tooltip: 'Llamar',
                                          onPressed: () async {
                                            final success = await ref
                                                .read(phoneProvider)
                                                .makeCall(contacto.telefono);
                                            if (success && context.mounted) {
                                              SnackbarHelper.show(
                                                context,
                                                'Iniciando llamada a ${contacto.nombre}',
                                              );
                                            } else if (!success &&
                                                context.mounted) {
                                              SnackbarHelper.errorGuardar(
                                                  context);
                                            }
                                          },
                                        ),
                                        const CustomText(
                                          text: 'Llamar',
                                        ),
                                      ],
                                    ),
                                    // Botón Editar
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.blue),
                                          tooltip: 'Editar',
                                          onPressed: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (_) =>
                                                    EditContactPage(
                                                  contactoId: contacto.id!,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const CustomText(
                                          text: 'Editar',
                                        ),
                                      ],
                                    ),
                                    // Botón Eliminar
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                          tooltip: 'Eliminar',
                                          onPressed: () async {
                                            try {
                                              await ref
                                                  .read(
                                                    contactoNotifierProvider
                                                        .notifier,
                                                  )
                                                  .eliminarContactos(
                                                      contacto.id!);
                                              SnackbarHelper
                                                  .contactoEliminado(context);
                                            } catch (e) {
                                              SnackbarHelper.errorGuardar(
                                                  context);
                                            }
                                          },
                                        ),
                                        const CustomText(
                                          text: 'Eliminar',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
