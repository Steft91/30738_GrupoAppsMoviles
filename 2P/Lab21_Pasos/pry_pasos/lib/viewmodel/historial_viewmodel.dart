import 'package:flutter/foundation.dart';

import '../controller/historial_controller.dart';
import '../model/actividad_diaria.dart';
import '../service/almacenamiento_service.dart';

class HistorialViewModel
    extends ChangeNotifier {
  final HistorialController
      historialController;

  final AlmacenamientoService
      almacenamientoService;

  List<ActividadDiaria> _historial = [];

  bool _estaCargando = false;
  String? _mensajeError;

  HistorialViewModel({
    required this.historialController,
    required this.almacenamientoService,
  });

  List<ActividadDiaria> get historial {
    return List.unmodifiable(_historial);
  }

  bool get estaCargando => _estaCargando;

  String? get mensajeError => _mensajeError;

  bool get estaVacio => _historial.isEmpty;

  Future<void> cargarHistorial() async {
    _estaCargando = true;
    _mensajeError = null;
    notifyListeners();

    try {
      _historial =
          await almacenamientoService
              .cargarHistorial();
    } catch (_) {
      _mensajeError =
          'No se pudo cargar el historial.';
    } finally {
      _estaCargando = false;
      notifyListeners();
    }
  }

  List<ActividadDiaria> obtenerUltimosDias({
    int cantidad = 7,
  }) {
    return historialController
        .obtenerUltimosDias(
          historial: _historial,
          cantidad: cantidad,
        );
  }

  Future<void> eliminarHistorial() async {
    await almacenamientoService
        .eliminarHistorial();

    _historial = [];
    notifyListeners();
  }

  void limpiarMensajeError() {
    _mensajeError = null;
    notifyListeners();
  }
}