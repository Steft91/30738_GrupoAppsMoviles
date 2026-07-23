import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_text.dart';
import '../utils/snackbar_helper.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);
    final lang = ref.watch(languageProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.settingsTitle(lang),
        icon: const Icon(Icons.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              AppStrings.themeDescription(lang),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SwitchListTile(
                value: isDark,
                onChanged: (v) async {
                  await ref.read(themeProvider.notifier).setDark(v);
                  if (v) {
                    SnackbarHelper.modoOscuroActivado(context);
                  } else {
                    SnackbarHelper.modoOscuroDesactivado(context);
                  }
                },
                title: Text(AppStrings.darkMode(lang)),
                subtitle: Text(AppStrings.themeDescription(lang)),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppStrings.languageDescription(lang),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            SegmentedButton<AppLanguage>(
              segments: [
                ButtonSegment(
                  value: AppLanguage.es,
                  label: Text(AppStrings.spanish(lang)),
                  icon: const Icon(Icons.language_rounded),
                ),
                ButtonSegment(
                  value: AppLanguage.en,
                  label: Text(AppStrings.english(lang)),
                  icon: const Icon(Icons.translate_rounded),
                ),
              ],
              selected: {lang},
              onSelectionChanged: (selection) async {
                await ref
                    .read(languageProvider.notifier)
                    .setLanguage(selection.first);
              },
            ),
          ],
        ),
      ),
    );
  }
}
