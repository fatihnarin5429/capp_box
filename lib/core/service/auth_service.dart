import 'dart:convert';
import 'dart:math';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Durumlar
enum AuthStatus {
  success,
  cancelled,
  configError,
  networkError,
  unauthorized,
  unknown,
}

/// Tek tip sonuç modeli
class AuthResult {
  final AuthStatus status;
  final String? message;
  final User? user;

  const AuthResult(this.status, {this.message, this.user});

  bool get isSuccess => status == AuthStatus.success;
}

/// Nonce üret (Apple için)
String _generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(
    length,
    (_) => charset[random.nextInt(charset.length)],
  ).join();
}

/// sha256 hash (Apple için)
String _sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

abstract class IAuthService {
  Future<AuthResult> signInWithApple();
  Future<AuthResult> signInWithGoogle();
  Future<AuthResult> signInWithEmailPassword(String email, String password);
  Future<AuthResult> createUserWithEmailAndPassword(
    String email,
    String password,
  );
  Future<void> signOut();

  Stream<User?> authStateChanges();
  User? getCurrentUser();
  String? getUserEmail();
  String? getUserId();
  String? getUserDisplayName();
  Future<String?> getCurrentIdToken({bool forceRefresh = false});
  bool isUserLoggedIn();
}

class AuthService implements IAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Future<AuthResult> signInWithApple() async {
    if (!Platform.isIOS) {
      return const AuthResult(
        AuthStatus.configError,
        message: 'Apple girişi sadece iOS’ta destekleniyor.',
      );
    }
    try {
      if (!await SignInWithApple.isAvailable()) {
        return const AuthResult(
          AuthStatus.configError,
          message: 'Apple Sign-In bu cihazda desteklenmiyor.',
        );
      }

      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauth = OAuthProvider(
        'apple.com',
      ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

      final userCred = await _auth.signInWithCredential(oauth);

      // İsim ekleme (ilk giriş)
      if (userCred.user != null &&
          (userCred.user!.displayName == null ||
              userCred.user!.displayName!.isEmpty)) {
        final fullName = [
          appleCredential.givenName,
          appleCredential.familyName,
        ].where((e) => e != null && e.isNotEmpty).join(' ');
        if (fullName.isNotEmpty) {
          await userCred.user!.updateDisplayName(fullName);
        }
      }

      return AuthResult(AuthStatus.success, user: userCred.user);
    } on SignInWithAppleAuthorizationException catch (e) {
      if (e.code == AuthorizationErrorCode.canceled) {
        return const AuthResult(
          AuthStatus.cancelled,
          message: 'Apple girişi iptal edildi.',
        );
      }
      return const AuthResult(
        AuthStatus.configError,
        message: 'Apple girişi yapılandırma hatası.',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult(_mapStatus(e.code), message: _mapFirebaseMessage(e));
    } catch (e) {
      return AuthResult(
        AuthStatus.unknown,
        message: 'Apple girişi başarısız: $e',
      );
    }
  }

  @override
  Future<AuthResult> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        final cred = await _auth.signInWithPopup(provider);
        return AuthResult(AuthStatus.success, user: cred.user);
      } else {
        final googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          return const AuthResult(
            AuthStatus.cancelled,
            message: 'Google girişi iptal edildi.',
          );
        }

        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final cred = await _auth.signInWithCredential(credential);
        return AuthResult(AuthStatus.success, user: cred.user);
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult(_mapStatus(e.code), message: _mapFirebaseMessage(e));
    } catch (e) {
      return AuthResult(
        AuthStatus.unknown,
        message: 'Google girişi başarısız: $e',
      );
    }
  }

  @override
  Future<AuthResult> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(AuthStatus.success, user: cred.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(_mapStatus(e.code), message: _mapFirebaseMessage(e));
    } catch (e) {
      return AuthResult(AuthStatus.unknown, message: 'Email girişi hatası: $e');
    }
  }

  @override
  Future<AuthResult> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult(AuthStatus.success, user: cred.user);
    } on FirebaseAuthException catch (e) {
      return AuthResult(_mapStatus(e.code), message: _mapFirebaseMessage(e));
    } catch (e) {
      return AuthResult(AuthStatus.unknown, message: 'Kayıt hatası: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      if (!kIsWeb) {
        try {
          await _googleSignIn.signOut();
        } catch (_) {}
      }
      await _auth.signOut();
    } catch (e) {
      debugPrint('Çıkış hatası: $e');
    }
  }

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  User? getCurrentUser() => _auth.currentUser;

  @override
  String? getUserEmail() => _auth.currentUser?.email;

  @override
  String? getUserId() => _auth.currentUser?.uid;

  @override
  String? getUserDisplayName() => _auth.currentUser?.displayName;

  @override
  bool isUserLoggedIn() => _auth.currentUser != null;

  @override
  Future<String?> getCurrentIdToken({bool forceRefresh = false}) async {
    try {
      return await _auth.currentUser?.getIdToken(forceRefresh);
    } catch (e) {
      debugPrint('ID Token alma hatası: $e');
      return null;
    }
  }

  // --- Yardımcı mapping fonksiyonları ---
  AuthStatus _mapStatus(String code) {
    switch (code) {
      case 'network-request-failed':
        return AuthStatus.networkError;
      case 'user-disabled':
      case 'operation-not-allowed':
        return AuthStatus.unauthorized;
      default:
        return AuthStatus.unknown;
    }
  }

  String _mapFirebaseMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'network-request-failed':
        return 'İnternet bağlantısı yok.';
      case 'account-exists-with-different-credential':
        return 'Bu e-posta başka bir sağlayıcı ile kayıtlı.';
      case 'invalid-credential':
        return 'Geçersiz kimlik bilgisi.';
      default:
        return 'Hata: ${e.message ?? e.code}';
    }
  }
}
