import 'package:flutter/material.dart';
import '../../domain/entities/contacto.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_styles.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/custom_icon.dart';
import '../../widgets/custom_text.dart';
import '../providers/theme_provider.dart';

class ContactCard extends StatelessWidget {
  final Contacto contacto;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final Future<void> Function() onCall;
  final AppLanguage language;

  const ContactCard({
    super.key,
    required this.contacto,
    required this.onEdit,
    required this.onDelete,
    required this.onCall,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    final initials = contacto.nombre.isNotEmpty
        ? contacto.nombre.trim().characters.first.toUpperCase()
        : 'C';

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: contacto.nombre,
                      style: AppStyles.subtitle,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Contacto almacenado',
                      style: TextStyle(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _InfoRow(icon: Icons.phone_rounded, text: contacto.telefono),
          const SizedBox(height: 10),
          _InfoRow(icon: Icons.mail_outline_rounded, text: contacto.correo),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _ActionChip(
                  icon: Icons.call_rounded,
                  label: language == AppLanguage.es ? 'Llamar' : 'Call',
                  color: AppColors.primary,
                  onTap: onCall,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionChip(
                  icon: Icons.edit_rounded,
                  label: language == AppLanguage.es ? 'Editar' : 'Edit',
                  color: AppColors.accent,
                  onTap: () async => onEdit(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _ActionChip(
                  icon: Icons.delete_outline_rounded,
                  label: language == AppLanguage.es ? 'Eliminar' : 'Delete',
                  color: AppColors.error,
                  onTap: () async => onDelete(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIcon(icon: icon, size: 18),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Future<void> Function() onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.22)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
