
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
      id: json['customer_id'],
      name: json['customer_name'],
      email: json['customer_email'],
      password: json['customer_password'],
//      cpf: json['customer_cpf'],
      phone: json['customer_phone'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["customer_name"] = name;
    map["customer_email"] = email;
    map["customer_password"] = password;
//    map["customer_cpf"] = cpf;
    map["customer_phone"] = phone;

    if(id != null){
      map["customer_id"] = id;
    }

    return map;
  }

  @override
  String toString() {
    return " Name: $name \n Email: $email\n Password: $password\n Phone: $phone";
  }


}