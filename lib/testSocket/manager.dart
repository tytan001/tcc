import 'dart:async';

import 'package:flutter/services.dart';
import 'package:idrink/testSocket/socket.dart';
import 'package:idrink/testSocket/options.dart';

class SocketIOManager {
  static const MethodChannel _channel = const MethodChannel('adhara_socket_io');

  Map<int, SocketIO> _sockets = {};

  ///Create a [SocketIO] instance
  ///[options] - Options object to initialize socket instance
  ///returns [SocketIO]
  Future<SocketIO> createInstance(SocketOptions options) async {
    int index = await _channel.invokeMethod('', options.asMap());
    SocketIO socket = SocketIO(index);
    _sockets[index] = socket;
    return socket;
  }

  ///Disconnect a socket instance and remove from stored sockets list
  Future clearInstance(SocketIO socket) async {
    await _channel.invokeMethod('clearInstance', {'id': socket.id});
    _sockets.remove(socket.id);
  }
}
