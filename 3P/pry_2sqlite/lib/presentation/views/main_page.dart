import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'contacto_page.dart';
import 'contacts_page.dart';
import 'settings_page.dart';
import '../providers/theme_provider.dart';
import '../utils/app_strings.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _goToHome() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider);
    final pages = <Widget>[
      const ContactoPage(),
      ContactsPage(onEditAndGoHome: _goToHome),
      const SettingsPage(),
    ];

    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppStrings.homeTab(lang),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: AppStrings.contactsTab(lang),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppStrings.settingsTab(lang),
          ),
        ],
      ),
    );
  }
}
