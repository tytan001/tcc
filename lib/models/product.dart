class Product {
  final int id;
  final int idStore;
  final String name;
  final String price;

  Product({this.id, this.idStore, this.name, this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: int.parse(json["id"].toString()),
        idStore: int.parse(json["store_id"].toString()),
        name: json["name"],
        price: json["price"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "store_id": idStore, "name": name, "price": price};
  }

  static List<Product> toList(List data) {
    List<Product> products = [];
    for (dynamic map in data) {
      products.add(Product.fromJson(map));
    }
    return products;
  }

  @override
  bool operator ==(other) => other is Product && other.id == id;

  @override
  int get hashCode => id.hashCode ^ idStore.hashCode;
}
