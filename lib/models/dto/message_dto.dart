class MessageDTO {
  final int idUser;
  final int idStore;
  final int idOrder;
  final String message;
  final String create;

  MessageDTO(
      {this.idUser, this.idStore, this.idOrder, this.message, this.create});

  factory MessageDTO.fromJson(Map<String, dynamic> json) {
    return MessageDTO(
        idUser: int.parse(json["customer_id"].toString()),
        idStore: int.parse(json["store_id"].toString()),
        idOrder: int.parse(json["delivery_id"].toString()),
        message: json["message"],
        create: json["created_at"]);
  }

  static List<MessageDTO> toList(List data) {
    List<MessageDTO> orders = [];
    for (dynamic map in data) {
      orders.add(MessageDTO.fromJson(map));
    }
    return orders;
  }
}
