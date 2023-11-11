/*import 'package:diarraapp/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) => AuthNotifier(ref.watch(authServiceProvider)));

class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(false);

  login(
    {required String email, required String password, required BuildContext context}) async {
    try {
      state = true;
      await _authService.signInWithEmailAndPassword(email: email, password: password)
          .then((value) => context.go('/adminPage'));
      state = false;
    } catch (e) {
      state = false;
      print(e.toString());
    }
  }
}
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/auth_service.dart';
final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>(
  (ref) => AuthNotifier(ref.watch(authServiceProvider)));


class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;
  final StreamController<String> _errorStreamController = StreamController<String>();

  AuthNotifier(this._authService) : super(false);

  Stream<String> get errorStream => _errorStreamController.stream;

login({required String email, required String password, required BuildContext context}) async {
  try {
    state = true;

    await _authService.signInWithEmailAndPassword(email: email, password: password)
        .then((value) => context.go('/adminPage'));
    state = false;
  } catch (e) {
    state = false;
    final errorMessage = "Erreur d'authentification : $e"; // Créez un message d'erreur significatif.
    

    return ErreurMessagetoLogin(_errorStreamController, errorMessage);
  }
}

Future<void> logout(BuildContext context) async {
    await _authService.signOut();
    // ignore: use_build_context_synchronously
    context.go("/admin/login");
    state = false;
  }
}
// ignore: non_constant_identifier_names
ErreurMessagetoLogin(final StreamController<String> errorStreamController ,final errorMessage) {
     if (errorMessage == "[firebase_auth/invalid-email] The email address is badly formatted.") {
      const message = "L'adresse email est mal écrite";
      errorStreamController.add(message);
    } else if (errorMessage == "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
      const message = "L'utilisateur n'existe pas";
      errorStreamController.add(message);
    } else if (errorMessage == "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
      const message = "Le mot de passe est invalide ou l'utilisateur n'a pas le droit de se connecter à cette application";
      errorStreamController.add(message);
    } else {
      errorStreamController.add(errorMessage); // Gère toutes les autres erreurs.
    }
}