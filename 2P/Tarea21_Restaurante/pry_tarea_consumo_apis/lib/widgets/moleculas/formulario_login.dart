import 'package:flutter/material.dart';

import '../atomos/campos_texto_personalizado.dart';
import '../atomos/boton_personalizado.dart';
import '../atomos/tarjeta_cristal.dart';
import '../../../themes/esquema_color.dart';

class FormularioLogin extends StatelessWidget {
  final TextEditingController usuarioCtrl;
  final TextEditingController contrasenaCtrl;
  final VoidCallback alEnviar;

  const FormularioLogin({
    super.key,
    required this.usuarioCtrl,
    required this.contrasenaCtrl,
    required this.alEnviar,
  });

  @override
  Widget build(BuildContext context) {
    return TarjetaCristal(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  EsquemaColor.rosaPastel,
                  EsquemaColor.lavanda,
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: EsquemaColor.lavanda.withOpacity(0.3),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 48,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Bienvenido",
            style: TextStyle(
              color: EsquemaColor.textoPrincipal,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Ingresa tus datos para continuar",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: EsquemaColor.textoSecundario,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 30),
          CampoTextoPersonalizado(
            etiqueta: "Usuario",
            icono: Icons.person_outline_rounded,
            controlador: usuarioCtrl,
          ),
          const SizedBox(height: 16),
          CampoTextoPersonalizado(
            etiqueta: "Contraseña",
            icono: Icons.lock_outline_rounded,
            controlador: contrasenaCtrl,
            ocultarTexto: true,
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: BotonPersonalizado(
              texto: "Ingresar",
              alPresionar: alEnviar,
            ),
          ),
        ],
      ),
    );
  }
}