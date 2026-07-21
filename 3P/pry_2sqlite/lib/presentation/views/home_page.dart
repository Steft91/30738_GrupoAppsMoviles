import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contacto.dart';
import '../../domain/services/validaciones.dart';
import '../utils/snackbar_helper.dart';
import '../../themes/app_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../providers/contacto_provider.dart';
import '../providers/theme_provider.dart';

class ContactoPage extends ConsumerStatefulWidget {
  const ContactoPage({super.key});

  @override
  ConsumerState<ContactoPage> createState() => _ContactoPageState();
}

class _ContactoPageState extends ConsumerState<ContactoPage> {
  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();

  int? contactoEditandoId;
  bool _hasRegisteredEditingListener = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nombreController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) {}

    if (!_hasRegisteredEditingListener) {
      ref.listen<int?>(editingContactoProvider, (previous, next) {
        if (next != null) {
          final contactos = ref.read(contactoNotifierProvider);
          try {
            final contacto = contactos.firstWhere((c) => c.id == next);
            setState(() {
              contactoEditandoId = contacto.id;
              nombreController.text = contacto.nombre;
              telefonoController.text = contacto.telefono;
              correoController.text = contacto.correo;
            });
          } catch (_) {
            // no-op
          }
        } else {
          limpiarFormulario();
        }
      });

      final initialId = ref.read(editingContactoProvider);
      if (initialId != null) {
        final contactos = ref.read(contactoNotifierProvider);
        try {
          final contacto = contactos.firstWhere((c) => c.id == initialId);
          contactoEditandoId = contacto.id;
          nombreController.text = contacto.nombre;
          telefonoController.text = contacto.telefono;
          correoController.text = contacto.correo;
        } catch (_) {
          // no-op
        }
      }
      _hasRegisteredEditingListener = true;
    }

    final contactos = ref.watch(contactoNotifierProvider);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'CRUD Contactos',
        icon: Icon(Icons.home),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CustomText(
              text: contactoEditandoId == null
                  ? 'Nuevo contacto'
                  : 'Editar contacto',
              style: AppStyles.title,
            ),
            const SizedBox(height: 12),
            CustomTextField(label: 'Nombre', controller: nombreController),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Teléfono',
              controller: telefonoController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Correo',
              controller: correoController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            CustomElevatedButton(
              text: contactoEditandoId == null ? 'Guardar' : 'Actualizar',
              onPressed: guardarOActualizar,
            ),
            const SizedBox(height: 16),
            // List moved to Contacts tab. Keep form only in this page.
          ],
        ),
      ),
    );
  }

  void guardarOActualizar() async {
    final nombre = nombreController.text.trim();
    final telefono = telefonoController.text.trim();
    final correo = correoController.text.trim();

    final nombreError = validarNombre(nombre);
    final telefonoError = validarTelefono(telefono);
    final correoError = validarCorreo(correo);

    if (nombreError != null) {
      SnackbarHelper.show(context, nombreError);
      return;
    }
    if (telefonoError != null) {
      SnackbarHelper.show(context, telefonoError);
      return;
    }
    if (correoError != null) {
      SnackbarHelper.show(context, correoError);
      return;
    }

    try {
      if (contactoEditandoId == null) {
        await ref
            .read(contactoNotifierProvider.notifier)
            .agregarContactos(nombre, telefono, correo);
        SnackbarHelper.contactoGuardado(context);
      } else {
        await ref
            .read(contactoNotifierProvider.notifier)
            .actualizarContactos(contactoEditandoId!, nombre, telefono, correo);
        SnackbarHelper.contactoActualizado(context);
      }
    } catch (e) {
      SnackbarHelper.errorGuardar(context);
    }

    // clear editing state shared across pages
    ref.read(editingContactoProvider.notifier).state = null;
    limpiarFormulario();
  }

  void cargarParaEditar(Contacto contacto) {
    setState(() {
      contactoEditandoId = contacto.id;
      nombreController.text = contacto.nombre;
      telefonoController.text = contacto.telefono;
      correoController.text = contacto.correo;
    });
  }

  void limpiarFormulario() {
    setState(() {
      contactoEditandoId = null;
      nombreController.clear();
      telefonoController.clear();
      correoController.clear();
    });
  }
}
