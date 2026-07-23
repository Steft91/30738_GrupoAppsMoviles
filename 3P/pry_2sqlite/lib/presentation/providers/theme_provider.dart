import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:state_notifier/state_notifier.dart';

class ThemeNotifier extends StateNotifier<bool> {
  static const _prefKey = 'isDarkMode';

  ThemeNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool(_prefKey) ?? false;
  }

  Future<void> toggle() async {
    final prefs = await SharedPreferences.getInstance();
    state = !state;
    await prefs.setBool(_prefKey, state);
  }

  Future<void> setDark(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    state = value;
    await prefs.setBool(_prefKey, state);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

// Shared editing id used across pages when user selects 'edit'
final editingContactoProvider = StateProvider<int?>((ref) => null);

enum AppLanguage { es, en }

extension AppLanguageX on AppLanguage {
  String get code => this == AppLanguage.es ? 'es' : 'en';

  static AppLanguage fromCode(String? code) {
    return code == 'en' ? AppLanguage.en : AppLanguage.es;
  }
}

class LanguageNotifier extends StateNotifier<AppLanguage> {
  static const _prefKey = 'appLanguage';

  LanguageNotifier() : super(AppLanguage.es) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    state = AppLanguageX.fromCode(prefs.getString(_prefKey));
  }

  Future<void> setLanguage(AppLanguage value) async {
    final prefs = await SharedPreferences.getInstance();
    state = value;
    await prefs.setString(_prefKey, value.code);
  }
}

final languageProvider = StateNotifierProvider<LanguageNotifier, AppLanguage>(
  (ref) => LanguageNotifier(),
);
