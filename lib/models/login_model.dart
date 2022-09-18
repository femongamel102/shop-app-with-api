class ShopLoginModel {
  bool? status;
  String? message;
  UserData? data;
  ShopLoginModel({this.status, this.message, this.data});
  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  String? name;
  String? email;
  String? phone;
  int? id;
  String? image;
  String? token;
  UserData(
      {this.id, this.name, this.email, this.phone, this.image, this.token});

  // named constructor
  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    id = json['id'];
    image = json['image'];
    token = json['token'];
  }
}
