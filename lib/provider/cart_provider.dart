import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobileapp/model/book_model.dart';

class CartProvider extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  bool _loading = false;
  bool _success = false;
  List<dynamic> _carts = [];
  double? _totalPrice;
  get sucessCart => _success;
  get loadingCart => _loading;
  List<dynamic> get carts => _carts;
  double get totalPrice => _totalPrice!;
  final box = Hive.box('user');

  Future<void> getCarts() async {
    _loading = true;
    try {
      final userId = await box.get("userId");
      final querySnapshot = await firestore
          .collection("cart")
          .where("userId", isEqualTo: userId)
          .get();
      List<dynamic> cartList = [];
      double total = 0.0;
      for (int i = 0; i < querySnapshot.docs.length; i++) {
        total += double.parse(querySnapshot.docs[i]['amount'].toString()) *
            double.parse(querySnapshot.docs[i]['sale_price'].toString());
        cartList.add(querySnapshot.docs[i]);
      }
      _carts = cartList;
      _totalPrice = total;
      _loading = false;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteCart({
    required String id,
  }) async {
    try {
      firestore.collection("cart").doc(id).get().then((value1) {
        value1.reference.delete().then((value2) {
          if (value1.data()!.isEmpty) {
            _success = true;
            _loading = false;
            notifyListeners();
          } else {
            getCarts();
            _success = true;
            _loading = false;
            notifyListeners();
          }
        }).catchError((onError) {
          _success = false;
          _loading = false;
          notifyListeners();
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addAmountCart({
    required String id,
  }) async {
    _loading = true;
    try {
      firestore.collection("cart").doc(id).get().then((value) {
        value.reference.update({
          "amount": value.data()!['amount'] + 1,
        }).then((value) {
          getCarts();
          _success = true;
          _loading = false;
          notifyListeners();
        }).catchError((onError) {
          _success = false;
          _loading = false;
          notifyListeners();
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeAmountCart({
    required String id,
  }) async {
    _loading = true;
    try {
      firestore.collection("cart").doc(id).get().then((value) {
        value.reference.update({
          "amount": value.data()!['amount'] - 1,
        }).then((value) {
          getCarts();
          _success = true;
          _loading = false;
          notifyListeners();
        }).catchError((onError) {
          _success = false;
          _loading = false;
          notifyListeners();
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> remove({
    required BookModel books,
    required int amount,
  }) async {
    try {
      firestore.collection("cart").doc(books.id).get().then((value) {
        value.reference.update({
          "amount": value.data()!['amount'] + amount,
        }).then((value) {
          _success = true;
          notifyListeners();
        }).catchError((onError) {
          _success = false;
          notifyListeners();
        });
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCart({
    required BookModel books,
    required int amount,
  }) async {
    try {
      List<String> _cartId = [];
      final userId = await box.get("userId");
      final querySnapshot = await firestore
          .collection("cart")
          .where("userId", isEqualTo: userId)
          .get();

      for (int i = 0; i < querySnapshot.docs.length; i++) {
        _cartId.add(querySnapshot.docs[i].id);
      }
      //print("=========>${_cartId.length}");
      if (_cartId.contains(books.id)) {
        await firestore.collection("cart").doc(books.id).get().then((value) {
          value.reference.update({
            "amount": value.data()!['amount'] + amount,
          }).then((value) {
            _success = true;

            notifyListeners();
          }).catchError((onError) {
            _success = false;

            notifyListeners();
          });
        });
      } else {
        print("=========>${_cartId.length}");
        await firestore.collection("cart").doc(books.id.toString()).set({
          "id": books.id,
          "userId": userId,
          "amount": amount,
          "name": books.name,
          "detail": books.detail,
          "image": books.image.toString(),
          "category_id": FieldValue.arrayUnion([
            {
              "id": books.category_id!.id,
              "name": books.category_id!.name,
              "image": books.category_id!.image
            }
          ]),
          "order_price": books.order_price,
          "sale_price": books.sale_price
        }).then((value) {
          _success = true;

          notifyListeners();
        }).catchError((onError) {
          _success = false;

          notifyListeners();
        });
      }
    } catch (e) {
      print("========>" + e.toString());
      rethrow;
    }
  }
}
