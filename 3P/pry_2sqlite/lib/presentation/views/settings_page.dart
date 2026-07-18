import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';
import '../utils/snackbar_helper.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Configuración'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomText(text: 'Modo Oscuro'),
            Switch(
              value: isDark,
              onChanged: (v) async {
                await ref.read(themeProvider.notifier).setDark(v);
                if (v) {
                  SnackbarHelper.modoOscuroActivado(context);
                } else {
                  SnackbarHelper.modoOscuroDesactivado(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
