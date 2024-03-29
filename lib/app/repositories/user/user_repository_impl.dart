import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_provider/app/exception/auth_exception.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredencial = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredencial.user;
    // ignore: unused_catch_stack
    } on FirebaseAuthException catch (e, s) {
      log('$e');
      if (e.code == 'email-already-exists') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(
              message: 'E-mail já utilizado, por favor, escolha outro e-mail');
        } else {
          throw AuthException(
              message:
                  'Você se cadastrou no TodoList pelo google, por favor utilize ele para entrar');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário');
      }
    }
  }
}
