import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/contacto.dart';
import '../../domain/services/validaciones.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';
import '../atoms/brand_logo.dart';
import '../molecules/contact_form_card.dart';
import '../templates/contact_dashboard_template.dart';
import '../providers/contacto_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';

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

  @override
  void dispose() {
    nombreController.dispose();
    telefonoController.dispose();
    correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider);
    final contactos = ref.watch(contactoNotifierProvider);
    final editando = contactoEditandoId != null;
    final totalContactos = contactos.length;
    final conCorreo = contactos.where((c) => c.correo.trim().isNotEmpty).length;

    return ContactDashboardTemplate(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeroHeader(
                editMode: editando,
                language: lang,
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  _HeroStatTile(
                    title: AppStrings.totalLabel(lang),
                    value: '$totalContactos',
                    icon: Icons.people_alt_rounded,
                  ),
                  const SizedBox(width: 10),
                  _HeroStatTile(
                    title: AppStrings.withEmailLabel(lang),
                    value: '$conCorreo',
                    icon: Icons.mark_email_read_rounded,
                  ),
                ],
              ),
              const SizedBox(height: 18),
              ContactFormCard(
                nombreController: nombreController,
                telefonoController: telefonoController,
                correoController: correoController,
                editing: editando,
                onSave: guardarOActualizar,
                language: lang,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> guardarOActualizar() async {
    final nombre = nombreController.text.trim();
    final telefono = telefonoController.text.trim();
    final correo = correoController.text.trim();
    final messenger = ScaffoldMessenger.of(context);

    final nombreError = validarNombre(nombre);
    final telefonoError = validarTelefono(telefono);
    final correoError = validarCorreo(correo);

    if (nombreError != null) {
      messenger.showSnackBar(SnackBar(content: Text(nombreError)));
      return;
    }
    if (telefonoError != null) {
      messenger.showSnackBar(SnackBar(content: Text(telefonoError)));
      return;
    }
    if (correoError != null) {
      messenger.showSnackBar(SnackBar(content: Text(correoError)));
      return;
    }

    try {
      if (contactoEditandoId == null) {
        await ref
            .read(contactoNotifierProvider.notifier)
            .agregarContactos(nombre, telefono, correo);
        if (!mounted) return;
        messenger.showSnackBar(
          const SnackBar(content: Text('Contacto guardado')),
        );
      } else {
        await ref
            .read(contactoNotifierProvider.notifier)
            .actualizarContactos(contactoEditandoId!, nombre, telefono, correo);
        if (!mounted) return;
        messenger.showSnackBar(
          const SnackBar(content: Text('Contacto actualizado')),
        );
      }
      limpiarFormulario();
    } catch (_) {
      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Error al guardar el contacto')),
      );
    }
  }

  void cargarParaEditar(Contacto contacto) {
    setState(() {
      contactoEditandoId = contacto.id;
      nombreController.text = contacto.nombre;
      telefonoController.text = contacto.telefono;
      correoController.text = contacto.correo;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ref.read(languageProvider) == AppLanguage.es
                ? 'Editando ${contacto.nombre}'
                : 'Editing ${contacto.nombre}',
          ),
        ),
      );
    }
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

class _HeroHeader extends StatelessWidget {
  final bool editMode;
  final AppLanguage language;

  const _HeroHeader({
    required this.editMode,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF101317), Color(0xFF191D22)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.darkBorder),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Row(
        children: [
          const BrandLogo(size: 54),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.homeTitle(language),
                  style: AppStyles.title.copyWith(fontSize: 28, color: AppColors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  AppStrings.homeSubtitle(language),
                  style: const TextStyle(color: AppColors.darkTextMuted),
                ),
                if (editMode) ...[
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.editMode(language),
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroStatTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _HeroStatTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.darkSurfaceAlt,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.darkBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.darkTextMuted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
