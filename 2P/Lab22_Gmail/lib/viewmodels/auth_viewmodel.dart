import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/usuario_model.dart';
import '../services/gmail_service.dart';

class AuthViewModel extends ChangeNotifier {
  final GmailService _gmailService = GmailService();

  UsuarioModel? _usuario;
  bool _estaCargando = false;
  String? _mensajeError;

  // Google Sign-In con los scopes necesarios para Gmail
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/userinfo.profile',
      'https://www.googleapis.com/auth/gmail.readonly',
      'https://www.googleapis.com/auth/gmail.send',
    ],
  );

  // ===================== GETTERS =====================

  UsuarioModel? get usuario => _usuario;

  bool get estaAutenticado => _usuario != null;

  bool get estaCargando => _estaCargando;

  String? get mensajeError => _mensajeError;

  String get nombreUsuario => _usuario?.nombre ?? 'Usuario';

  String get emailUsuario => _usuario?.email ?? '';

  String? get fotoUsuario => _usuario?.fotoUrl;

  String? get accessToken => _usuario?.accessToken;

  // ===================== GOOGLE SIGN-IN REAL =====================

  /// Inicia sesión con Google usando OAuth.
  Future<void> signInWithGoogle() async {
    _estaCargando = true;
    _mensajeError = null;
    notifyListeners();

    try {
      final cuenta = await _googleSignIn.signIn();

      if (cuenta == null) {
        // El usuario canceló el login
        _estaCargando = false;
        notifyListeners();
        return;
      }

      final auth = await cuenta.authentication;
      final accessToken = auth.accessToken;

      if (accessToken == null) {
        _mensajeError = 'No se pudo obtener el token de acceso';
        _estaCargando = false;
        notifyListeners();
        return;
      }

      // Obtener perfil del usuario
      final perfil = await _gmailService.obtenerPerfilUsuario(accessToken);

      _usuario =
          perfil ??
          UsuarioModel(
            nombre: cuenta.displayName ?? 'Usuario',
            email: cuenta.email,
            fotoUrl: cuenta.photoUrl,
            accessToken: accessToken,
          );

      // Asegurarnos de que el token está almacenado
      if (_usuario!.accessToken == null) {
        _usuario = _usuario!.copyWith(accessToken: accessToken);
      }
    } catch (e) {
      _mensajeError = 'Error al iniciar sesión: $e';
    } finally {
      _estaCargando = false;
      notifyListeners();
    }
  }

  /// Cierra sesión de Google.
  Future<void> signOut() async {
    _estaCargando = true;
    notifyListeners();

    try {
      await _googleSignIn.signOut();
      _usuario = null;
      _mensajeError = null;
    } catch (e) {
      _mensajeError = 'Error al cerrar sesión: $e';
    } finally {
      _estaCargando = false;
      notifyListeners();
    }
  }

  /// Intenta restaurar la sesión previa silenciosamente.
  Future<void> intentarSesionSilenciosa() async {
    try {
      final cuenta = await _googleSignIn.signInSilently();
      if (cuenta != null) {
        final auth = await cuenta.authentication;
        final accessToken = auth.accessToken;

        if (accessToken != null) {
          _usuario = UsuarioModel(
            nombre: cuenta.displayName ?? 'Usuario',
            email: cuenta.email,
            fotoUrl: cuenta.photoUrl,
            accessToken: accessToken,
          );
          notifyListeners();
        }
      }
    } catch (_) {
      // Si falla la restauración silenciosa, no hacer nada
    }
  }

  /// Refresca el token de acceso.
  Future<String?> refrescarToken() async {
    try {
      final cuenta = _googleSignIn.currentUser;
      if (cuenta != null) {
        final auth = await cuenta.authentication;
        final nuevoToken = auth.accessToken;

        if (nuevoToken != null && _usuario != null) {
          _usuario = _usuario!.copyWith(accessToken: nuevoToken);
          notifyListeners();
        }

        return nuevoToken;
      }
    } catch (_) {
      // Error al refrescar token
    }
    return null;
  }

  void limpiarMensajeError() {
    _mensajeError = null;
    notifyListeners();
  }
}
