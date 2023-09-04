import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:mobileapp/api/apiPath.dart';
import 'package:http/http.dart' as http;

import 'package:mobileapp/model/order_model.dart';

class OrderService {
  final box = Hive.box('user');
  Future<OrderModel?> insertOrder({
    required File image,
    required String address_id,
    required dynamic books,
    required String time,
    required String totalPrice,
  }) async {
    try {
      final url = await Uri.parse(ApiPath.orderPath);
      final token = await box.get("token");
      Map<String, String> header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token}"
      };
      //  print("=========>: "+books);
      var covertBooks = jsonEncode(books);
      final userId = await box.get("userId");
      // print("=========>: "+covertBooks);
      final request = http.MultipartRequest('POST', url);
      request.headers.addAll(header);
      request.fields['user_id'] = userId.toString();
      request.fields['address_id'] = address_id;
      request.fields['time'] = time;
      request.fields['totalPrice'] = totalPrice.toString();
      request.fields['books'] = covertBooks;
      final file = await http.MultipartFile.fromPath('bill', image.path);
      request.files.add(file);

      // for (int i = 0; i < books.length; i++) {
      // var _book = [{
      //   "category_id": books['category_id'],
      //   "name": books['name'],
      //   "detail": books['detail'],
      //   "amount": books['amount'].toString(),
      //   "order_price": books['order_price'].toString(),
      //   "sale_price": books['sale_price'].toString(),
      //   "image": books['image'].toString()
      // }];
      // }

     
      // request.fields.addAll({"books": _arry.toString()});
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        var data = json.decode(response.body);
      
        final OrderModel order = OrderModel.fromJson(data['data']);
        return order;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
