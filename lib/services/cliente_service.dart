import 'dart:convert';

import 'package:idrink/models/cliente.dart';
import 'package:idrink/services/service_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

enum SharedPreferencesKeys {
  CLIENTE,
}

abstract class ClienteService{
  static Future<void> saveCliente(Map<String, dynamic> response) async{
    try{
      final preferences = await SharedPreferences.getInstance();

      final cliente = Cliente.fromJson(response);

      final clienteJson = Cliente.toJson(cliente);

      final didSave = await preferences.setString(SharedPreferencesKeys.CLIENTE.toString(), clienteJson);

      if (!didSave) {
        throw ServiceException(
          'Unable to save token on SharedPreferences',
          classOrigin: 'JWTService',
          methodOrigin: 'saveUser',
          lineOrigin: '12',
        );
      }
//      return token;

    } catch(err, stack){
      print('Something went wrong when accessing SharedPreferences!');
      print('StackTrace\n$stack');
      throw err;
    }
  }

  static Future<Cliente> getCliente() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final jsonRes = preferences.getString(SharedPreferencesKeys.CLIENTE.toString());

      return (jsonRes == null)? null : Cliente.fromSharedPreferences(json.decode(jsonRes));

    } catch (err, stack) {
      print('Something went wrong when accessing SharedPreferences!');
      print('StackTrace\n$stack');
      return null;
    }
  }

  static void removeCliente() async{
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(SharedPreferencesKeys.CLIENTE.toString());
  }
}