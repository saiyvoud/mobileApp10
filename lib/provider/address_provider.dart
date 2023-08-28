import 'package:flutter/material.dart';
import 'package:mobileapp/model/address_model.dart';
import 'package:mobileapp/service/address_service.dart';

class AddressProvider extends ChangeNotifier {
  final addressService = AddressService();
  AddressModel? _addressModel;
  bool _loadingAddress = false;
  bool _success = false;
  get loadingAddress => _loadingAddress;
  get success => _success;
  AddressModel get addressModel => _addressModel!;
  
  Future<void> insertAddress({
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
    _loadingAddress = true;
    final result = await addressService.insertAddress(
      express: express,
      branch: branch,
      customer: customer,
      phone: phone,
      village: village,
      district: district,
      province: province,
      latitude: latitude,
      longitude: longitude,
    );
    if (result != null) {
      _addressModel = result;
      _loadingAddress = false;
      _success = true;
      notifyListeners();
    } else {
      _loadingAddress = false;
      _success = false;
      notifyListeners();
    }
  }
}
