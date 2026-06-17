import 'package:flutter/material.dart';
import '../../../themes/esquema_color.dart';

class BotonPersonalizado extends StatelessWidget {
  final String texto;
  final VoidCallback alPresionar;

  const BotonPersonalizado({
    super.key,
    required this.texto,
    required this.alPresionar,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: alPresionar,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                EsquemaColor.lavanda,
                EsquemaColor.azulPastel,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: EsquemaColor.lavanda.withOpacity(0.32),
                blurRadius: 20,
                offset: const Offset(0, 9),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            texto,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}