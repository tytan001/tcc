class OrderDTO {
  final String nameStore;
  final String payment;
  final int id;

  OrderDTO({this.nameStore, this.payment, this.id});

  factory OrderDTO.fromJson(Map<String, dynamic> json) {
    return OrderDTO(
        nameStore: json["store_name"],
        payment: json["payment"],
        id: json["id"]);
  }

  static List<OrderDTO> toList(List data) {
    List<OrderDTO> orders = [];
    for (dynamic map in data) {
      orders.add(OrderDTO.fromJson(map));
    }
    return orders;
  }
}
