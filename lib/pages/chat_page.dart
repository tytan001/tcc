import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/chat_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/models/dto/message_dto.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'package:idrink/widgets/received_message.dart';
import 'package:idrink/widgets/send_message.dart';

class ChatPage extends StatefulWidget {
  final OrderDTO order;

  ChatPage({this.order});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final userBloc = BlocProvider.getBloc<UserBloc>();
  ChatBloc _chatBloc;
  final _textController = TextEditingController();
//  final _urlController = TextEditingController();
  ScrollController controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    _chatBloc = ChatBloc();

    _chatBloc.connect(widget.order, userBloc.idUser);

    _chatBloc.outNewMessage.listen((b) {
      if (b) {
        controller.jumpTo(controller.position.maxScrollExtent + 100.0);
      } else
        _chatBloc.changeNewMessage.add(false);
    });
  }

  @override
  void dispose() {
    _chatBloc.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 15),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.order.nameStore,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.clip,
                ),
              ],
            )
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
//          Container(
//            margin: EdgeInsets.symmetric(vertical: 10.0),
//            child: Row(
//              children: <Widget>[
//                Expanded(
//                  child: TextField(
//                    controller: _urlController,
//                    decoration: InputDecoration(
//                      hintText: "url",
//                      labelText: "url",
//                      labelStyle: TextStyle(color: Colors.black54),
//                      focusedBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(20),
//                        borderSide: BorderSide(
//                          color: Colors.blue,
//                          width: 2,
//                        ),
//                      ),
//                      enabledBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(20),
//                        borderSide: BorderSide(
//                          color: Colors.blue,
//                          width: 2,
//                        ),
//                      ),
//                    ),
//                    style: TextStyle(fontSize: 18.0),
//                    onSubmitted: (text) {
//                      if (_urlController.text != null &&
//                          _urlController.text.isNotEmpty)
//                        _chatBloc.connect(_urlController.text, widget.order, userBloc.idUser);
//                    },
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.symmetric(horizontal: 4.0),
//                  child: RaisedButton(
//                    color: Colors.blue,
//                    child: Text("Connect"),
//                    onPressed: () {
//                      if (_urlController.text != null &&
//                          _urlController.text.isNotEmpty)
//                        _chatBloc.connect(_urlController.text, widget.order, userBloc.idUser);
//                    },
//                    padding: EdgeInsets.symmetric(horizontal: 4.0),
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.symmetric(horizontal: 4.0),
//                  child: RaisedButton(
//                    color: Colors.blue,
//                    child: Text("Disconnect"),
//                    onPressed: () {
//                      _chatBloc.disconnect();
//                    },
//                    padding: EdgeInsets.symmetric(horizontal: 4.0),
//                  ),
//                ),
//              ],
//            ),
//          ),
          Expanded(
            child: StreamBuilder<List<MessageDTO>>(
              stream: _chatBloc.outMessages,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Container(
                    color: Theme.of(context).primaryColorLight,
                    child: ListView.builder(
                      controller: controller,
//                        reverse: true,
                      itemBuilder: (context, index) {
//                            if(snapshot.data[index].idUser == userBloc.idUser){
//                              return SendMessage();
//                            } else if(snapshot.data[index].idStore == userBloc.idUser){
//                              return ReceivedMessages();
//                            }
                        return snapshot.data[index].idSend == userBloc.idUser
                            ? SendMessage(snapshot.data[index])
                            : ReceivedMessages(snapshot.data[index]);
                      },
                      itemCount: snapshot.data.length,
                    ),
                  );
                else
                  return Container();
              },
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            height: 61,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 5,
                          color: Colors.grey,
                        )
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0),
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                hintText: "Type Something...",
                                border: InputBorder.none,
                              ),
                              onSubmitted: (text) {
                                if (text != null && text.isNotEmpty) {
                                  _chatBloc.submit(_textController.text,
                                      widget.order, userBloc.idUser);
                                  _textController.text = "";
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      shape: BoxShape.circle),
                  child: InkWell(
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                    onTap: () {
                      if (_textController.text != null &&
                          _textController.text.isNotEmpty) {
                        _chatBloc.submit(_textController.text, widget.order,
                            userBloc.idUser);
                        _textController.text = "";
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
