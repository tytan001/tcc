import 'dart:convert';

import 'package:idrink/models/client.dart';
import 'package:idrink/services/service_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

enum SharedPreferencesKeys {
  CLIENT,
}

abstract class ClientService {
  static Future<void> saveClient(Map<String, dynamic> response) async {
    try {
      final preferences = await SharedPreferences.getInstance();

      final client = Client.fromJson(response);

      final clientJson = Client.toJson(client);

      final didSave = await preferences.setString(
          SharedPreferencesKeys.CLIENT.toString(), clientJson);

      if (!didSave) {
        throw ServiceException(
          'Unable to save token on SharedPreferences',
          classOrigin: 'JWTService',
          methodOrigin: 'saveUser',
          lineOrigin: '12',
        );
      }
    } catch (err, stack) {
      print('Something went wrong when accessing SharedPreferences!');
      print('StackTrace\n$stack');
      throw err;
    }
  }

  static Future<Client> getClient() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final jsonRes =
          preferences.getString(SharedPreferencesKeys.CLIENT.toString());

      return (jsonRes == null)
          ? null
          : Client.fromSharedPreferences(json.decode(jsonRes));
    } catch (err, stack) {
      print('Something went wrong when accessing SharedPreferences!');
      print('StackTrace\n$stack');
      return null;
    }
  }

  static void removeClient() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(SharedPreferencesKeys.CLIENT.toString());
  }
}
