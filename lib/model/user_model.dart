class UserModel {
  final String? id;
  final String? username;
  final String? email;
  final int? phone;
  final String? password;
  final String? token;

  UserModel({
    this.username,
    this.email,
    this.phone,
    this.password,
    this.id,
    this.token,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        username: json['username'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        token: json['token'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "phone": phone,
        "password": password,
        "token": token
      };
}
