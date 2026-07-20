import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/services/phone_call_service.dart';

/// Proveedor que expone el servicio de llamadas telefónicas
/// 
/// Uso:
/// ```dart
/// ref.read(phoneProvider).makeCall('0991234567');
/// ```
final phoneProvider = Provider<PhoneCallService>((ref) {
  return PhoneCallService();
});
