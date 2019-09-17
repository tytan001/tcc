import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrink/utils/token_headers.dart';

const API_KEY = "http://idrink-tcc.herokuapp.com/api/";
const API_NEW_CLIENT = "users/new";
const API_LOGIN = "users/login";
const API_LOGOUT = "users/logout";
const API_STORES = "users/all/stores";
const API_SEARCH_STORES = "users/getstore/";
const API_PRODUCTS = "users/products/";
const API_SEARCH_PRODUCTS = "test";
const API_ITEM = "test";

class Api {
  Future<Map<String, dynamic>> createClient(Map body) async {
    const URL = API_KEY + API_NEW_CLIENT;
    return http.post(URL, body: body).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
//        return Cliente.fromJson(json.decode(response.body));
        return json.decode(response.body);
      }
    });
  }

  Future<List<dynamic>> stores(String token) async {
    const URL = API_KEY + API_STORES;
    return http.get(URL, headers: Header.headerToken(token)).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
        return json.decode(response.body);
      }
    });
  }

  Future<List<dynamic>> searchStores(String token, String search) async {
    final url = API_KEY + API_SEARCH_STORES + search;
    return http.get(url, headers: Header.headerToken(token)).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
        return json.decode(response.body);
      }
    });
  }

  Future<List<dynamic>> products(String token) async {
    const URL = API_KEY + API_PRODUCTS;
    return http.get(URL, headers: Header.headerToken(token)).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
        return json.decode(response.body);
      }
    });
  }

  Future<List<dynamic>> searchProducts(String token, String search) async {
    final url = API_KEY + API_SEARCH_PRODUCTS + search;
    return http.get(url, headers: Header.headerToken(token)).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
        return json.decode(response.body);
      }
    });
  }

  Future<Map<String, dynamic>> login(Map body) async {
    const URL = API_KEY + API_LOGIN;
    return http
        .post(URL, body: body, headers: Header.headerDefault())
        .then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
//        return Cliente.fromJson(json.decode(response.body));
        return json.decode(response.body);
      }
    });
  }

  Future<Map<String, dynamic>> logout(String token) async {
    const URL = API_KEY + API_LOGOUT;
    return http.get(URL, headers: Header.headerToken(token)).then((response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
//        return Cliente.fromJson(json.decode(response.body));
        return json.decode(response.body);
      }
    });
  }
}
