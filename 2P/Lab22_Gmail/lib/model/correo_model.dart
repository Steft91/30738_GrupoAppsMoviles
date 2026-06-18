class CorreoModel {
  final String id;
  final String remitente;
  final String emailRemitente;
  final String asunto;
  final String cuerpo;
  final DateTime fecha;
  bool leido;
  bool destacado;

  CorreoModel({
    required this.id,
    required this.remitente,
    required this.emailRemitente,
    required this.asunto,
    required this.cuerpo,
    required this.fecha,
    this.leido = false,
    this.destacado = false,
  });

  CorreoModel copyWith({
    String? id,
    String? remitente,
    String? emailRemitente,
    String? asunto,
    String? cuerpo,
    DateTime? fecha,
    bool? leido,
    bool? destacado,
  }) {
    return CorreoModel(
      id: id ?? this.id,
      remitente: remitente ?? this.remitente,
      emailRemitente: emailRemitente ?? this.emailRemitente,
      asunto: asunto ?? this.asunto,
      cuerpo: cuerpo ?? this.cuerpo,
      fecha: fecha ?? this.fecha,
      leido: leido ?? this.leido,
      destacado: destacado ?? this.destacado,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'remitente': remitente,
      'emailRemitente': emailRemitente,
      'asunto': asunto,
      'cuerpo': cuerpo,
      'fecha': fecha.toIso8601String(),
      'leido': leido,
      'destacado': destacado,
    };
  }

  factory CorreoModel.fromMap(Map<String, dynamic> map) {
    return CorreoModel(
      id: map['id'] as String? ?? '',
      remitente: map['remitente'] as String? ?? '',
      emailRemitente: map['emailRemitente'] as String? ?? '',
      asunto: map['asunto'] as String? ?? '(Sin asunto)',
      cuerpo: map['cuerpo'] as String? ?? '',
      fecha: DateTime.tryParse(map['fecha'] as String? ?? '') ?? DateTime.now(),
      leido: map['leido'] as bool? ?? false,
      destacado: map['destacado'] as bool? ?? false,
    );
  }

  /// Crea un CorreoModel a partir de un mensaje de la API de Gmail.
  factory CorreoModel.fromGmailMessage(Map<String, dynamic> message) {
    final headers = <String, String>{};
    final payload = message['payload'] as Map<String, dynamic>?;

    if (payload != null && payload['headers'] != null) {
      for (final header in (payload['headers'] as List)) {
        final name = (header['name'] as String).toLowerCase();
        headers[name] = header['value'] as String? ?? '';
      }
    }

    final from = headers['from'] ?? '';
    String remitente = from;
    String emailRemitente = from;

    // Extraer nombre y email de formato "Nombre <email@example.com>"
    final match = RegExp(r'^(.+?)\s*<(.+?)>$').firstMatch(from);
    if (match != null) {
      remitente = match.group(1)?.replaceAll('"', '').trim() ?? from;
      emailRemitente = match.group(2) ?? from;
    }

    // Decodificar el cuerpo del mensaje
    String cuerpo = '';
    if (payload != null) {
      cuerpo = _extraerCuerpo(payload);
    }

    return CorreoModel(
      id: message['id'] as String? ?? '',
      remitente: remitente,
      emailRemitente: emailRemitente,
      asunto: headers['subject'] ?? '(Sin asunto)',
      cuerpo: cuerpo,
      fecha: _parsearFechaGmail(headers['date']),
      leido: () {
        final labelIds = message['labelIds'] as List?;
        final tieneUnRead = labelIds?.contains('UNREAD') ?? false;
        return !tieneUnRead;
      }(),
      destacado: (message['labelIds'] as List?)?.contains('STARRED') ?? false,
    );
  }

  static String _extraerCuerpo(Map<String, dynamic> payload) {
    // Intentar obtener del body directo
    final body = payload['body'] as Map<String, dynamic>?;
    if (body != null) {
      final data = body['data'] as String?;
      if (data != null && data.isNotEmpty) {
        return _decodificarBase64Url(data);
      }
    }

    // Buscar en las partes (multipart)
    final parts = payload['parts'] as List?;
    if (parts != null) {
      for (final part in parts) {
        final mimeType = part['mimeType'] as String?;
        if (mimeType == 'text/plain') {
          final partBody = part['body'] as Map<String, dynamic>?;
          final data = partBody?['data'] as String?;
          if (data != null && data.isNotEmpty) {
            return _decodificarBase64Url(data);
          }
        }
      }
      // Si no hay text/plain, buscar text/html
      for (final part in parts) {
        final mimeType = part['mimeType'] as String?;
        if (mimeType == 'text/html') {
          final partBody = part['body'] as Map<String, dynamic>?;
          final data = partBody?['data'] as String?;
          if (data != null && data.isNotEmpty) {
            return _limpiarHtml(_decodificarBase64Url(data));
          }
        }
        // Recursión para partes anidadas
        if (part['parts'] != null) {
          final nested = _extraerCuerpo(part as Map<String, dynamic>);
          if (nested.isNotEmpty) return nested;
        }
      }
    }

    return '';
  }

  static String _decodificarBase64Url(String data) {
    try {
      // Base64url -> Base64 estándar
      String base64 = data.replaceAll('-', '+').replaceAll('_', '/');
      while (base64.length % 4 != 0) {
        base64 += '=';
      }

      final bytes = Uri.parse('data:;base64,$base64').data?.contentAsBytes();
      if (bytes == null) return data;
      return String.fromCharCodes(bytes);
    } catch (_) {
      return data;
    }
  }

  static String _limpiarHtml(String html) {
    return html
        .replaceAll(RegExp(r'<br\s*/?>'), '\n')
        .replaceAll(RegExp(r'<[^>]+>'), '')
        .replaceAll(RegExp(r'&nbsp;'), ' ')
        .replaceAll(RegExp(r'&amp;'), '&')
        .replaceAll(RegExp(r'&lt;'), '<')
        .replaceAll(RegExp(r'&gt;'), '>')
        .replaceAll(RegExp(r'&quot;'), '"')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }

  static DateTime _parsearFechaGmail(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return DateTime.now();
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      // Gmail usa formatos como "Tue, 17 Jun 2026 10:30:00 -0500"
      // Intentar parseo básico
      try {
        return HttpDate.parse(dateStr);
      } catch (_) {
        return DateTime.now();
      }
    }
  }
}

/// Clase auxiliar para parsear fechas HTTP
class HttpDate {
  static DateTime parse(String dateStr) {
    // Remover día de la semana si existe
    final cleaned = dateStr.replaceFirst(RegExp(r'^\w+,\s*'), '');

    final months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12,
    };

    final parts = cleaned.split(RegExp(r'\s+'));
    if (parts.length >= 4) {
      final day = int.tryParse(parts[0]) ?? 1;
      final month = months[parts[1]] ?? 1;
      final year = int.tryParse(parts[2]) ?? DateTime.now().year;
      final timeParts = parts[3].split(':');
      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = timeParts.length > 1 ? int.tryParse(timeParts[1]) ?? 0 : 0;
      final second = timeParts.length > 2 ? int.tryParse(timeParts[2]) ?? 0 : 0;

      return DateTime(year, month, day, hour, minute, second);
    }

    return DateTime.now();
  }
}
