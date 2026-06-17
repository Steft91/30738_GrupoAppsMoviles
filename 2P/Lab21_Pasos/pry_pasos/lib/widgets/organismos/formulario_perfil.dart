import 'package:flutter/material.dart';

import '../../model/perfil_usuario.dart';
import '../../theme/tema_tarjetas.dart';
import '../moleculas/campo_perfil.dart';

class FormularioPerfil
    extends StatefulWidget {
  final PerfilUsuario perfil;
  final bool estaGuardando;

  final Future<void> Function({
    required String nombre,
    required double pesoKg,
    required double longitudPasoCm,
    required int metaPasos,
  })
  onGuardar;

  const FormularioPerfil({
    super.key,
    required this.perfil,
    required this.estaGuardando,
    required this.onGuardar,
  });

  @override
  State<FormularioPerfil> createState() =>
      _FormularioPerfilState();
}

class _FormularioPerfilState
    extends State<FormularioPerfil> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController
      _nombreController;

  late final TextEditingController
      _pesoController;

  late final TextEditingController
      _longitudController;

  late final TextEditingController
      _metaController;

  @override
  void initState() {
    super.initState();

    _nombreController =
        TextEditingController(
          text: widget.perfil.nombre,
        );

    _pesoController =
        TextEditingController(
          text: widget.perfil.pesoKg
              .toStringAsFixed(1),
        );

    _longitudController =
        TextEditingController(
          text: widget
              .perfil
              .longitudPasoCm
              .toStringAsFixed(1),
        );

    _metaController =
        TextEditingController(
          text: widget.perfil.metaPasos
              .toString(),
        );
  }

  @override
  void didUpdateWidget(
    FormularioPerfil oldWidget,
  ) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.perfil != widget.perfil) {
      _nombreController.text =
          widget.perfil.nombre;

      _pesoController.text =
          widget.perfil.pesoKg
              .toStringAsFixed(1);

      _longitudController.text =
          widget.perfil.longitudPasoCm
              .toStringAsFixed(1);

      _metaController.text =
          widget.perfil.metaPasos
              .toString();
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _pesoController.dispose();
    _longitudController.dispose();
    _metaController.dispose();

    super.dispose();
  }

  Future<void> _guardar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final peso = double.tryParse(
      _pesoController.text,
    );

    final longitud = double.tryParse(
      _longitudController.text,
    );

    final meta = int.tryParse(
      _metaController.text,
    );

    if (peso == null ||
        longitud == null ||
        meta == null) {
      return;
    }

    await widget.onGuardar(
      nombre: _nombreController.text,
      pesoKg: peso,
      longitudPasoCm: longitud,
      metaPasos: meta,
    );
  }

  String? _validarTexto(String? valor) {
    if (valor == null ||
        valor.trim().isEmpty) {
      return 'Este campo es obligatorio.';
    }

    return null;
  }

  String? _validarNumero(String? valor) {
    final numero = double.tryParse(
      valor ?? '',
    );

    if (numero == null || numero <= 0) {
      return 'Ingrese un valor válido.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration:
          TemaTarjetas.tarjetaPrincipal,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CampoPerfil(
              controller:
                  _nombreController,
              etiqueta: 'Nombre',
              sugerencia:
                  'Ingrese su nombre',
              icono:
                  Icons.person_rounded,
              validator: _validarTexto,
            ),
            const SizedBox(height: 16),
            CampoPerfil(
              controller:
                  _pesoController,
              etiqueta: 'Peso',
              sugerencia: 'Ejemplo: 70',
              icono:
                  Icons.monitor_weight,
              sufijo: 'kg',
              tipoTeclado:
                  const TextInputType
                      .numberWithOptions(
                        decimal: true,
                      ),
              validator: _validarNumero,
            ),
            const SizedBox(height: 16),
            CampoPerfil(
              controller:
                  _longitudController,
              etiqueta:
                  'Longitud del paso',
              sugerencia: 'Ejemplo: 70',
              icono:
                  Icons.straighten_rounded,
              sufijo: 'cm',
              tipoTeclado:
                  const TextInputType
                      .numberWithOptions(
                        decimal: true,
                      ),
              validator: _validarNumero,
            ),
            const SizedBox(height: 16),
            CampoPerfil(
              controller:
                  _metaController,
              etiqueta:
                  'Meta diaria',
              sugerencia: 'Ejemplo: 8000',
              icono:
                  Icons.flag_rounded,
              sufijo: 'pasos',
              tipoTeclado:
                  TextInputType.number,
              validator: _validarNumero,
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    widget.estaGuardando
                    ? null
                    : _guardar,
                icon: widget.estaGuardando
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
                              strokeWidth: 3,
                            ),
                      )
                    : const Icon(
                        Icons.save_rounded,
                      ),
                label: Text(
                  widget.estaGuardando
                      ? 'GUARDANDO...'
                      : 'GUARDAR PERFIL',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}