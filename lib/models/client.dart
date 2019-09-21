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
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["email"] = email;
    map["password"] = password;
    map["confirmPassword"] = confirmPassword;
//    map["cpf"] = cpf;
    map["phone"] = phone;

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static String toJson(Client cliente) {
    Map<String, dynamic> map = {
      'id': cliente.id,
      "name": cliente.name,
      "email": cliente.email,
//    "password":  cliente.password,
//      "cpf":  cliente.cpf,
      "phone": cliente.phone,
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
