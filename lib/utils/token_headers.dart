import 'dart:io';

abstract class Header {
  static Map<String, String> headerDefault() {
    Map<String, String> requestHeaders = {
//      'Content-type': 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
    return requestHeaders;
  }

  static Map<String, String> headerToken(final token) {
    Map<String, String> requestHeaders = {
//      'Content-type': 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    return requestHeaders;
  }
}
