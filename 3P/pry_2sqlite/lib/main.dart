import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/providers/theme_provider.dart';
import 'database/sqlite_service.dart';
import 'presentation/providers/contacto_provider.dart';
import 'presentation/views/splash_screen.dart';
import 'themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = await SQLiteService.init();

  runApp(
    ProviderScope(
      overrides: [databaseProvider.overrideWithValue(database)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      home: const SplashScreen(),
    );
  }
}
