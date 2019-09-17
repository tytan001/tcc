class Product {
  final int id;
  final String name;
  final String preco;
  final String phone;

  Product({this.id, this.name, this.preco, this.phone});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        name: json["name"],
        preco: json["preco"],
        phone: json["phone"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "preco": preco, "phone": phone};
  }

  static List<Product> toList(List data) {
    List<Product> stores = [];
    for (dynamic map in data) {
      stores.add(Product.fromJson(map));
    }
    return stores;
  }
}
