import 'package:flutter/material.dart';
import 'package:mobileapp/model/user_model.dart';
import 'package:mobileapp/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController comfirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
  AuthService authService = AuthService();
  UserModel _userModel = UserModel();
  bool? _loading;
  bool? _loadingRegister;
  bool? _success;
  get loading => _loading;
  get loadingRegister => _loadingRegister;
  get success => _success;
  UserModel get userModel => _userModel;

  Future<void> login() async {
    _loading = true;
    notifyListeners();
    final result = await authService.login(
      password: password.text,
      email: email.text,
    );
    if (result != null) {
      _userModel = result;
      _loading = false;
      _success = true;
      notifyListeners();
    } else {
      _success = false;
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> register() async {
    _loadingRegister = true;
    notifyListeners();
    final result = await authService.register(
      username: username.text,
      password: password.text,
      email: email.text,
      phone: phone.text,
    );
    if (result != null) {
      _userModel = result;
      _success = true;
      _loadingRegister = false;
      notifyListeners();
    } else {
      _success = false;
      _loadingRegister = false;
      notifyListeners();
    }
  }
}
