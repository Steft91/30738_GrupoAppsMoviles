class UsuarioModel {
  final String nombre;
  final String email;
  final String? fotoUrl;
  final String? accessToken;

  const UsuarioModel({
    required this.nombre,
    required this.email,
    this.fotoUrl,
    this.accessToken,
  });


  UsuarioModel copyWith({
    String? nombre,
    String? email,
    String? fotoUrl,
    String? accessToken,
  }) {
    return UsuarioModel(
      nombre: nombre ?? this.nombre,
      email: email ?? this.email,
      fotoUrl: fotoUrl ?? this.fotoUrl,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  bool get tieneToken => accessToken != null && accessToken!.isNotEmpty;
}
