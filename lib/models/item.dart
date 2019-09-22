class Item {
  final int id;

  final int quantity;

  final int idOrder;

  final int idProduct;

  Item({this.id, this.quantity, this.idOrder, this.idProduct});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
        id: json["id"],
        quantity: json["idStore"],
        idOrder: json["idProduct"],
        idProduct: json["idProduct"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "quantity": quantity, "idOrder": idOrder, "idProduct": idProduct};
  }

  static List<Item> toList(List data) {
    List<Item> stores = [];
    for (dynamic map in data) {
      stores.add(Item.fromJson(map));
    }
    return stores;
  }
}