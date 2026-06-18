import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/correo_model.dart';
import '../model/usuario_model.dart';

/// Servicio para interactuar con la API de Gmail.
/// Encapsula todas las llamadas HTTP a los endpoints de Google.
class GmailService {
  static const String _baseUrl =
      'https://gmail.googleapis.com/gmail/v1/users/me';
  static const String _peopleUrl = 'https://people.googleapis.com/v1/people/me';

  /// Obtiene la lista de correos del usuario desde Gmail API.
  Future<List<CorreoModel>> obtenerCorreos(
    String accessToken, {
    int maxResultados = 20,
    String? query,
  }) async {
    try {
      // 1. Obtener la lista de IDs de mensajes
      String url = '$_baseUrl/messages?maxResults=$maxResultados';
      if (query != null && query.isNotEmpty) {
        url += '&q=${Uri.encodeComponent(query)}';
      }

      final listaResponse = await http.get(
        Uri.parse(url),
        headers: _headers(accessToken),
      );

      if (listaResponse.statusCode != 200) {
        throw Exception(
          'Error al obtener mensajes: ${listaResponse.statusCode}',
        );
      }

      final listaData = jsonDecode(listaResponse.body) as Map<String, dynamic>;
      final mensajes = listaData['messages'] as List<dynamic>? ?? [];

      // 2. Obtener detalle de cada mensaje
      final correos = <CorreoModel>[];
      for (final msg in mensajes) {
        final id = msg['id'] as String;
        final correo = await _obtenerDetalleMensaje(accessToken, id);
        if (correo != null) {
          correos.add(correo);
        }
      }

      return correos;
    } catch (e) {
      throw Exception('Error al obtener correos: $e');
    }
  }

  /// Obtiene el detalle de un mensaje específico.
  Future<CorreoModel?> _obtenerDetalleMensaje(
    String accessToken,
    String messageId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/messages/$messageId?format=full'),
        headers: _headers(accessToken),
      );

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return CorreoModel.fromGmailMessage(data);
    } catch (_) {
      return null;
    }
  }

  /// Envía un correo a través de Gmail API.
  Future<bool> enviarCorreo(
    String accessToken, {
    required String para,
    required String asunto,
    required String cuerpo,
    String? de,
  }) async {
    try {
      // Construir el mensaje en formato RFC 2822
      final mensaje = StringBuffer();
      if (de != null) {
        mensaje.writeln('From: $de');
      }
      mensaje.writeln('To: $para');
      mensaje.writeln('Subject: $asunto');
      mensaje.writeln('Content-Type: text/plain; charset=utf-8');
      mensaje.writeln();
      mensaje.writeln(cuerpo);

      // Codificar en base64url
      final bytes = utf8.encode(mensaje.toString());
      final base64Email = base64Url.encode(bytes).replaceAll('=', '');

      final response = await http.post(
        Uri.parse('$_baseUrl/messages/send'),
        headers: {..._headers(accessToken), 'Content-Type': 'application/json'},
        body: jsonEncode({'raw': base64Email}),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  /// Obtiene información del perfil del usuario autenticado.
  Future<UsuarioModel?> obtenerPerfilUsuario(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('$_peopleUrl?personFields=names,emailAddresses,photos'),
        headers: _headers(accessToken),
      );

      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final nombres = data['names'] as List<dynamic>?;
      final emails = data['emailAddresses'] as List<dynamic>?;
      final fotos = data['photos'] as List<dynamic>?;

      return UsuarioModel(
        nombre: nombres?.isNotEmpty == true
            ? nombres!.first['displayName'] as String? ?? 'Usuario'
            : 'Usuario',
        email: emails?.isNotEmpty == true
            ? emails!.first['value'] as String? ?? ''
            : '',
        fotoUrl: fotos?.isNotEmpty == true
            ? fotos!.first['url'] as String?
            : null,
        accessToken: accessToken,
      );
    } catch (_) {
      return null;
    }
  }

  Map<String, String> _headers(String accessToken) {
    return {
      'Authorization': 'Bearer $accessToken',
      'Accept': 'application/json',
    };
  }
}
