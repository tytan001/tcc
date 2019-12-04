import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/utils/token_headers.dart';

const ROUTE_IMAGE = 'http://idrink-tcc.herokuapp.com/images/avatar/';
//const ROUTE_IMAGE = 'http://192.168.43.37:8000/images/avatar/';
const API_KEY = "http://idrink-tcc.herokuapp.com/api/";
//const API_KEY = "http://192.168.43.37:8000/api/";
const API_NEW_CLIENT = "users";
const API_UPDATE_CLIENT = "users/";
const API_LOGIN = "users/login";
const API_LOGOUT = "users/logout";
const API_FORGET_PASSWORD = "users/pwdReset";
const API_STORES = "stores";
const API_SEARCH_STORES = "stores/";
const API_NEW_ADDRESSES = "adresses";
const API_UPDATE_ADDRESSES = "adresses/";
const API_DELETE_ADDRESSES = "adresses/";
const API_ADDRESSES = "adresses";
const API_PRODUCTS = "stores/products/";
const API_NEW_ORDER = "deliveries";
const API_NEW_ITEMS = "items";
const API_ORDERS = "deliveries/open";
const API_HISTORIC_ORDERS = "deliveries/canceled-delivered";
const API_ITEMS_ORDER = "items/";

class Api {
  Future<Map<String, dynamic>> createClient(Map body) async {
    const URL = API_KEY + API_NEW_CLIENT;

    try {
      final response = await http.post(URL, body: body);
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
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> updateClient(
      Map body, int id, String token) async {
    final url = API_KEY + API_UPDATE_CLIENT + id.toString();

    try {
      final response =
          await http.put(url, headers: Header.headerToken(token), body: body);
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> stores(String token) async {
    const URL = API_KEY + API_STORES;
    try {
      final response = await http.get(URL, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException("Não autorizado!", code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> searchStores(String token, String search) async {
    final url = API_KEY + API_SEARCH_STORES + search;
    try {
      final response = await http.get(url, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> orders(String token) async {
    const URL = API_KEY + API_ORDERS;
    try {
      final response = await http.get(URL, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> historicOrders(String token) async {
    const URL = API_KEY + API_HISTORIC_ORDERS;
    try {
      final response = await http.get(URL, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> itemsOrder(String token, int idOrder) async {
    final url = API_KEY + API_ITEMS_ORDER + idOrder.toString();
    try {
      final response = await http.get(url, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<void> createAddresses(String token, Map body) async {
    const URL = API_KEY + API_NEW_ADDRESSES;
    try {
      final response =
          await http.post(URL, body: body, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<void> updateAddresses(String token, Map body, int id) async {
    final url = API_KEY + API_UPDATE_ADDRESSES + id.toString();
    try {
      final response =
          await http.put(url, body: body, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<void> deleteAddresses(String token, int id) async {
    final url = API_KEY + API_DELETE_ADDRESSES + id.toString();
    try {
      final response =
          await http.delete(url, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> addresses(String token) async {
    const URL = API_KEY + API_ADDRESSES;
    try {
      final response = await http.get(URL, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<List<dynamic>> products(String token, int idStore) async {
    final url = API_KEY + API_PRODUCTS + idStore.toString();
    try {
      final response = await http.get(url, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> createOrder(String token, Map body) async {
    const URL = API_KEY + API_NEW_ORDER;

    try {
      final response =
          await http.post(URL, body: body, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<void> createItems(String token, final body) async {
    const URL = API_KEY + API_NEW_ITEMS;

    try {
      final response =
          await http.post(URL, body: body, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> login(Map body) async {
    const URL = API_KEY + API_LOGIN;
    try {
      final response =
          await http.post(URL, body: body, headers: Header.headerDefault());
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["response"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> logout(String token) async {
    const URL = API_KEY + API_LOGOUT;
    try {
      final response = await http.get(URL, headers: Header.headerToken(token));
      final int statusCode = response.statusCode;
      final responseReturn = json.decode(response.body);
      if (statusCode == 401) {
        throw ResourceException(responseReturn["message"], code: statusCode);
      } else if (statusCode == 200) {
        return responseReturn;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<void> forgetPassword(Map body) async {
    const URL = API_KEY + API_FORGET_PASSWORD;
    try {
      final response =
          await http.put(URL, body: body, headers: Header.headerDefault());
      final int statusCode = response.statusCode;
      if (statusCode == 404) {
        throw ResourceException("Email não encontrado", code: statusCode);
      } else if (statusCode == 200) {
        return;
      } else {
        throw ResourceException("Erro inesperado!\nCode $statusCode",
            code: statusCode);
      }
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }

  Future<Map<String, dynamic>> viaCep(String cep) async {
    final url = "http://viacep.com.br/ws/$cep/json/";
    try {
      final response = await http.get(url, headers: Header.headerDefault());
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
    } on SocketException catch (e) {
      print(e.toString());
      throw ResourceException("Sem internet");
    } on ResourceException catch (e) {
      throw e;
    } catch (e) {
      print(e.toString());
      throw ResourceException("Erro inesperado!");
    }
  }
}
