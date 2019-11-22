class ItemDTO {
  int quantity;
  String productName;
  int idOrder;
  double price;
  double partialPrice;

  ItemDTO(
      {this.quantity,
      this.productName,
      this.idOrder,
      this.price,
      this.partialPrice});

  factory ItemDTO.fromJson(Map<String, dynamic> json) {
    return ItemDTO(
        quantity: int.parse(json["quantity"].toString()),
        productName: json["product_name"],
        idOrder: int.parse(json["delivery_id"].toString()),
        price: double.parse(json["price"].toString()),
//        partialPrice: double.parse(json["parcial_price"])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "quantity": quantity,
      "product_name": productName,
      "delivery_id": idOrder,
      "price": price,
      "parcial_price": partialPrice
    };
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (quantity != null) map["quantity"] = quantity.toString();
    if (productName != null) map["product_name"] = productName;
    if (idOrder != null) map["delivery_id"] = idOrder.toString();
    if (price != null) map["price"] = price.toString();
    if (partialPrice != null) map["parcial_price"] = partialPrice.toString();

    return map;
  }

  static List<ItemDTO> toList(List data) {
    List<ItemDTO> items = [];
    for (dynamic map in data) {
      items.add(ItemDTO.fromJson(map));
    }
    return items;
  }

  @override
  bool operator ==(other) =>
      other is ItemDTO && other.productName == productName;

  @override
  int get hashCode => productName.hashCode ^ idOrder.hashCode;
}
