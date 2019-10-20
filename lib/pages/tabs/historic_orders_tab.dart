import 'package:flutter/material.dart';

class HistoricOrdersTab extends StatefulWidget {
  @override
  _HistoricOrdersTabState createState() => _HistoricOrdersTabState();
}

class _HistoricOrdersTabState extends State<HistoricOrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: Icon(Icons.list),
          ),
          Text("Historico"),
        ],
      ),
    );
  }
}
