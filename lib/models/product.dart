class Product {
  final int id;
  final String name;
  final String price;
  final String status;
  final int user_id;

  Product({this.id, this.name, this.price, this.status, this.user_id});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        status: json["status"],
        user_id: json["user_id"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "price": price, "status": status, "user_id": user_id};
  }

  static List<Product> toList(List data) {
    List<Product> products = [];
    for (dynamic map in data) {
      products.add(Product.fromJson(map));
    }
    return products;
  }
}
