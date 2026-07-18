import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contacto.dart';
import '../../application/usecases/contacto_usecases.dart';
import '../../domain/services/validaciones.dart';
import '../../themes/app_styles.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import '../providers/contacto_provider.dart';
import '../utils/snackbar_helper.dart';

class EditContactPage extends ConsumerStatefulWidget {
  final int contactoId;

  const EditContactPage({super.key, required this.contactoId});

  @override
  ConsumerState<EditContactPage> createState() => _EditContactPageState();
}

class _EditContactPageState extends ConsumerState<EditContactPage> {
  final nombreController = TextEditingController();
  final telefonoController = TextEditingController();
  final correoController = TextEditingController();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadContacto();
  }

  Future<void> _loadContacto() async {
    setState(() => _loading = true);
    try {
      final useCase = ref.read(contactoUseCaseProvider);
      final contacto = await useCase.obtenerPorId(widget.contactoId);
      if (contacto != null) {
        nombreController.text = contacto.nombre;
        telefonoController.text = contacto.telefono;
        correoController.text = contacto.correo;
      }
    } catch (_) {
      // ignore
    } finally {
      setState(() => _loading = false);
    }
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
    return Scaffold(
      appBar: const CustomAppBar(title: 'Editar contacto'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  CustomText(text: 'Editar contacto', style: AppStyles.title),
                  const SizedBox(height: 12),
                  CustomTextField(
                    label: 'Nombre',
                    controller: nombreController,
                  ),
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
                    text: 'Actualizar',
                    onPressed: _onUpdate,
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _onUpdate() async {
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
      await ref
          .read(contactoNotifierProvider.notifier)
          .actualizarContactos(widget.contactoId, nombre, telefono, correo);
      SnackbarHelper.contactoActualizado(context);
      Navigator.of(context).pop();
    } catch (e) {
      SnackbarHelper.errorGuardar(context);
    }
  }
}
