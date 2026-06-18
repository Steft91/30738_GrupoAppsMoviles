class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  static const String platos = '$baseUrl/platos';
  static const String pedidos = '$baseUrl/pedidos';
}
