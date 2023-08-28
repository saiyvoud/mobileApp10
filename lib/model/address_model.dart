// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(
    json.decode(str).map((x) => AddressModel.fromJson(x)));

class AddressModel {
  final String? id;
  final String? express;
  final String? branch;
  final String? customer;
  final String? phone;
  final String? village;
  final String? district;
  final String? province;
  final String? latitude;
  final String? longitude;

  AddressModel({
    this.id,
    this.express,
    this.branch,
    this.customer,
    this.phone,
    this.village,
    this.district,
    this.province,
    this.latitude,
    this.longitude,
  });
  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json['_id'],
        express: json['express'],
        branch: json['branch'],
        customer: json['customer'],
        phone: json['phone'],
        village: json['village'],
        district: json['district'],
        province: json['province'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
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
}
