import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mobileapp/model/book_model.dart';

import '../api/apiPath.dart';
import 'package:http/http.dart' as http;

class BookService {
  final box = Hive.box('user');
  Future<List<BookModel>?> fecthBook() async {
    try {
      final url = Uri.parse(ApiPath.bookPath);
      final token = box.get("token");

      Map<String, String> header = {
        "Accept": "application/json",
        "Authorization": "Bearer ${token}"
      };

      final respone = await http.get(url, headers: header);
      var data = jsonDecode(respone.body);
      print(respone.body);
      if (data['status'] == true) {
        final books = bookModelFromJson(jsonEncode(data['data']));
        return books;
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
