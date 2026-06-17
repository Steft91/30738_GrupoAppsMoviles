import 'package:flutter/foundation.dart';

import '../model/perfil_usuario.dart';
import '../service/almacenamiento_service.dart';

class PerfilViewModel extends ChangeNotifier {
  final AlmacenamientoService
      almacenamientoService;

  PerfilUsuario _perfil =
      PerfilUsuario.inicial();

  bool _estaCargando = false;
  bool _estaGuardando = false;

  String? _mensajeError;
  String? _mensajeExito;

  PerfilViewModel({
    required this.almacenamientoService,
  });

  PerfilUsuario get perfil => _perfil;

  bool get estaCargando => _estaCargando;

  bool get estaGuardando => _estaGuardando;

  String? get mensajeError => _mensajeError;

  String? get mensajeExito => _mensajeExito;

  Future<void> cargarPerfil() async {
    _estaCargando = true;
    _mensajeError = null;
    notifyListeners();

    try {
      _perfil =
          await almacenamientoService
              .cargarPerfil();
    } catch (_) {
      _mensajeError =
          'No se pudo cargar el perfil.';
    } finally {
      _estaCargando = false;
      notifyListeners();
    }
  }

  Future<bool> guardarPerfil({
    required String nombre,
    required double pesoKg,
    required double longitudPasoCm,
    required int metaPasos,
  }) async {
    _mensajeError = null;
    _mensajeExito = null;

    if (nombre.trim().isEmpty) {
      _mensajeError =
          'Ingrese el nombre del usuario.';
      notifyListeners();
      return false;
    }

    if (pesoKg <= 0) {
      _mensajeError =
          'El peso debe ser mayor que cero.';
      notifyListeners();
      return false;
    }

    if (longitudPasoCm <= 0) {
      _mensajeError =
          'La longitud del paso debe ser mayor que cero.';
      notifyListeners();
      return false;
    }

    if (metaPasos <= 0) {
      _mensajeError =
          'La meta debe ser mayor que cero.';
      notifyListeners();
      return false;
    }

    _estaGuardando = true;
    notifyListeners();

    try {
      _perfil = PerfilUsuario(
        nombre: nombre.trim(),
        pesoKg: pesoKg,
        longitudPasoCm:
            longitudPasoCm,
        metaPasos: metaPasos,
      );

      await almacenamientoService
          .guardarPerfil(_perfil);

      _mensajeExito =
          'Perfil actualizado correctamente.';

      return true;
    } catch (_) {
      _mensajeError =
          'No se pudo guardar el perfil.';
      return false;
    } finally {
      _estaGuardando = false;
      notifyListeners();
    }
  }

  void limpiarMensajes() {
    _mensajeError = null;
    _mensajeExito = null;
    notifyListeners();
  }
}