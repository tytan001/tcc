class Order {
  final int status;
  final String payment;
  final int idAddress;
  final int idClient;
  final int idStore;

  Order(
      {this.status, this.payment, this.idAddress, this.idClient, this.idStore});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        status: json["status"],
        payment: json["payment"],
        idAddress: json["address_id"],
        idClient: json["customer_id"],
        idStore: json["store_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "payment": payment,
      "address_id": idAddress,
      "customer_id": idClient,
      "store_id": idStore
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
