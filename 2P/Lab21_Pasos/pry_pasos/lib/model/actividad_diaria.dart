class ActividadDiaria {
  final DateTime fecha;
  final int pasos;
  final double distanciaKm;
  final double calorias;
  final int metaPasos;

  const ActividadDiaria({
    required this.fecha,
    required this.pasos,
    required this.distanciaKm,
    required this.calorias,
    required this.metaPasos,
  });

  // Indica si el usuario alcanzó su meta diaria.
  bool get metaAlcanzada {
    return pasos >= metaPasos;
  }

  // Devuelve el progreso en un valor entre 0 y 1.
  double get progreso {
    if (metaPasos <= 0) {
      return 0;
    }

    final resultado = pasos / metaPasos;

    if (resultado > 1) {
      return 1;
    }

    return resultado;
  }

  ActividadDiaria copyWith({
    DateTime? fecha,
    int? pasos,
    double? distanciaKm,
    double? calorias,
    int? metaPasos,
  }) {
    return ActividadDiaria(
      fecha: fecha ?? this.fecha,
      pasos: pasos ?? this.pasos,
      distanciaKm: distanciaKm ?? this.distanciaKm,
      calorias: calorias ?? this.calorias,
      metaPasos: metaPasos ?? this.metaPasos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fecha': fecha.toIso8601String(),
      'pasos': pasos,
      'distanciaKm': distanciaKm,
      'calorias': calorias,
      'metaPasos': metaPasos,
    };
  }

  factory ActividadDiaria.fromMap(Map<String, dynamic> map) {
    return ActividadDiaria(
      fecha:
          DateTime.tryParse(map['fecha'] as String? ?? '') ??
          DateTime.now(),
      pasos: map['pasos'] as int? ?? 0,
      distanciaKm:
          (map['distanciaKm'] as num?)?.toDouble() ?? 0,
      calorias: (map['calorias'] as num?)?.toDouble() ?? 0,
      metaPasos: map['metaPasos'] as int? ?? 8000,
    );
  }
}