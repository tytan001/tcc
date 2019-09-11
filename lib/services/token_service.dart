import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:idrink/models/token.dart';
import 'package:idrink/pages/auth/main_auth_page.dart';
import 'package:idrink/services/service_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

enum SharedPreferencesKeys {
  TOKEN,
}

abstract class TokenService{
  static Future<void> saveUser(String token) async{
    try{
      final preferences = await SharedPreferences.getInstance();
      final tokenJson = Token.toJSON(token);
//      final json = Token.toJSON(token);
      final didSave = await preferences.setString(SharedPreferencesKeys.TOKEN.toString(), tokenJson);
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


  static Future<Token> getToken() async {
    try {
      final preferences = await SharedPreferences.getInstance();
//            preferences.remove(SharedPreferencesKeys.TOKEN.toString());
      final jsonRes = preferences.getString(SharedPreferencesKeys.TOKEN.toString());
      if (jsonRes == null) return null;
      return Token.fromSharedPreferences(json.decode(jsonRes));
    } catch (err, stack) {
      print('Something went wrong when accessing SharedPreferences!');
      print('StackTrace\n$stack');
      return null;
    }
  }


  static void singOut(BuildContext ctx) async{
    final preferences = await SharedPreferences.getInstance();
    preferences.remove(SharedPreferencesKeys.TOKEN.toString());

    Navigator.pushReplacement(ctx, MaterialPageRoute(
      builder: (BuildContext context) => MainAuthPage(),
    ));
  }
}