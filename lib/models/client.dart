import 'dart:convert';

class Client {
  final int id;
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
//  final String cpf;
  final String phone;

  Client(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.confirmPassword,
      this.phone});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      email: json['email'],
//      password: json['password'],
//      cpf: json['cpf'],
      phone: json['phone'],
    );
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
//      "cpf" : cpf,
      "phone": phone,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

//  Map toMap() {
//    var map = new Map<String, dynamic>();
//    map["name"] = name;
//    map["email"] = email;
//    map["password"] = password;
//    map["password_confirmation"] = confirmPassword;
////    map["cpf"] = cpf;
//    map["phone"] = phone;
//
//    if (id != null) {
//      map["id"] = id;
//    }
//
//    return map;
//  }

  Map toMapPut() {
    Map<String, dynamic> map = {
      "name": name,
      "email": email,
      "phone": phone,
    };
    return map;
  }

  static String toJson(Client client) {
    Map<String, dynamic> map = {
      'id': client.id,
      "name": client.name,
      "email": client.email,
//    "password":  client.password,
//      "cpf":  client.cpf,
      "phone": client.phone,
    };
    return json.encode(map);
  }

  static Client fromSharedPreferences(dynamic json) {
    return Client.fromJson(json);
  }

  @override
  String toString() {
    return " Name: $name \n Email: $email\n Password: $password\n Phone: $phone";
  }
}
