class Loja {
  final int id;
  final String name;
  final String email;
  final String phone;

  Loja({this.id, this.name, this.email, this.phone});

  factory Loja.fromJson(Map<String, dynamic> json) {
    return Loja(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "phone": phone};
  }

  static List<Loja> toList(List data){
    List<Loja> stores = [];
    for(dynamic map in data){
      stores.add(Loja.fromJson(map));
    }
    return stores;

  }
}
