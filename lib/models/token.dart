import 'dart:convert';

import 'package:meta/meta.dart';

class Token {
  final String tokenEncoded;

  Token({@required this.tokenEncoded});

  Token.fromSharedPreferences(dynamic json) : tokenEncoded = json['token'];

  static String fromJSON({Map<String, dynamic> tokenEncoded}) {
    return tokenEncoded["token"];
  }

  static String toJSON(String token) {
    Map<String, dynamic> map = {
      'token': token,
    };
    return json.encode(map);
  }

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    buffer.writeln('Token: {');
    buffer.writeln('tokenEncoded: $tokenEncoded');
    buffer.write('}');
    return buffer.toString();
  }
}
