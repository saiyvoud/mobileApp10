import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/api/apiPath.dart';
import 'package:mobileapp/model/user_model.dart';

class AuthService {
  final box = Hive.box('user');
  Future<UserModel?> updateProfileImage({
    //required String oldImage,
    required File newImage,
  }) async {
    try {
      final userId = await box.get("userId");
      final url = Uri.parse(ApiPath.updateProfileImagePath + userId);
      final token = await box.get("token");
      Map<String, String> header = {
        "Accept": "multipart/form-data",
        "Authorization": "Bearer ${token}"
      };

      // print("=========>: "+covertBooks);
      final request = http.MultipartRequest('PUT', url);
      request.headers.addAll(header);
      // request.fields['oldImage'] = oldImage.toString();
      final file = await http.MultipartFile.fromPath('image', newImage.path);
      request.files.add(file);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        var data = json.decode(response.body);

        final UserModel user = UserModel.fromJson(data['data']);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> updateProfile({
    required String username,
    required String phone,
  }) async {
    try {
      final userId = await box.get("userId");
      final url = Uri.parse(ApiPath.updateProfilePath + userId);
      final token = await box.get("token");
      Map<String, String> header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token}"
      };
      final body = {
        "username": username,
        "phone": phone,
      };
      final respone = await http.put(url, body: body, headers: header);
      print("==========>${respone.body}");
      if (respone.statusCode == 200 || respone.statusCode == 201) {
        print("==========>${respone.body}");
        var data = jsonDecode(respone.body);

        final UserModel user = UserModel.fromJson(data['data']);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> getProfile() async {
    try {
      final userId = await box.get("userId");
      final url = Uri.parse(ApiPath.getProfilePath + userId);
      final token = await box.get("token");
      Map<String, String> header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token}"
      };

      final respone = await http.get(url, headers: header);

      if (respone.statusCode == 200 || respone.statusCode == 201) {
        print("==========>${respone.body}");
        var data = jsonDecode(respone.body);

        final UserModel user = UserModel.fromJson(data['data']);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> login({
    required String password,
    required String email,
  }) async {
    try {
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
        print("==========>${respone.body}");
        var data = jsonDecode(respone.body);

        final UserModel user = UserModel.fromJson(data['data']);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<UserModel?> refreshToken({
    required String password,
    required String email,
  }) async {
    try {
      final url = Uri.parse(ApiPath.refreshToken);
      Map<String, String> header = {
        "Accept": "application/json",
      };
      final body = {
        "password": password,
        "email": email,
      };
      final respone = await http.post(url, body: body, headers: header);

      if (respone.statusCode == 200 || respone.statusCode == 201) {
        print("==========>${respone.body}");
        var data = jsonDecode(respone.body);

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
      final box = await Hive.box('user');
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

      if (respone.statusCode == 201 || respone.statusCode == 200) {
        print(respone.body);
        var data = jsonDecode(respone.body);

        final UserModel user = UserModel.fromJson(data['data']);
        return user;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
