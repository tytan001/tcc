class Item {
  int quantity;
  int idClient;
  int idProduct;
  int idOrder;

  Item({this.quantity, this.idClient, this.idProduct, this.idOrder});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        quantity: json["quantity"],
        idClient: json["customer_id"],
        idProduct: json["product_id"],
        idOrder: json["delivery_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "customer_id": idClient,
      "product_id": idProduct,
      "delivery_id": idOrder
    };
  }

  static List<Item> toList(List data) {
    List<Item> stores = [];
    for (dynamic map in data) {
      stores.add(Item.fromJson(map));
    }
    return stores;
  }
}
