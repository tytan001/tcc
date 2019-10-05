class Product {
  final int id;
  final int idStore;
  final String name;
  final String price;

  Product({this.id, this.idStore, this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json["store_id"], idStore: json["store_id"], name: json["name"], price: json["price"]);
  }

  Map<String, dynamic> toJson() {
    return {"store_id": id, "store_id": idStore, "name": name, "price": price};
  }

  static List<Product> toList(List data) {
    List<Product> products = [];
    for (dynamic map in data) {
      products.add(Product.fromJson(map));
    }
    return products;
  }
}
