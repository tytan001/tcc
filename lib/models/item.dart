class Item {
  int quantity;
  int idProduct;
  int idOrder;
  double partialPrice;

  Item({this.quantity, this.idProduct, this.idOrder, this.partialPrice});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        quantity: int.parse(json["quantity"].toString()),
        idProduct: int.parse(json["product_id"].toString()),
        idOrder: int.parse(json["delivery_id"].toString()),
        partialPrice: double.parse(json["parcial_price"].toString()));
  }

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "product_id": idProduct,
      "delivery_id": idOrder,
      "parcial_price": partialPrice
    };
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (quantity != null) map["quantity"] = quantity.toString();
    if (idProduct != null) map["product_id"] = idProduct.toString();
    if (idOrder != null) map["delivery_id"] = idOrder.toString();
    if (partialPrice != null) map["parcial_price"] = partialPrice.toString();

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
