import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contacto.dart';
import '../../themes/app_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon.dart';
import '../../widgets/custom_text.dart';
import '../providers/contacto_provider.dart';
import '../providers/theme_provider.dart';
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
      appBar: const CustomAppBar(title: 'Contactos'),
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
                          child: ListTile(
                            leading: const CustomIcon(icon: Icons.person),
                            title: CustomText(
                              text: contacto.nombre,
                              style: AppStyles.subtitle,
                            ),
                            subtitle: CustomText(
                              text: '${contacto.telefono} ${contacto.correo}',
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const CustomIcon(icon: Icons.edit),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => EditContactPage(
                                          contactoId: contacto.id!,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const CustomIcon(icon: Icons.delete),
                                  onPressed: () async {
                                    try {
                                      await ref
                                          .read(
                                            contactoNotifierProvider.notifier,
                                          )
                                          .eliminarContactos(contacto.id!);
                                      SnackbarHelper.contactoEliminado(context);
                                    } catch (e) {
                                      SnackbarHelper.errorGuardar(context);
                                    }
                                  },
                                ),
                              ],
                            ),
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
