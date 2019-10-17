import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/utils/token_headers.dart';

const API_KEY = "http://idrink-tcc.herokuapp.com/api/";
const API_NEW_CLIENT = "users";
const API_UPDATE_CLIENT = "users/";
const API_LOGIN = "users/login";
const API_LOGOUT = "users/logout";
const API_STORES = "stores";
const API_SEARCH_STORES = "stores/";
const API_NEW_ADDRESSES = "adresses";
const API_ADDRESSES = "adresses";
const API_PRODUCTS = "stores/products/";
const API_SEARCH_PRODUCTS = "test";
const API_ITEM = "test";

class Api {
  Future<Map<String, dynamic>> createClient(Map body) async {
    const URL = API_KEY + API_NEW_CLIENT;

    try {
      return http.post(URL, body: body).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 400) {
          final responseErr = responseReturn["errors"];
          if (responseErr["email"] != null) {
            throw ResourceException(responseErr["email"][0].toString());
          } else if (responseErr["password"] != null) {
            throw ResourceException(responseErr["password"][0].toString());
          } else if (responseReturn != null) {
            throw ResourceException(responseReturn.toString());
          } else {
            throw ResourceException(responseReturn.toString());
          }
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } catch (e) {
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> updateClient(
      Map body, int id, String token) async {
    final url = API_KEY + API_UPDATE_CLIENT + id.toString();

    try {
      return http
          .put(url, headers: Header.headerToken(token), body: body)
          .then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw ResourceException(responseReturn["message"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } catch (e) {
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> stores(String token) async {
    const URL = API_KEY + API_STORES;
    try {
      return http.get(URL, headers: Header.headerToken(token)).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw new ResourceException(responseReturn["response"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } on Exception catch (e) {
      print(e);
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> searchStores(String token, String search) async {
    final url = API_KEY + API_SEARCH_STORES + search;
    try {
      return http.get(url, headers: Header.headerToken(token)).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw new ResourceException(responseReturn["response"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } catch (e) {
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<void> createAddresses(String token, Map body) async {
    const URL = API_KEY + API_NEW_ADDRESSES;
    try {
      return http.post(URL, body: body, headers: Header.headerToken(token)).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw new ResourceException(responseReturn["response"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } on Exception catch (e) {
      print(e);
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> addresses(String token) async {
    const URL = API_KEY + API_ADDRESSES;
    try {
      return http.get(URL, headers: Header.headerToken(token)).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw new ResourceException(responseReturn["response"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } on Exception catch (e) {
      print(e);
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> products(String token, int idStore) async {
    final url = API_KEY + API_PRODUCTS + idStore.toString();
    try {
      return http.get(url, headers: Header.headerToken(token)).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw new ResourceException(responseReturn["response"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } catch (e) {
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> searchProducts(
      String token, String idStore, String search) async {
    try {
      final url = API_KEY + API_SEARCH_PRODUCTS + idStore + "/" + search;
      return http.get(url, headers: Header.headerToken(token)).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw new ResourceException(responseReturn["response"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } catch (e) {
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> login(Map body) async {
    const URL = API_KEY + API_LOGIN;
    try {
      return http
          .post(URL, body: body, headers: Header.headerDefault())
          .then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw new ResourceException(responseReturn["response"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } catch (e) {
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> logout(String token) async {
    const URL = API_KEY + API_LOGOUT;
    try {
      return http.get(URL, headers: Header.headerToken(token)).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 401) {
          throw ResourceException(responseReturn["message"]);
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } catch (e) {
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> viaCep(String cep) async {
    final url = "http://viacep.com.br/ws/$cep/json/";
    try {
      return http.get(url, headers: Header.headerDefault()).then((response) {
        final int statusCode = response.statusCode;
        final responseReturn = json.decode(response.body);
        if (statusCode == 400) {
          throw new ResourceException("Cep inválido");
        } else if (statusCode == 404) {
          throw new ResourceException("Cep não encontrado");
        } else if (responseReturn["erro"] == true) {
          throw new ResourceException("Cep inválido");
        } else if (statusCode == 200) {
          return responseReturn;
        } else {
          throw ResourceException("Erro inesperado!\nCode $statusCode");
        }
      });
    } on Exception catch (e) {
      throw ResourceException("Erro inesperado!");
    }
  }
}
