import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  StreamSubscription<UserAccelerometerEvent>?
      _acelerometroSubscription;

  StreamSubscription<GyroscopeEvent>?
      _giroscopioSubscription;

  bool _estaActivo = false;

  bool get estaActivo => _estaActivo;

  Future<void> iniciar({
    required void Function(UserAccelerometerEvent evento)
        onAcelerometro,
    required void Function(GyroscopeEvent evento)
        onGiroscopio,
    void Function(Object error)? onError,
  }) async {
    if (_estaActivo) {
      return;
    }

    _estaActivo = true;

    _acelerometroSubscription =
        userAccelerometerEventStream(
          samplingPeriod: SensorInterval.gameInterval,
        ).listen(
          onAcelerometro,
          onError: onError,
        );

    _giroscopioSubscription = gyroscopeEventStream(
      samplingPeriod: SensorInterval.gameInterval,
    ).listen(
      onGiroscopio,
      onError: onError,
    );
  }

  Future<void> detener() async {
    await _acelerometroSubscription?.cancel();
    await _giroscopioSubscription?.cancel();

    _acelerometroSubscription = null;
    _giroscopioSubscription = null;
    _estaActivo = false;
  }

  Future<void> dispose() async {
    await detener();
  }
}