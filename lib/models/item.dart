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

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (quantity != null) map["quantity"] = quantity.toString();
    if (idProduct != null) map["product_id"] = idProduct.toString();
    if (idOrder != null) map["delivery_id"] = idOrder.toString();

    return map;
  }

  static List<Item> toList(List data) {
    List<Item> items = [];
    for (dynamic map in data) {
      items.add(Item.fromJson(map));
    }
    return items;
  }

  @override
  bool operator ==(other) => other is Item && other.idProduct == idProduct;

  @override
  int get hashCode => idProduct.hashCode ^ idOrder.hashCode;
}
