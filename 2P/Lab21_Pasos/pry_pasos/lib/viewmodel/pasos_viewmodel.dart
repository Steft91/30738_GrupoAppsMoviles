import 'package:flutter/foundation.dart';

import '../controller/historial_controller.dart';
import '../controller/pasos_controller.dart';
import '../model/actividad_diaria.dart';
import '../model/perfil_usuario.dart';
import '../service/almacenamiento_service.dart';

class PasosViewModel extends ChangeNotifier {
  final PasosController pasosController;
  final HistorialController historialController;
  final AlmacenamientoService almacenamientoService;

  PerfilUsuario _perfil =
      PerfilUsuario.inicial();

  List<ActividadDiaria> _historial = [];

  int _pasos = 0;
  double _distanciaKm = 0;
  double _calorias = 0;
  double _progreso = 0;

  bool _estaCargando = false;
  bool _estaActivo = false;

  String? _mensajeError;

  PasosViewModel({
    required this.pasosController,
    required this.historialController,
    required this.almacenamientoService,
  });

  PerfilUsuario get perfil => _perfil;

  int get pasos => _pasos;

  double get distanciaKm => _distanciaKm;

  double get calorias => _calorias;

  double get progreso => _progreso;

  bool get estaCargando => _estaCargando;

  bool get estaActivo => _estaActivo;

  String? get mensajeError => _mensajeError;

  int get pasosRestantes {
    final restantes =
        _perfil.metaPasos - _pasos;

    return restantes < 0 ? 0 : restantes;
  }

  bool get metaAlcanzada {
    return _pasos >= _perfil.metaPasos;
  }

  Future<void> inicializar() async {
    _estaCargando = true;
    _mensajeError = null;
    notifyListeners();

    try {
      _perfil =
          await almacenamientoService
              .cargarPerfil();

      _historial =
          await almacenamientoService
              .cargarHistorial();

      _cargarActividadActual();
      _actualizarCalculos();
    } catch (_) {
      _mensajeError =
          'No se pudieron cargar los datos.';
    } finally {
      _estaCargando = false;
      notifyListeners();
    }
  }

  void _cargarActividadActual() {
    final actividadActual =
        historialController.buscarPorFecha(
          historial: _historial,
          fecha: DateTime.now(),
        );

    if (actividadActual != null) {
      _pasos = actividadActual.pasos;
    } else {
      _pasos = 0;
    }
  }

  Future<void> iniciarConteo() async {
    if (_estaActivo) {
      return;
    }

    _mensajeError = null;

    try {
      await pasosController.iniciar(
        onPasoDetectado: _registrarPaso,
        onError: _procesarErrorSensor,
      );

      _estaActivo = true;
      notifyListeners();
    } catch (_) {
      _mensajeError =
          'No fue posible iniciar los sensores.';
      _estaActivo = false;
      notifyListeners();
    }
  }

  void _registrarPaso() {
    _pasos++;
    _actualizarCalculos();
    notifyListeners();

    // Evita escribir en almacenamiento en cada paso.
    if (_pasos % 10 == 0) {
      guardarActividadActual();
    }
  }

  void _actualizarCalculos() {
    _distanciaKm =
        pasosController.calcularDistanciaKm(
          pasos: _pasos,
          longitudPasoCm:
              _perfil.longitudPasoCm,
        );

    _calorias =
        pasosController.calcularCalorias(
          distanciaKm: _distanciaKm,
          pesoKg: _perfil.pesoKg,
        );

    _progreso =
        pasosController.calcularProgreso(
          pasos: _pasos,
          metaPasos: _perfil.metaPasos,
        );
  }

  void _procesarErrorSensor(
    Object error,
  ) {
    _mensajeError =
        'Se produjo un error al leer los sensores.';
    _estaActivo = false;
    notifyListeners();
  }

  Future<void> detenerConteo() async {
    await pasosController.detener();

    _estaActivo = false;
    await guardarActividadActual();

    notifyListeners();
  }

  Future<void> guardarActividadActual() async {
    final actividad =
        historialController.crearActividad(
          fecha: DateTime.now(),
          pasos: _pasos,
          perfil: _perfil,
        );

    _historial =
        historialController.guardarOActualizar(
          historial: _historial,
          actividad: actividad,
        );

    await almacenamientoService
        .guardarHistorial(_historial);
  }

  Future<void> reiniciarConteo() async {
    _pasos = 0;
    _actualizarCalculos();

    await guardarActividadActual();
    notifyListeners();
  }

  Future<void> actualizarPerfil(
    PerfilUsuario perfil,
  ) async {
    _perfil = perfil;

    await almacenamientoService
        .guardarPerfil(perfil);

    _actualizarCalculos();
    await guardarActividadActual();

    notifyListeners();
  }

  void limpiarMensajeError() {
    _mensajeError = null;
    notifyListeners();
  }

  @override
  void dispose() {
    pasosController.dispose();
    super.dispose();
  }
}