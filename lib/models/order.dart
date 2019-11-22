class Order {
  final String status;
  final String payment;
  final String change;
  final String totalPrice;
  final int idAddress;
  final int idClient;
  final int idStore;
  final int id;

  Order(
      {this.status,
      this.payment,
      this.change,
      this.totalPrice,
      this.idAddress,
      this.idClient,
      this.idStore,
      this.id});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        status: json["status"],
        payment: json["payment"],
        change: json["change"],
        totalPrice: json["total_price"],
        idAddress: int.parse(json["address_id"].toString()),
        idClient: int.parse(json["customer_id"].toString()),
        idStore: int.parse(json["store_id"].toString()),
        id: int.parse(json["id"].toString()));
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "payment": payment,
      "change": change,
      "total_price": totalPrice,
      "address_id": idAddress,
      "customer_id": idClient,
      "store_id": idStore,
      "id": id
    };
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (status != null) map["status"] = status;
    if (payment != null) map["payment"] = payment;
    if (change != null) map["change"] = change;
    if (totalPrice != null) map["total_price"] = totalPrice;
    if (idAddress != null) map["address_id"] = idAddress.toString();
    if (idClient != null) map["customer_id"] = idClient.toString();
    if (idStore != null) map["store_id"] = idStore.toString();
    if (id != null) map["id"] = id.toString();

    return map;
  }

  static List<Order> toList(List data) {
    List<Order> stores = [];
    for (dynamic map in data) {
      stores.add(Order.fromJson(map));
    }
    return stores;
  }
}
