class Item {
  final int id;
  final double quantity;
  final int idProduct;
  final int idOrder;

  Item({this.id, this.quantity, this.idProduct, this.idOrder});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json["customer_id"],
        quantity: json["quantity"],
        idProduct: json["product_id"],
        idOrder: json["delivery_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "customer_id": id,
      "quantity": quantity,
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
