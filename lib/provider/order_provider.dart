import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobileapp/model/order_model.dart';

import 'package:mobileapp/service/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final orderService = OrderService();
  OrderModel? _orderModel;
  List<dynamic> _orders = [];
  List<dynamic> _books = [];
  bool _loadingOrder = false;
  bool _success = false;
  get loadingOrder => _loadingOrder;
  get success => _success;
  OrderModel get orderModel => _orderModel!;
  get order => _orders;
  get books => _books;
  Future<void> getOrderBook({
    required List<dynamic> books,
  }) async {
    _loadingOrder = true;
    try {
      var _list = [];
      for (var i = 0; i < books.length; i++) {
        _list.add(books[i]);
      }
      _books = _list;
      _loadingOrder = false;
    } catch (e) {
      _loadingOrder = false;
      notifyListeners();
    }
  }

  Future<void> getOrderByUser() async {
    _loadingOrder = true;

    final result = await orderService.getByUser();
    print(result);
    if (result != null) {
      _orders = result;
      _loadingOrder = false;
      notifyListeners();
    } else {
      _loadingOrder = false;
      notifyListeners();
    }
  }

  Future<void> insertOrders({
    required File image,
    required String address_id,
    required List<dynamic> books,
    required String time,
    required String totalPrice,
  }) async {
    _loadingOrder = true;
    var _books = [];
    for (int i = 0; i < books.length; i++) {
      _books.add({
        "_id": books[i]['id'],
        "category_id": books[i]['category_id'][0]['id'],
        "name": books[i]['name'],
        "detail": books[i]['detail'],
        "amount": books[i]['amount'],
        "image": books[i]['image'],
        "order_price": books[i]['order_price'].toString(),
        "sale_price": books[i]['sale_price'].toString(),
      });
    }

    final result = await orderService.insertOrder(
      image: image,
      address_id: address_id,
      books: _books,
      time: time,
      totalPrice: totalPrice,
    );
    if (result != null) {
      _orderModel = result;
      _loadingOrder = false;
      _success = true;
      notifyListeners();
    } else {
      _loadingOrder = false;
      _success = false;
      notifyListeners();
    }
  }

  Future<void> insertOrder({
    required File image,
    required String address_id,
    required dynamic books,
    required String time,
    required String totalPrice,
  }) async {
    _loadingOrder = true;

    final result = await orderService.insertOrder(
      image: image,
      address_id: address_id,
      books: books,
      time: time,
      totalPrice: totalPrice,
    );
    if (result != null) {
      _orderModel = result;
      _loadingOrder = false;
      _success = true;
      notifyListeners();
    } else {
      _loadingOrder = false;
      _success = false;
      notifyListeners();
    }
  }
}
