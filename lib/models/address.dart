class Address {
  final String address;
  final String latitude;
  final String longitude;
  final int idUser;

  Address({this.address, this.latitude, this.longitude, this.idUser});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        idUser: json["user_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "user_id": idUser
    };
  }
}
