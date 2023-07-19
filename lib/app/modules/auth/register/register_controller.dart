import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';
import '../../../exception/auth_exception.dart';

class RegisterController extends ChangeNotifier {
  final UserService _userService;

  RegisterController({required UserService userService})
      : _userService = userService;

  Future<void> registerUser(String email, String password) async {
    try {
      DefaultChangeNotifier().showLoadingAndResetState;
      notifyListeners();
      final user = await _userService.register(email, password);
      if (user != null) {
        DefaultChangeNotifier().success;
      } else {
        DefaultChangeNotifier().setError('Erro ao registrar usuário');
      }
    } on AuthException catch (e) {
      DefaultChangeNotifier().setError(e.message);
    } finally {
      DefaultChangeNotifier().hideLoading;
      notifyListeners();
    }
  }
}
