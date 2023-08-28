import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobileapp/api/apiPath.dart';
import 'package:mobileapp/model/address_model.dart';
import 'package:http/http.dart' as http;

class AddressService {
  final box = Hive.box('user');
  Future<AddressModel?> insertAddress({
    required String express,
    required String branch,
    required String customer,
    required String phone,
    required String village,
    required String district,
    required String province,
    required String latitude,
    required String longitude,
  }) async {
    try {
      final url = await Uri.parse(ApiPath.insertAddressPath);

      Map<String, String> header = {
        "Accept": "application/json",
      };
      final body = {
        "express": express,
        "branch": branch,
        "customer": customer,
        "phone": phone,
        "village": village,
        "district": district,
        "province": province,
        "latitude": latitude,
        "longitude": longitude,
      };

      final respone = await http.post(url, body: body, headers: header);
      if (respone.statusCode == 201 || respone.statusCode == 200) {
        var data = jsonDecode(respone.body);
        final AddressModel address = AddressModel.fromJson(data['data']);
        return address;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<AddressModel?> getByUser() async {
    try {
      final userId = await box.get("userId");
      final url = await Uri.parse(ApiPath.getAddressByUserPath + userId);

      Map<String, String> header = {
        "Accept": "application/json",
      };
      final respone = await http.get(url, headers: header);
      if (respone.statusCode == 201 || respone.statusCode == 200) {
        var data = jsonDecode(respone.body);
        final AddressModel address = AddressModel.fromJson(data['data']);
        return address;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
