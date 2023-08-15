import 'dart:convert';

List<BookModel> bookModelFromJson(String str) =>
    List<BookModel>.from(json.decode(str).map((x) => BookModel.fromJson(x)));

class BookModel {
  final String? id;
  final CategoryModel? category_id;
  final String? name;
  final String? detail;
  final int? qty;
  final String? image;
  final int? order_price;
  final int? sale_price;

  BookModel({
    this.id,
    this.category_id,
    this.name,
    this.detail,
    this.qty,
    this.image,
    this.order_price,
    this.sale_price,
  });
  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json['_id'],
        category_id: CategoryModel.fromJson(json['category_id']),
        name: json['name'],
        detail: json['detail'],
        qty: json['qty'],
        image: json['image'],
        order_price: json['order_price'],
        sale_price: json['sale_price'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": category_id,
        "name": name,
        "detail": detail,
        "qty": qty,
        "image": image,
        "order_price": order_price,
        "sale_price": sale_price,
      };
}

//
class CategoryModel {
  final String? id;
  final String? name;
  final String? image;

  CategoryModel({
    this.id,
    this.name,
    this.image,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        name: json["name"],
        image: json['image'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
      };
}
