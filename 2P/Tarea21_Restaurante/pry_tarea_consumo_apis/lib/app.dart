import 'package:flutter/material.dart';

import 'themes/index.dart';
import 'views/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurante App',
      debugShowCheckedModeBanner: false,
      theme: TemaGeneral.lightTheme,
      home: const SplashScreen(),
    );
  }
}