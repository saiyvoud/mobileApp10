class UserModel {
  final String? id;
  final String? username;
  final String? email;
  final int? phone;
  final String? password;

  UserModel({
    this.username,
    this.email,
    this.phone,
    this.password,
    this.id,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "password": password,
      };
}
