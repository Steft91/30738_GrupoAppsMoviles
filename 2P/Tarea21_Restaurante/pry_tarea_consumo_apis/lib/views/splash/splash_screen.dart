import 'dart:async';

import 'package:flutter/material.dart';
import '../../widgets/atomos/boton_principal.dart';
import '../../widgets/atomos/campo_formulario.dart';
import '../../widgets/moleculas/plato_card.dart';
import '../../themes/index.dart';
import '../restaurante/plato_list_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const PlatoListView(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EsquemaColor.amarilloPrincipal,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  color: EsquemaColor.negroPrincipal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant_menu_rounded,
                  size: 62,
                  color: EsquemaColor.amarilloPrincipal,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Restaurante App',
                style: TextStyle(
                  fontSize: 31,
                  color: EsquemaColor.negroPrincipal,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pedidos rápidos y fáciles',
                style: TextStyle(
                  fontSize: 15,
                  color: EsquemaColor.negroSecundario,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}