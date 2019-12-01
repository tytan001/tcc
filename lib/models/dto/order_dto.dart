class OrderDTO {
  final String nameStore;
  final String payment;
  final String status;
  final int idStore;
  final int id;

  OrderDTO({this.nameStore, this.payment, this.status, this.idStore, this.id});

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
        nameStore: json["store_name"],
        payment: json["payment"],
        status: json["status"],
        idStore: int.parse(json["store_id"].toString()),
        id: int.parse(json["id"].toString()));
  }

  static List<OrderDTO> toList(List data) {
    List<OrderDTO> orders = [];
    for (dynamic map in data) {
      orders.add(OrderDTO.fromJson(map));
    }
    return orders;
  }
}
