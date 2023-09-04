import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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


  // Future<CroppedFile?> cropImage({required File imageFile}) async {
  //   try {
  //     CroppedFile? croppedFile = await ImageCropper().cropImage(
  //       sourcePath: imageFile.path,
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio4x3,
  //         CropAspectRatioPreset.ratio16x9
  //       ],
  //       uiSettings: [
  //         AndroidUiSettings(
  //             toolbarTitle: 'Cropper',
  //             toolbarColor: primaryColor,
  //             toolbarWidgetColor: Colors.white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false),
  //         IOSUiSettings(
  //           title: 'Cropper',
  //         ),
  //         WebUiSettings(
  //           context: context,
  //         ),
  //       ],
  //     );
  //     return croppedFile;
  //   } catch (e) {
  //     print('Faild to crop image: ${e}');
  //     return null;
  //   }
  // }


  // Future<File?> pickCamera() async {
  //   try {
  //     var xImage = await ImagePicker().pickImage(
  //       source: ImageSource.camera,
  //     );
  //     if (xImage == null) {}
  //     var image = File(xImage!.path);
  //     return image;
  //   } catch (e) {
  //     print('Faild to pick image: ${e}');
  //     return null;
  //   }
  // }




  Future<DateTime?> pickDateTime(context) => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
  
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

Future<void> updateAddress({
    required String addressId,
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
    print(customer);
    final result = await addressService.updateAddress(
      addressId: addressId,
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

  Future<void> getByUser() async {
    _loadingAddress = true;
    final result = await addressService.getByUser();
    if (result != null) {
      _addressModel = result;
      _loadingAddress = false;
      notifyListeners();
    } else {
      _loadingAddress = false;
      notifyListeners();
    }
  }
}
