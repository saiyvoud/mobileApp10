import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobileapp/model/user_model.dart';
import 'package:mobileapp/service/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController comfirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKeyRegister = GlobalKey<FormState>();
    final formKeyChangePassword = GlobalKey<FormState>();
  AuthService authService = AuthService();
  UserModel _userModel = UserModel();

  bool? _loading;
  bool? _loadingRegister;
  bool? _success;
  get loading => _loading;
  get loadingRegister => _loadingRegister;
  get success => _success;
  UserModel get userModel => _userModel;
  final box = Hive.box('user');
  Future<void> updateProfileImage({required File filename}) async {
    _loading = true;
    final result = await authService.updateProfileImage(
        // oldImage: userModel.profile.toString(),
        newImage: filename);
    if (result != null) {
      _userModel = result;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> changePassword() async {
    _loading = true;
    final result = await authService.changePassword(
      oldPassword: oldPassword.text,
      newPassword: newPassword.text,
    );
    if (result != null) {
      _success = true;
      _loading = false;
      notifyListeners();
    } else {
      _success = false;
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile() async {
    _loading = true;
    final result = await authService.updateProfile(
      username:
          username.text.isEmpty ? userModel.username.toString() : username.text,
      phone: phone.text.isEmpty ? userModel.phone.toString() : phone.text,
    );
    if (result != null) {
      _userModel = result;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> getProfile() async {
    _loading = true;
    final result = await authService.getProfile();
    if (result != null) {
      _userModel = result;
      _loading = false;
      notifyListeners();
    } else {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> validateAuth() async {
    try {
      //await box.delete("token");
      final token = await box.get("token");
      await Future.delayed(Duration(seconds: 2));
      if (token == "" || token == null) {
        _success = false;
        notifyListeners();
      } else {
        _success = true;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> login() async {
    _loading = true;
    notifyListeners();
    final result = await authService.login(
      password: password.text,
      email: email.text,
    );

    if (result!.id != null) {
      await box.put('userId', result.id.toString());
      await box.put('token', result.token);
      final token = box.get("token");
      final userId = box.get("userId");
      print("=============>Token$token userId$userId");
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
    // notifyListeners();
    final result = await authService.register(
      username: username.text,
      password: password.text,
      email: email.text,
      phone: phone.text,
    );
    if (result != null) {
      await box.put('userId', result.id.toString());
      await box.put('token', result.token);
      final token = box.get("token");
      final userId = box.get("userId");
      print("=============>Token$token userId$userId");
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
