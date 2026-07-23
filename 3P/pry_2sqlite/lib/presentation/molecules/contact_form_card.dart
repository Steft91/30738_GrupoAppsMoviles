import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_field.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';

class ContactFormCard extends StatelessWidget {
  final TextEditingController nombreController;
  final TextEditingController telefonoController;
  final TextEditingController correoController;
  final bool editing;
  final VoidCallback onSave;
  final AppLanguage language;

  const ContactFormCard({
    super.key,
    required this.nombreController,
    required this.telefonoController,
    required this.correoController,
    required this.editing,
    required this.onSave,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF191C21), Color(0xFF111318)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.formTitle(language, editing),
            style: AppStyles.title,
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.formSubtitle(language),
            style: const TextStyle(color: AppColors.textMuted),
          ),
          const SizedBox(height: 18),
          CustomTextField(
            label: language == AppLanguage.es ? 'Nombre completo' : 'Full name',
            controller: nombreController,
            hintText: language == AppLanguage.es ? 'Ej. Andrea López' : 'Ex. Andrea Lopez',
            prefixIcon: const Icon(Icons.person_outline_rounded),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: language == AppLanguage.es ? 'Número telefónico' : 'Phone number',
            controller: telefonoController,
            keyboardType: TextInputType.phone,
            hintText: language == AppLanguage.es ? '10 dígitos' : '10 digits',
            prefixIcon: const Icon(Icons.phone_rounded),
          ),
          const SizedBox(height: 12),
          CustomTextField(
            label: language == AppLanguage.es ? 'Correo electrónico' : 'Email',
            controller: correoController,
            keyboardType: TextInputType.emailAddress,
            hintText: language == AppLanguage.es ? 'correo@ejemplo.com' : 'mail@example.com',
            prefixIcon: const Icon(Icons.mail_outline_rounded),
          ),
          const SizedBox(height: 18),
          CustomElevatedButton(
            text: AppStrings.saveButton(language, editing),
            icon: editing ? Icons.save_as_rounded : Icons.add_rounded,
            onPressed: onSave,
          ),
        ],
      ),
    );
  }
}
