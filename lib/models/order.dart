class Order {
  final int id;
  final String idStore;
  final String idProduct;
  final String idClient;

  Order({this.id, this.idStore, this.idProduct, this.idClient});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json["id"],
        idStore: json["idStore"],
        idProduct: json["idProduct"],
        idClient: json["idClient"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "idStore": idStore, "idProduct": idProduct, "idClient": idClient};
  }

  static List<Order> toList(List data) {
    List<Order> stores = [];
    for (dynamic map in data) {
      stores.add(Order.fromJson(map));
    }
    return stores;
  }
}
