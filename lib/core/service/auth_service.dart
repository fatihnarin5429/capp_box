import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// Generates a cryptographically secure random nonce, to be included in a
/// credential request.
String generateNonce([int length = 32]) {
  final charset =
      '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
  final random = Random.secure();
  return List.generate(
    length,
    (_) => charset[random.nextInt(charset.length)],
  ).join();
}

/// Returns the sha256 hash of [input] in hex notation.
String sha256ofString(String input) {
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
  String getUserEmail();
  String? getUserId();
  String? getUserDisplayName();
  bool isUserLoggedIn();
  User? getCurrentUser();
}

class AuthService implements IAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential?> signInWithApple() async {
    try {
      // To prevent replay attacks with the credential returned from Apple, we
      // include a nonce in the credential request. When signing in with
      // Firebase, the nonce in the id token returned by Apple, is expected to
      // match the sha256 hash of `rawNonce`.
      final rawNonce = generateNonce();
      final nonce = sha256ofString(rawNonce);

      // Request credential for the currently signed in Apple account.
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );

      // Create an `OAuthCredential` from the credential returned by Apple.
      final oauthCredential = OAuthProvider(
        "apple.com",
      ).credential(idToken: appleCredential.identityToken, rawNonce: rawNonce);

      // Sign in the user with Firebase. If the nonce we generated earlier does
      // not match the nonce in `appleCredential.identityToken`, sign in will fail.
      return await _firebaseAuth.signInWithCredential(oauthCredential);
    } catch (e) {
      print('Apple Sign-In hatası: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    // Google Sign-In implementasyonu burada olacak
    // Şimdilik null döndürüyoruz
    return null;
  }

  @override
  Future<UserCredential?> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Email/Password Sign-In hatası: $e');
      return null;
    }
  }

  @override
  Future<UserCredential?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print('Email/Password Registration hatası: $e');
      return null;
    }
  }

  @override
  String getUserEmail() {
    return _firebaseAuth.currentUser?.email ?? "User";
  }

  @override
  String? getUserId() {
    return _firebaseAuth.currentUser?.uid;
  }

  @override
  String? getUserDisplayName() {
    return _firebaseAuth.currentUser?.displayName;
  }

  @override
  bool isUserLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
