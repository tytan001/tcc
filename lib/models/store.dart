class Store {
  final int id;
  final String name;
  final String email;
  final String phone;

  Store({this.id, this.name, this.email, this.phone});

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "email": email, "phone": phone};
  }

  static List<Store> toList(List data) {
    List<Store> stores = [];
    for (dynamic map in data) {
      stores.add(Store.fromJson(map));
    }
    return stores;
  }
}
