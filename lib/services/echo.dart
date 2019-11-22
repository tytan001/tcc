import 'dart:math';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/services/web_socket.dart';

import 'package:stomp/stomp.dart';

class SocketLocationService {

  static StompClient _stomp;
  static WebSocket _webSocket;
  static StreamSubscription<String> _streamSubscriptionLocation;

  static Future<void> init() async {
    isConnected();
    try {
      _webSocket = WebSocket();
      _stomp = await _webSocket.connect("http://192.168.43.69:8000/api/");
    } catch (err) {
      close(false);
//      throw SocketException('Erro ao abrir conexcao Socket', err);
    }
  }

  static void close([final bool closeConnections = true]) {
    if (closeConnections) {
      isDisconnected();
      if (_isSharingLocation()) {
        _streamSubscriptionLocation.cancel();
        _streamSubscriptionLocation = null;
      }
      _stomp.disconnect();
    }

    _stomp = null;
    _webSocket = null;
    _streamSubscriptionLocation = null;
  }

  static void sendLocation([final bool isDriving = true]) {
    isDisconnected();
    if (!isDriving) {
      _streamSubscriptionLocation.cancel();
      _streamSubscriptionLocation = null;
    }

  }

  static void listenLocation(final BuildContext context) {
    isDisconnected();
  }

  static bool isConnected([final bool throwException = true]) {
    if (throwException) {
      if (_webSocket != null && (_stomp != null && !_stomp.isDisconnected)) {
//        throw SocketException('Ja existe uma conexao do socket aberta');
      }
    }

    return _webSocket != null || (_stomp != null && !_stomp.isDisconnected);
  }

  static bool isDisconnected([final bool throwException = true]) {
    if (throwException) {
      if (_webSocket == null && _stomp == null) {
//        throw SocketException('Nenhuma conexao do socket foi iniciada');
      }
    }

    return _webSocket == null && _stomp == null;
  }

  static _handleLocationChanging() {

  }

  static bool _isSharingLocation() {
    return _streamSubscriptionLocation != null;
  }

  static String _buildListeningEventMessage(final int driverId) =>
      '/topic/location/$driverId';
}