import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../themes/app_styles.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';
import '../providers/contacto_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/phone_provider.dart';
import 'edit_contact_page.dart';
import '../utils/snackbar_helper.dart';
import '../utils/app_strings.dart';

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
    final lang = ref.watch(languageProvider);
    final contactos = ref.watch(contactoNotifierProvider);

    final filtered = contactos.where((c) {
      final nombre = c.nombre.toLowerCase();
      final telefono = c.telefono.toLowerCase();
      final correo = c.correo.toLowerCase();
      final query = _query.toLowerCase();
      return nombre.contains(query) ||
          telefono.contains(query) ||
          correo.contains(query);
    }).toList();

    if (_alphabetical) {
      filtered.sort(
        (a, b) => a.nombre.toLowerCase().compareTo(b.nombre.toLowerCase()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.savedContactsTitle(lang),
        icon: const Icon(Icons.list),
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
                    decoration: InputDecoration(
                      hintText: AppStrings.searchHint(lang),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close_rounded),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _query = '');
                              },
                            )
                          : null,
                    ),
                    onChanged: (v) => setState(() => _query = v),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: lang == AppLanguage.es
                      ? 'Ordenar alfabéticamente'
                      : 'Sort alphabetically',
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
                  ? Center(
                      child: CustomText(
                        text: AppStrings.emptyStateTitle(lang),
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
                                                lang == AppLanguage.es
                                                    ? 'Iniciando llamada a ${contacto.nombre}'
                                                    : 'Calling ${contacto.nombre}',
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
                                        CustomText(
                                          text: lang == AppLanguage.es ? 'Editar' : 'Edit',
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
                                        CustomText(
                                          text: lang == AppLanguage.es ? 'Eliminar' : 'Delete',
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
