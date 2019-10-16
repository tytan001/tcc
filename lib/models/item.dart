class Item {
  int quantity;
  int idProduct;
  int idOrder;

  Item({this.quantity, this.idProduct, this.idOrder});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        quantity: json["quantity"],
        idProduct: json["product_id"],
        idOrder: json["delivery_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
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

  @override
  bool operator ==(other) => other is Item && other.idProduct == idProduct;

  @override
  int get hashCode => idProduct.hashCode ^ idOrder.hashCode;
}
