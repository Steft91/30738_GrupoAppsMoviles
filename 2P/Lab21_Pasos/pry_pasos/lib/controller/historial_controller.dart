import '../model/actividad_diaria.dart';
import '../model/perfil_usuario.dart';
import 'pasos_controller.dart';

class HistorialController {
  final PasosController pasosController;

  HistorialController(this.pasosController);

  ActividadDiaria crearActividad({
    required DateTime fecha,
    required int pasos,
    required PerfilUsuario perfil,
  }) {
    final distancia = pasosController.calcularDistanciaKm(
      pasos: pasos,
      longitudPasoCm: perfil.longitudPasoCm,
    );

    final calorias = pasosController.calcularCalorias(
      distanciaKm: distancia,
      pesoKg: perfil.pesoKg,
    );

    return ActividadDiaria(
      fecha: _normalizarFecha(fecha),
      pasos: pasos,
      distanciaKm: distancia,
      calorias: calorias,
      metaPasos: perfil.metaPasos,
    );
  }

  List<ActividadDiaria> guardarOActualizar({
    required List<ActividadDiaria> historial,
    required ActividadDiaria actividad,
  }) {
    final nuevaLista = List<ActividadDiaria>.from(
      historial,
    );

    final indice = nuevaLista.indexWhere(
      (elemento) => _esMismaFecha(
        elemento.fecha,
        actividad.fecha,
      ),
    );

    if (indice >= 0) {
      nuevaLista[indice] = actividad;
    } else {
      nuevaLista.add(actividad);
    }

    nuevaLista.sort(
      (a, b) => b.fecha.compareTo(a.fecha),
    );

    return nuevaLista;
  }

  ActividadDiaria? buscarPorFecha({
    required List<ActividadDiaria> historial,
    required DateTime fecha,
  }) {
    for (final actividad in historial) {
      if (_esMismaFecha(actividad.fecha, fecha)) {
        return actividad;
      }
    }

    return null;
  }

  List<ActividadDiaria> obtenerUltimosDias({
    required List<ActividadDiaria> historial,
    int cantidad = 7,
  }) {
    final listaOrdenada = List<ActividadDiaria>.from(
      historial,
    );

    listaOrdenada.sort(
      (a, b) => b.fecha.compareTo(a.fecha),
    );

    return listaOrdenada.take(cantidad).toList();
  }

  bool _esMismaFecha(
    DateTime primera,
    DateTime segunda,
  ) {
    return primera.year == segunda.year &&
        primera.month == segunda.month &&
        primera.day == segunda.day;
  }

  DateTime _normalizarFecha(DateTime fecha) {
    return DateTime(
      fecha.year,
      fecha.month,
      fecha.day,
    );
  }
}