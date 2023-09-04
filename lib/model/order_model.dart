import 'dart:convert';

import 'package:mobileapp/model/address_model.dart';
import 'package:mobileapp/model/book_model.dart';
import 'package:mobileapp/model/user_model.dart';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

class OrderModel {
  final String? id;
  final List<BooksModel>? books;
  final AddressModel? address;
  final UserModel? user;
  final int? totalPrice;
  final String? bill;
  final String? time;

  OrderModel({
    this.id,
    this.books = const [],
    this.user,
    this.address,
    this.totalPrice,
    this.bill,
    this.time,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['_id'],
       // books: List<BooksModel>.from(json['books']),
        user: json['user'],
        address: json['address'],
        totalPrice: json['totalPrice'],
        bill: json['bill'],
        time: json['time'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
       // "books": books,
        "user": user,
        "address": address,
        "totalPrice": totalPrice,
        "bill": bill,
        "time": time,
      };
}
