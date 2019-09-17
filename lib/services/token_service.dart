import 'dart:convert';

import 'package:idrink/models/token.dart';
import 'package:idrink/services/service_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

enum SharedPreferencesKeys {
  TOKEN,
}

abstract class TokenService {
  static Future<void> saveToken(String token) async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final tokenJson = Token.toJSON(token);
      final didSave = await preferences.setString(
          SharedPreferencesKeys.TOKEN.toString(), tokenJson);
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

  static Future<Token> getToken() async {
    try {
      final preferences = await SharedPreferences.getInstance();
      final jsonRes =
          preferences.getString(SharedPreferencesKeys.TOKEN.toString());

      return (jsonRes == null)
          ? null
          : Token.fromSharedPreferences(json.decode(jsonRes));
    } catch (err, stack) {
      print('Something went wrong when accessing SharedPreferences!');
      print('StackTrace\n$stack');
      return null;
    }
  }

  static void removeToken() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(SharedPreferencesKeys.TOKEN.toString());
  }
}
