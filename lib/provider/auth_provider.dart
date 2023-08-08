import 'package:flutter/material.dart';
import 'package:mobileapp/model/user_model.dart';
import 'package:mobileapp/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  UserModel _userModel = UserModel();
  bool _loading = false;
  bool _success = false;
   get loading => _loading;
   get success => _success;
  UserModel get userModel => _userModel;

  Future<void> login() async {
    _loading = true;
    notifyListeners();
    final result = await authService.login(
      username: username.text,
      password: password.text,
      email: email.text,
      phone: phone.text,
    );
    if (result != null) {
      _userModel = result;
      _loading = false;
      _success = true;
      notifyListeners();
    } else {
      _loading = false;
      _success = false;
      notifyListeners();
    }
  }
}
