class Product {
  final int idStore;
  final String name;
  final String price;

  Product({this.idStore, this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        idStore: json["store_id"], name: json["name"], price: json["price"]);
  }

  Map<String, dynamic> toJson() {
    return {"store_id": idStore, "name": name, "price": price};
  }

  static List<Product> toList(List data) {
    List<Product> products = [];
    for (dynamic map in data) {
      products.add(Product.fromJson(map));
    }
    return products;
  }
}
