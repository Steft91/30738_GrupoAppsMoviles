class Plato {
  final int? id;
  final String nombre;
  final String? descripcion;
  final double precio;
  final String? imagenUrl;
  final bool disponible;

  Plato({
    this.id,
    required this.nombre,
    this.descripcion,
    required this.precio,
    this.imagenUrl,
    required this.disponible,
  });

  factory Plato.fromJson(Map<String, dynamic> json) {
    return Plato(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: double.parse(json['precio'].toString()),
      imagenUrl: json['imagen_url'] ?? json['imagenUrl'],
      disponible: json['disponible'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'imagen_url': imagenUrl,
      'disponible': disponible,
    };
  }
}
