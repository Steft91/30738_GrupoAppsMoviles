import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/actividad_diaria.dart';
import '../model/perfil_usuario.dart';

class AlmacenamientoService {
  static const String _clavePerfil =
      'perfil_usuario';

  static const String _claveHistorial =
      'historial_actividad';

  final SharedPreferencesAsync _preferencias =
      SharedPreferencesAsync();

  Future<void> guardarPerfil(
    PerfilUsuario perfil,
  ) async {
    final perfilJson = jsonEncode(
      perfil.toMap(),
    );

    await _preferencias.setString(
      _clavePerfil,
      perfilJson,
    );
  }

  Future<PerfilUsuario> cargarPerfil() async {
    final perfilJson =
        await _preferencias.getString(
          _clavePerfil,
        );

    if (perfilJson == null ||
        perfilJson.isEmpty) {
      return PerfilUsuario.inicial();
    }

    try {
      final mapa = jsonDecode(
        perfilJson,
      ) as Map<String, dynamic>;

      return PerfilUsuario.fromMap(mapa);
    } catch (_) {
      return PerfilUsuario.inicial();
    }
  }

  Future<void> guardarHistorial(
    List<ActividadDiaria> historial,
  ) async {
    final historialJson = historial
        .map(
          (actividad) => jsonEncode(
            actividad.toMap(),
          ),
        )
        .toList();

    await _preferencias.setStringList(
      _claveHistorial,
      historialJson,
    );
  }

  Future<List<ActividadDiaria>>
      cargarHistorial() async {
    final historialJson =
        await _preferencias.getStringList(
          _claveHistorial,
        );

    if (historialJson == null) {
      return [];
    }

    final actividades = <ActividadDiaria>[];

    for (final elemento in historialJson) {
      try {
        final mapa = jsonDecode(
          elemento,
        ) as Map<String, dynamic>;

        actividades.add(
          ActividadDiaria.fromMap(mapa),
        );
      } catch (_) {
        // Ignora solamente el registro dañado.
      }
    }

    actividades.sort(
      (a, b) => b.fecha.compareTo(a.fecha),
    );

    return actividades;
  }

  Future<void> eliminarHistorial() async {
    await _preferencias.remove(
      _claveHistorial,
    );
  }

  Future<void> eliminarPerfil() async {
    await _preferencias.remove(
      _clavePerfil,
    );
  }

  Future<void> eliminarTodosLosDatos() async {
    await eliminarPerfil();
    await eliminarHistorial();
  }
}