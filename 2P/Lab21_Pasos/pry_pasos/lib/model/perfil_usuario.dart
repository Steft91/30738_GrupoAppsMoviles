class PerfilUsuario {
  final String nombre;
  final double pesoKg;
  final double longitudPasoCm;
  final int metaPasos;

  const PerfilUsuario({
    required this.nombre,
    required this.pesoKg,
    required this.longitudPasoCm,
    required this.metaPasos,
  });

  // Perfil utilizado cuando el usuario todavía no ha configurado sus datos.
  factory PerfilUsuario.inicial() {
    return const PerfilUsuario(
      nombre: 'Usuario',
      pesoKg: 70,
      longitudPasoCm: 70,
      metaPasos: 8000,
    );
  }

  PerfilUsuario copyWith({
    String? nombre,
    double? pesoKg,
    double? longitudPasoCm,
    int? metaPasos,
  }) {
    return PerfilUsuario(
      nombre: nombre ?? this.nombre,
      pesoKg: pesoKg ?? this.pesoKg,
      longitudPasoCm: longitudPasoCm ?? this.longitudPasoCm,
      metaPasos: metaPasos ?? this.metaPasos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'pesoKg': pesoKg,
      'longitudPasoCm': longitudPasoCm,
      'metaPasos': metaPasos,
    };
  }

  factory PerfilUsuario.fromMap(Map<String, dynamic> map) {
    return PerfilUsuario(
      nombre: map['nombre'] as String? ?? 'Usuario',
      pesoKg: (map['pesoKg'] as num?)?.toDouble() ?? 70,
      longitudPasoCm:
          (map['longitudPasoCm'] as num?)?.toDouble() ?? 70,
      metaPasos: map['metaPasos'] as int? ?? 8000,
    );
  }
}