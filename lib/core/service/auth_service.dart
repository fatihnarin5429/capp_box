import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Güvenli nonce üretir (Apple için)
String _generateNonce([int length = 32]) {
  const charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(
    length,
    (_) => charset[random.nextInt(charset.length)],
  ).join();
}

/// String'in sha256 hash'i (hex)
String _sha256ofString(String input) {
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

abstract class IAuthService {
  Future<UserCredential?> signInWithApple();
  Future<UserCredential?> signInWithGoogle();
  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  );
  Future<UserCredential?> createUserWithEmailAndPassword(
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
  Future<UserCredential?> signInWithApple() async {
    try {
      final available = await SignInWithApple.isAvailable();
      if (!available) {
        debugPrint('Apple Sign-In bu platformda desteklenmiyor.');
        return null;
      }

      final rawNonce = _generateNonce();
      final nonce = _sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: const [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      final oauthCredential = OAuthProvider(
        'apple.com',
      ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

      final userCred = await _auth.signInWithCredential(oauthCredential);

      // İlk girişte isim güncelle
      if (userCred.user != null &&
          (userCred.user!.displayName == null ||
              userCred.user!.displayName!.isEmpty)) {
        final fullName = [
          appleCredential.givenName,
          appleCredential.familyName,
        ].where((e) => e != null && e!.isNotEmpty).join(' ');
        if (fullName.isNotEmpty) {
          await userCred.user!.updateDisplayName(fullName);
        }
      }

      return userCred;
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Apple Sign-In FirebaseAuthException: ${e.code} - ${e.message}',
      );
      return null;
    } catch (e) {
      debugPrint('Apple Sign-In hatası: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        return await _auth.signInWithPopup(provider);
      } else {
        final googleUser = await _googleSignIn.signIn();
        if (googleUser == null) {
          debugPrint('Google Sign-In iptal edildi.');
          return null;
        }

        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        return await _auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(
        'Google Sign-In FirebaseAuthException: ${e.code} - ${e.message}',
      );
      return null;
    } catch (e) {
      debugPrint('Google Sign-In hatası: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('Email/Password Sign-In hatası: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      debugPrint('Email/Password Registration hatası: $e');
      return null;
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
      debugPrint('SignOut hatası: $e');
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
}
