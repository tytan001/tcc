import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrink/utils/token_headers.dart';

const API_KEY = "http://idrink-tcc.herokuapp.com/api/";
const API_CLIENTE_NOVO = "users/new";
const API_LOGIN = "users/login";
const API_LOGOUT = "users/logout";
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

  Future<Map<String, dynamic>> login(Map body) async {
    const URL = API_KEY + API_LOGIN;
    return http.post(URL, body: body, headers: Header.headerDefault()).then((response){
      final int statusCode = response.statusCode;

      if(statusCode < 200 || statusCode > 400 || json == null){
        throw new Exception("Error while fetching data");

      } else {
//        return Cliente.fromJson(json.decode(response.body));
        return json.decode(response.body);
      }
    });
  }

  Future<Map<String, dynamic>> logout(String token) async {
    const URL = API_KEY + API_LOGOUT;
    return http.get(URL, headers: Header.headerToken(token)).then((response){
      final int statusCode = response.statusCode;

      if(statusCode < 200 || statusCode > 400 || json == null){
        print(response);
        print(response.body);
        print(statusCode);
        throw new Exception("Error while fetching data");

      } else {
//        return Cliente.fromJson(json.decode(response.body));
        return json.decode(response.body);
      }
    });
  }
}