import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';

class ContactSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool alphabetical;
  final VoidCallback onToggleSort;

  const ContactSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.alphabetical,
    required this.onToggleSort,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: 'Buscar contacto',
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        controller.clear();
                        onChanged('');
                      },
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onToggleSort,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: alphabetical ? AppColors.primary : AppColors.surfaceAlt,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(
              Icons.sort_by_alpha_rounded,
              color: alphabetical ? Colors.white : AppColors.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}
