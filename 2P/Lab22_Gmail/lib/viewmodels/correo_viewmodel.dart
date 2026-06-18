import 'package:flutter/foundation.dart';

import '../model/correo_model.dart';
import '../services/gmail_service.dart';

class CorreoViewModel extends ChangeNotifier {
  final GmailService _gmailService = GmailService();

  // Estado de correos
  List<CorreoModel> _correos = [];
  List<CorreoModel> _correosFiltrados = [];
  String _busqueda = '';

  // Estado de UI
  bool _estaCargando = false;
  String? _mensajeError;
  String? _mensajeExito;

  CorreoViewModel();

  // ===================== GETTERS =====================

  List<CorreoModel> get correos =>
      _busqueda.isEmpty ? _correos : _correosFiltrados;

  int get noLeidos => _correos.where((c) => !c.leido).length;

  int get totalCorreos => _correos.length;

  bool get estaCargando => _estaCargando;

  String? get mensajeError => _mensajeError;

  String? get mensajeExito => _mensajeExito;

  String get busqueda => _busqueda;

  bool get tieneBusquedaActiva => _busqueda.isNotEmpty;

  // ===================== ACCIONES LOCALES (SOBRE LA LISTA CARGADA) =====================

  /// Busca correos por asunto o remitente.
  void buscar(String query) {
    _busqueda = query.trim();

    if (_busqueda.isEmpty) {
      _correosFiltrados = [];
    } else {
      final queryLower = _busqueda.toLowerCase();
      _correosFiltrados = _correos.where((correo) {
        return correo.asunto.toLowerCase().contains(queryLower) ||
            correo.remitente.toLowerCase().contains(queryLower) ||
            correo.emailRemitente.toLowerCase().contains(queryLower);
      }).toList();
    }

    notifyListeners();
  }

  /// Limpia la búsqueda actual.
  void limpiarBusqueda() {
    _busqueda = '';
    _correosFiltrados = [];
    notifyListeners();
  }

  /// Marca un correo como leído localmente.
  void marcarComoLeido(String id) {
    final index = _correos.indexWhere((c) => c.id == id);
    if (index >= 0) {
      _correos[index].leido = true;
      notifyListeners();
    }
  }

  /// Marca todos los correos como leídos.
  void marcarTodosLeidos() {
    for (final correo in _correos) {
      correo.leido = true;
    }
    notifyListeners();
  }

  /// Alterna el estado de destacado de un correo localmente.
  void toggleDestacado(String id) {
    final index = _correos.indexWhere((c) => c.id == id);
    if (index >= 0) {
      _correos[index].destacado = !_correos[index].destacado;
      notifyListeners();
    }
  }

  /// Elimina un correo de la lista local.
  void eliminarCorreo(String id) {
    _correos.removeWhere((c) => c.id == id);
    // Actualizar filtrados también
    if (_busqueda.isNotEmpty) {
      _correosFiltrados.removeWhere((c) => c.id == id);
    }
    notifyListeners();
  }

  /// Simula la recepción de correos marcando mensajes leídos como no leídos.
  void recibirCorreo() {
    for (final correo in _correos) {
      if (correo.leido) {
        correo.leido = false;
        break;
      }
    }
    notifyListeners();
  }

  // ===================== ACCIONES CON GMAIL API REAL =====================

  /// Carga correos reales desde la API de Gmail.
  Future<void> cargarCorreosReales(String accessToken) async {
    _estaCargando = true;
    _mensajeError = null;
    notifyListeners();

    try {
      final correosReales = await _gmailService.obtenerCorreos(
        accessToken,
        maxResultados: 20,
      );
      _correos = correosReales;
    } catch (e) {
      _mensajeError = 'No se pudieron cargar los correos: $e';
    } finally {
      _estaCargando = false;
      notifyListeners();
    }
  }

  /// Envía un correo real a través de Gmail API.
  Future<bool> enviarCorreoReal(
    String accessToken, {
    required String para,
    required String asunto,
    required String cuerpo,
    String? de,
  }) async {
    _estaCargando = true;
    _mensajeError = null;
    _mensajeExito = null;
    notifyListeners();

    try {
      final enviado = await _gmailService.enviarCorreo(
        accessToken,
        para: para,
        asunto: asunto,
        cuerpo: cuerpo,
        de: de,
      );

      if (enviado) {
        _mensajeExito = 'Correo enviado correctamente';
        // Recargar la bandeja de entrada
        await cargarCorreosReales(accessToken);
        return true;
      } else {
        _mensajeError = 'No se pudo enviar el correo';
        return false;
      }
    } catch (e) {
      _mensajeError = 'Error al enviar el correo: $e';
      return false;
    } finally {
      _estaCargando = false;
      notifyListeners();
    }
  }

  // ===================== UTILIDADES =====================

  void limpiarMensajes() {
    _mensajeError = null;
    _mensajeExito = null;
    notifyListeners();
  }

  void limpiarMensajeError() {
    _mensajeError = null;
    notifyListeners();
  }
}
