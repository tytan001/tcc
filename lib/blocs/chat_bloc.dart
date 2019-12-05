import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/models/dto/message_dto.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/socket/maneger.dart';
import 'package:idrink/socket/socket_io.dart';
import 'package:rxdart/rxdart.dart';
//import 'package:flutter_socket_io/flutter_socket_io.dart';
//import 'package:flutter_socket_io/socket_io_manager.dart';

const String URI = 'http://192.168.1.12:3000';

class ChatBloc extends BlocBase {
  SocketIO _socketIO;
  List<MessageDTO> _messages = [];

  final StreamController<List<MessageDTO>> _messagesController =
      BehaviorSubject<List<MessageDTO>>(seedValue: []);
  final _stateController =
      BehaviorSubject<PageState>(seedValue: PageState.IDLE);
  final _messageAlertController = BehaviorSubject<String>();
  final _newMessageController = BehaviorSubject<bool>();
//  final _statusController = BehaviorSubject<bool>(seedValue: true);

  Stream<List<MessageDTO>> get outMessages => _messagesController.stream;
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessageAlert => _messageAlertController.stream;
  Stream<bool> get outNewMessage => _newMessageController.stream;

  Sink get changeNewMessage => _newMessageController.sink;

  void submit(String message, OrderDTO order, int idUser) {
    if (_socketIO != null) {
      Map<String, dynamic> messageSending = MessageDTO(
              idUser: idUser,
              idStore: order.idStore,
              idOrder: order.id,
              idSend: idUser,
              message: message,
              create: "${DateTime.now().hour}:${DateTime.now().minute}")
          .toMap();
      String jsonData = json.encode(messageSending);
      _socketIO.sendMessage("sendMessage", jsonData, _onReceiveChatMessage);
    }
  }

  void connect(OrderDTO order, int id) {
//  void connect(String url, OrderDTO order, int id) {
    _socketIO = SocketIOManager().createSocketIO(URI, "/");
//        query: "userId=21031", socketStatusCallback: _socketStatus);

    _socketIO.init();

    _listen(order, id);

    _socketIO.connect();
  }

  void disconnect() {
    _destroySocket();
  }

//  _connectSocket() {
//    //update your domain before using
//    _socketIO = SocketIOManager().createSocketIO(URI, "/",
//        query: "userId=21031", socketStatusCallback: _socketStatus);
//
//    //call init socket before doing anything
//    _socketIO.init();
//
//    _listen();
//
//    //connect socket
//    _socketIO.connect();
//  }

  void _listen(OrderDTO order, int id) {
    _socketIO.subscribe("previousMessages", (c) {
      List<MessageDTO> _messagesAux = [];
      _messages = MessageDTO.toList(json.decode(c));
      _messages.forEach((m) {
        if (m.idOrder == order.id) _messagesAux.add(m);
      });
      _messages = _messagesAux;
      _messagesController.add(_messagesAux);
    });

    _socketIO.subscribe("receivedMessage" + order.idStore.toString(), (c) {
      MessageDTO messageDTO = MessageDTO.fromJson(json.decode(c));
      if (messageDTO.idOrder == order.id) {
        _messages.add(messageDTO);
        _messagesController.add(_messages);
        _newMessageController.add(true);
      }
    });

    _socketIO.subscribe("receivedMyMessage" + id.toString(), (c) {
      MessageDTO messageDTO = MessageDTO.fromJson(json.decode(c));
      if (messageDTO.idOrder == order.id) {
        _messages.add(messageDTO);
        _messagesController.add(_messages);
        _newMessageController.add(true);
      }
    });
  }

//  _socketStatus(dynamic data) {
//    data == "connect"
//        ? _statusController.add(true)
//        : _statusController.add(false);
//  }

//  _subscribes() {
//    if (_socketIO != null) {
//      _socketIO.subscribe("chat_direct", _onReceiveChatMessage);
//    }
//  }

  void _onReceiveChatMessage(dynamic message) {
    print("\n\n$message\n\n");
  }

//  void _sendChatMessage(String msg) async {
//    if (_socketIO != null) {
//      String jsonData =
//          '{"message":{"type":"Text","content": ${(msg != null && msg.isNotEmpty) ? '"${msg}"' : '"Hello SOCKET IO PLUGIN :))"'},"owner":"589f10b9bbcd694aa570988d","avatar":"img/avatar-default.png"},"sender":{"userId":"589f10b9bbcd694aa570988d","first":"Ha","last":"Test 2","location":{"lat":10.792273999999999,"long":106.6430356,"accuracy":38,"regionId":null,"vendor":"gps","verticalAccuracy":null},"name":"Ha Test 2"},"receivers":["587e1147744c6260e2d3a4af"],"conversationId":"589f116612aa254aa4fef79f","name":null,"isAnonymous":null}';
//      _socketIO.sendMessage("sendMessage", jsonData, _onReceiveChatMessage);
//    }
//  }

  _destroySocket() {
    if (_socketIO != null) {
//    if (_socketIO != null && _statusController.value) {
      SocketIOManager().destroySocket(_socketIO);
    }
  }

  @override
  void dispose() {
    _messagesController.close();
    _stateController.close();
    _messageAlertController.close();
    _newMessageController.close();
//    _statusController.close();
    _destroySocket();
    super.dispose();
  }
}
