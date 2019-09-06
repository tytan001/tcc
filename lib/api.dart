import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrink/models/cliente.dart';

const API_KEY = "http://idrink-tcc.herokuapp.com/api/";
const API_CLIENTE_NOVO = "users/new";
const API_CLIENTE = "test";
const API_LOJA = "test";
const API_PRODUTO = "test";
const API_ITEM = "test";

class Api {

  Future<Map<String, dynamic>> createCliente(Map body) async {
    const URL = API_KEY + API_CLIENTE_NOVO;
    return http.post(URL, body: body).then((response){
      final int statusCode = response.statusCode;

      if(statusCode < 200 || statusCode > 400 || json == null){
        throw new Exception("Error while fetching data");

      } else {
//        return Cliente.fromJson(json.decode(response.body));
        return json.decode(response.body);
      }
    });
  }
}