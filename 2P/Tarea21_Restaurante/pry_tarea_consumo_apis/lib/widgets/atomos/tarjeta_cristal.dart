import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../themes/tema_fondos.dart';

class TarjetaCristal extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? alPresionar;

  const TarjetaCristal({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),
        child: InkWell(
          onTap: alPresionar,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: padding,
            decoration: TemaFondos.aeroGlass(),
            child: child,
          ),
        ),
      ),
    );
  }
}