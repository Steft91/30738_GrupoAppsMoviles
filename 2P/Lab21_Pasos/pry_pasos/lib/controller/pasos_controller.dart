import 'dart:math';

import 'package:sensors_plus/sensors_plus.dart';

import '../service/sensor_service.dart';

class PasosController {
  final SensorService sensorService;

  DateTime? _ultimoPaso;

  double _rotacionActual = 0;
  bool _movimientoSuperoUmbral = false;

  final double umbralPaso;
  final double umbralReinicio;
  final double rotacionMaxima;
  final Duration intervaloMinimo;

  PasosController(
    this.sensorService, {
    this.umbralPaso = 1.25,
    this.umbralReinicio = 0.55,
    this.rotacionMaxima = 5.0,
    this.intervaloMinimo =
        const Duration(milliseconds: 350),
  });

  bool get estaActivo => sensorService.estaActivo;

  Future<void> iniciar({
    required void Function() onPasoDetectado,
    void Function(Object error)? onError,
  }) async {
    await sensorService.iniciar(
      onAcelerometro: (evento) {
        _procesarAcelerometro(
          evento,
          onPasoDetectado,
        );
      },
      onGiroscopio: _procesarGiroscopio,
      onError: onError,
    );
  }

  void _procesarGiroscopio(
    GyroscopeEvent evento,
  ) {
    _rotacionActual = sqrt(
      pow(evento.x, 2) +
          pow(evento.y, 2) +
          pow(evento.z, 2),
    );
  }

  void _procesarAcelerometro(
    UserAccelerometerEvent evento,
    void Function() onPasoDetectado,
  ) {
    final magnitud = sqrt(
      pow(evento.x, 2) +
          pow(evento.y, 2) +
          pow(evento.z, 2),
    );

    final movimientoValido =
        magnitud >= umbralPaso &&
        _rotacionActual <= rotacionMaxima;

    if (movimientoValido &&
        !_movimientoSuperoUmbral) {
      _movimientoSuperoUmbral = true;

      if (_puedeRegistrarPaso()) {
        _ultimoPaso = DateTime.now();
        onPasoDetectado();
      }
    }

    if (magnitud <= umbralReinicio) {
      _movimientoSuperoUmbral = false;
    }
  }

  bool _puedeRegistrarPaso() {
    if (_ultimoPaso == null) {
      return true;
    }

    final tiempoTranscurrido =
        DateTime.now().difference(_ultimoPaso!);

    return tiempoTranscurrido >= intervaloMinimo;
  }

  double calcularDistanciaKm({
    required int pasos,
    required double longitudPasoCm,
  }) {
    if (pasos <= 0 || longitudPasoCm <= 0) {
      return 0;
    }

    final distanciaCm =
        pasos * longitudPasoCm;

    return distanciaCm / 100000;
  }

  double calcularCalorias({
    required double distanciaKm,
    required double pesoKg,
  }) {
    if (distanciaKm <= 0 || pesoKg <= 0) {
      return 0;
    }

    const factorCaminata = 0.5;

    return distanciaKm *
        pesoKg *
        factorCaminata;
  }

  double calcularProgreso({
    required int pasos,
    required int metaPasos,
  }) {
    if (pasos <= 0 || metaPasos <= 0) {
      return 0;
    }

    final progreso = pasos / metaPasos;

    return progreso.clamp(0.0, 1.0);
  }

  Future<void> detener() async {
    await sensorService.detener();

    _movimientoSuperoUmbral = false;
    _rotacionActual = 0;
  }

  Future<void> dispose() async {
    await sensorService.dispose();
  }
}