class Address {
  final String cep;
  final String publicPlace;
  final String complement;
  final String neighborhood;
  final String locality;
  final String uf;
  final String number;
  final String latitude;
  final String longitude;
  final int idUser;
  final int id;

  Address(
      {this.cep,
      this.publicPlace,
      this.complement,
      this.neighborhood,
      this.locality,
      this.uf,
      this.number,
      this.latitude,
      this.longitude,
      this.idUser,
      this.id});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        cep: json["cep"],
        publicPlace: json["logradouro"],
        complement: json["complemento"],
        neighborhood: json["bairro"],
        locality: json["localidade"],
        uf: json["uf"],
        number: json["numero"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        idUser: int.parse(json["user_id"].toString()),
        id: int.parse(json["id"].toString()));
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    if (cep != null) map["cep"] = cep;
    if (publicPlace != null) map["logradouro"] = publicPlace;
    if (complement != null) map["complemento"] = complement;
    if (neighborhood != null) map["bairro"] = neighborhood;
    if (locality != null) map["localidade"] = locality;
    if (uf != null) map["uf"] = uf;
    if (number != null) map["numero"] = number;
    if (latitude != null) map["latitude"] = latitude;
    if (longitude != null) map["longitude"] = longitude;
    if (idUser != null) map["user_id"] = idUser.toString();
    if (id != null) map["id"] = id.toString();

    return map;
  }

//  Map<String, dynamic> toMap() {
//    return {
//      "cep": cep,
//      "logradouro": publicPlace,
//      "complemento": complement,
//      "bairro": neighborhood,
//      "localidade": locality,
//      "uf": uf,
//      "numero": number,
//      "latitude": latitude,
//      "longitude": longitude,
//      "user_id": idUser
//    };
//  }

  static List<Address> toList(List data) {
    List<Address> addresses = [];
    for (dynamic map in data) {
      addresses.add(Address.fromJson(map));
    }
    return addresses;
  }
}
