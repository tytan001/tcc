import 'dart:convert';

class Cliente{
  final int id;
  final String name;
  final String email;
  final String password;
//  final String cpf;
  final String phone;

  Cliente({this.id, this.name, this.email, this.password, this.phone});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
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
//    map["cpf"] = cpf;
    map["phone"] = phone;

    if(id != null){
      map["id"] = id;
    }

    return map;
  }

  static String toJson(Cliente cliente) {
    Map<String, dynamic> map = {
    'id': cliente.id,
    "name":  cliente.name,
    "email":  cliente.email,
//    "password":  cliente.password,
//      "cpf":  cliente.cpf,
    "phone":  cliente.phone,
    };
    return json.encode(map);
  }

  static Cliente fromSharedPreferences(dynamic json) {
    return Cliente.fromJson(json);
  }

  @override
  String toString() {
    return " Name: $name \n Email: $email\n Password: $password\n Phone: $phone";
  }

}