class Login {
  final String email;
  final String password;

  Login({this.email, this.password});

//  factory Login.fromJson(Map<String, dynamic> json) {
//    return Login(
//      email: json['customer_email'],
//      password: json['customer_password'],
//    );
//  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["customer_email"] = email;
    map["customer_password"] = password;

    return map;
  }

  @override
  String toString() {
    return " Email: $email\n Password: $password\n";
  }
}
