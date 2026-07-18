String? validarNombre(String? value) {
  if (value == null || value.trim().isEmpty) return 'El nombre es obligatorio';
  final hasDigit = RegExp(r'\d').hasMatch(value);
  if (hasDigit) return 'El nombre no debe contener números';
  return null;
}

String? validarTelefono(String? value) {
  if (value == null || value.trim().isEmpty)
    return 'El teléfono es obligatorio';
  final digitsOnly = RegExp(r'^\d{10}$');
  if (!digitsOnly.hasMatch(value)) return 'El teléfono debe tener 10 dígitos';
  return null;
}

String? validarCorreo(String? value) {
  if (value == null || value.trim().isEmpty) return 'El correo es obligatorio';
  final emailRegex = RegExp(r"^[\w\.-]+@[\w\.-]+\.\w{2,}");
  if (!emailRegex.hasMatch(value)) return 'Correo inválido';
  return null;
}
