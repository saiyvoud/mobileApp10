import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobileapp/model/order_model.dart';

import 'package:mobileapp/service/order_service.dart';

class OrderProvider extends ChangeNotifier {
  final orderService = OrderService();
  OrderModel? _orderModel;
  bool _loadingOrder = false;
  bool _success = false;
  get loadingOrder => _loadingOrder;
  get success => _success;
  OrderModel get orderModel => _orderModel!;

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
