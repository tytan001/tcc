class MessageDTO {
  final int idUser;
  final int idStore;
  final int idOrder;
  final int idSend;
  final String message;
  final String create;

  MessageDTO(
      {this.idUser,this.idStore, this.idOrder, this.idSend, this.message, this.create});

  factory MessageDTO.fromJson(Map<String, dynamic> json) {
    return MessageDTO(
        idUser: int.parse(json["customer_id"].toString()),
        idStore: int.parse(json["store_id"].toString()),
        idOrder: int.parse(json["delivery_id"].toString()),
        idSend: int.parse(json["send_id"].toString()),
        message: json["message"],
        create: json["created_at"]);
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    if (idUser != null) map["customer_id"] = idUser;
    if (idStore != null) map["store_id"] = idStore;
    if (idOrder != null) map["delivery_id"] = idOrder;
    if (idSend != null) map["send_id"] = idSend;
    if (message != null) map["message"] = message;
    if (create != null) map["created_at"] = create;

    return map;
  }

  static List<MessageDTO> toList(List data) {
    List<MessageDTO> orders = [];
    for (dynamic map in data) {
      orders.add(MessageDTO.fromJson(map));
    }
    return orders;
  }
}
