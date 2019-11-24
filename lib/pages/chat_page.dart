import 'package:flutter/material.dart';
import 'package:idrink/socket/maneger.dart';
import 'package:idrink/socket/socket_io.dart';
//import 'package:flutter_socket_io/flutter_socket_io.dart';
//import 'package:flutter_socket_io/socket_io_manager.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

const String URI = 'http://192.168.1.12:3000';

class _ChatPageState extends State<ChatPage> {
  SocketIO socketIO;
  _connectSocket01() {
    //update your domain before using
    socketIO = SocketIOManager().createSocketIO(URI, "/",
        query: "userId=21031", socketStatusCallback: _socketStatus);

    //call init socket before doing anything
    socketIO.init();

    //subscribe event
    socketIO.subscribe("previousMessages", (c) {
      print("\nokay: previousMessages\n");
      print("\n${c.toString()}\n");
    });

    //subscribe event
    socketIO.subscribe("receivedMessage", (c) {
      print("\nokay: receivedMessage\n");
      print("\n${c.toString()}\n");
    });

    //connect socket
    socketIO.connect();
  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  _subscribes() {
    if (socketIO != null) {
      socketIO.subscribe("chat_direct", _onReceiveChatMessage);
    }
  }

  void _onReceiveChatMessage(dynamic message) {
    print("Message from UFO: " + message);
  }

  void _sendChatMessage(String msg) async {
    if (socketIO != null) {
      String jsonData =
          '{"message":{"type":"Text","content": ${(msg != null && msg.isNotEmpty) ? '"${msg}"' : '"Hello SOCKET IO PLUGIN :))"'},"owner":"589f10b9bbcd694aa570988d","avatar":"img/avatar-default.png"},"sender":{"userId":"589f10b9bbcd694aa570988d","first":"Ha","last":"Test 2","location":{"lat":10.792273999999999,"long":106.6430356,"accuracy":38,"regionId":null,"vendor":"gps","verticalAccuracy":null},"name":"Ha Test 2"},"receivers":["587e1147744c6260e2d3a4af"],"conversationId":"589f116612aa254aa4fef79f","name":null,"isAnonymous":null}';
      socketIO.sendMessage("sendMessage", jsonData, _onReceiveChatMessage);
    }
  }

  _destroySocket() {
    if (socketIO != null) {
      SocketIOManager().destroySocket(socketIO);
    }
  }

  @override
  void initState() {
    super.initState();
    _connectSocket01();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _sendChatMessage("author:Demi,message:Olá mundo!");
      }),
    );
  }
}
