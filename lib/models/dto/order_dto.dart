class OrderDTO {
  final String nameStore;
  final String payment;
  final int id;

  OrderDTO(
      {this.nameStore,
      this.payment,
      this.id});

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
        nameStore: json["status"],
        payment: json["payment"],
        id: json["id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": nameStore,
      "payment": payment,
      "id": id
    };
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (nameStore != null) map["status"] = nameStore;
    if (payment != null) map["payment"] = payment;
    if (id != null) map["id"] = id.toString();

    return map;
  }

  static List<OrderDTO> toList(List data) {
    List<OrderDTO> stores = [];
    for (dynamic map in data) {
      stores.add(OrderDTO.fromJson(map));
    }
    return stores;
  }
}
