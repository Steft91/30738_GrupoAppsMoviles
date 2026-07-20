import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';

class PhoneCallService {
  /// Realiza una llamada telefónica directa
  /// 
  /// Pasos:
  /// 1. Solicita permiso CALL_PHONE
  /// 2. Valida el número
  /// 3. Convierte a formato internacional (+593...)
  /// 4. Ejecuta la llamada
  Future<bool> makeCall(String phoneNumber) async {
    try {
      // Validar que el número no esté vacío
      if (phoneNumber.trim().isEmpty) {
        print('❌ Error: Número telefónico vacío');
        return false;
      }

      // Solicitar permiso
      final PermissionStatus status = await Permission.phone.request();
      
      if (status.isDenied) {
        print('❌ Permiso CALL_PHONE denegado por el usuario');
        return false;
      }

      if (status.isPermanentlyDenied) {
        print('❌ Permiso CALL_PHONE denegado permanentemente');
        openAppSettings();
        return false;
      }

      // Normalizar número: remover espacios y caracteres especiales
      String normalizado = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

      // Si no tiene +, agregar código de país de Ecuador
      if (!normalizado.startsWith('+')) {
        // Si comienza con 0, removerlo (formato nacional ecuatoriano)
        if (normalizado.startsWith('0')) {
          normalizado = normalizado.substring(1);
        }
        // Agregar código de país
        normalizado = '+593$normalizado';
      }

      print('📞 Llamando a: $normalizado');

      // Ejecutar llamada
      await FlutterPhoneDirectCaller.callNumber(normalizado);
      return true;
    } catch (e) {
      print('❌ Error al realizar la llamada: $e');
      return false;
    }
  }
}
