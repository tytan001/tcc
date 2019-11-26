import 'package:flutter/material.dart';
import 'package:idrink/widgets/received_message.dart';
import 'package:idrink/widgets/send_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
                  "Store name",
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.clip,
                ),
              ],
            )
          ],
        ),
      ),
//      body: Container(
//        child: StreamBuilder(
//            builder: (context, snapshot) {
//              if (snapshot.hasData)
//                return Container(
//                  color: Theme.of(context).primaryColorLight,
//                  child: RefreshIndicator(
//                    onRefresh: (){},
//                    child: ListView.builder(
//                      reverse: true,
//                      itemBuilder: (context, index) {
//                        return Container();
//                      },
//                      itemCount: snapshot.data.length,
//                    ),
//                  ),
//                );
//              else
//                return Container();
//            }),
//      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              reverse: true,
              padding: const EdgeInsets.all(15),
              children: <Widget>[
                ReceivedMessages(),
                SendMessage(),
                ReceivedMessages(),
                SendMessage(),
                ReceivedMessages(),
                ReceivedMessages(),
                SendMessage(),
                SendMessage(),
                ReceivedMessages(),
              ],
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
                            color: Colors.grey)
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 10.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Type Something...",
                                  border: InputBorder.none),
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
                    onLongPress: () {},
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
