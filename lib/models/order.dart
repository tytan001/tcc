class Order {
  final int status;
  final String payment;
  final int idAddress;
  final int idStore;
  final int idClient;

  Order(
      {this.status, this.payment, this.idAddress, this.idStore, this.idClient});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        status: json["status"],
        payment: json["payment"],
        idAddress: json["address_id"],
        idStore: json["store_id"],
        idClient: json["customer_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "payment": payment,
      "address_id": idAddress,
      "store_id": idStore,
      "customer_id": idClient
    };
  }

  static List<Order> toList(List data) {
    List<Order> stores = [];
    for (dynamic map in data) {
      stores.add(Order.fromJson(map));
    }
    return stores;
  }
}
