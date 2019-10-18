class Order {
  final String status;
  final String payment;
  final int idAddress;
  final int idClient;
  final int idStore;
  final int id;

  Order(
      {this.status,
      this.payment,
      this.idAddress,
      this.idClient,
      this.idStore,
      this.id});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        status: json["status"],
        payment: json["payment"],
        idAddress: int.parse(json["address_id"]),
        idClient: int.parse(json["customer_id"]),
        idStore: int.parse(json["store_id"]),
        id: json["id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "payment": payment,
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
