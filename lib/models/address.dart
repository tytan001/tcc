class Address {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String numero;
  final String latitude;
  final String longitude;
  final int idUser;

  Address({this.cep, this.logradouro, this.complemento, this.bairro, this.localidade, this.uf,  this.numero,this.latitude, this.longitude, this.idUser});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        cep: json["cep"],
        logradouro: json["logradouro"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        localidade: json["localidade"],
        uf: json["uf"],
        numero: json["numero"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        idUser: json["user_id"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "cep": cep,
      "logradouro": logradouro,
      "complemento": complemento,
      "bairro": bairro,
      "localidade": localidade,
      "uf": uf,
      "numero": numero,
      "latitude": latitude,
      "longitude": longitude,
      "user_id": idUser
    };
  }

  static List<Address> toList(List data) {
    List<Address> addresses = [];
    for (dynamic map in data) {
      addresses.add(Address.fromJson(map));
    }
    return addresses;
  }

}
