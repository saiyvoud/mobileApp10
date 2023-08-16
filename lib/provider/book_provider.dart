import 'package:flutter/material.dart';
import 'package:mobileapp/model/book_model.dart';
import 'package:mobileapp/service/book_service.dart';

class BookProvider extends ChangeNotifier {
  List<BookModel>? _books;
  bool _loading = false;
  bool _success = false;

  get sucessBook => _success;
  get loadingBook => _loading;
  List<BookModel>? get books => _books;
  BookService bookService = BookService();
  
  Future<void> fecthBook() async {
    _loading = true;
    final result = await bookService.fecthBook();
    if (result!.isNotEmpty) {
      _books = result;
      _loading = false;
      _success = true;
      notifyListeners();
    } else {
      _loading = false;
      _success = false;
      notifyListeners();
    }
  }
}
