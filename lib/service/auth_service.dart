import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/api/apiPath.dart';
import 'package:mobileapp/model/user_model.dart';

class AuthService {

  Future<UserModel?> login({
    required String password,
    required String email,
  }) async {
    try {
        //final box = await Hive.box('user');
      final url = Uri.parse(ApiPath.loginPath);
      Map<String, String> header = {
        "Accept": "application/json",
      };
      final body = {
        "password": password,
        "email": email,
      };
      final respone = await http.post(url, body: body, headers: header);
      if (respone.statusCode == 200 || respone.statusCode == 201) {
        var data = jsonDecode(respone.body);
        // box.put('token', data['token']);
        final UserModel user = UserModel.fromJson(data['data']);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> register({
    required String username,
    required String password,
    required String email,
    required String phone,
  }) async {
    try {
        final box = Hive.box('user');
      final url = Uri.parse(ApiPath.registerPath);
      Map<String, String> header = {
        // "Content-type": "application/json",
        "Accept": "application/json",
      };
      final body = {
        "username": username,
        "password": password,
        "email": email,
        "phone": phone
      };
      final respone = await http.post(url, body: body, headers: header);
      print(respone.body);
      if (respone.statusCode == 201 || respone.statusCode == 200) {
        var data = jsonDecode(respone.body);
         box.put('token', data['token']);
        final UserModel user = UserModel.fromJson(data['data']);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
