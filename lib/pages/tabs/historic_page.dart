import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/pages/tabs/historic_orders_tab.dart';
import 'package:idrink/pages/tabs/orders_tab.dart';

class HistoricPage extends StatefulWidget {
  @override
  _HistoricPageState createState() => _HistoricPageState();
  final StreamController<bool> _isLoadingStream;

  HistoricPage(this._isLoadingStream);
}

class _HistoricPageState extends State<HistoricPage> {
  List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      OrdersTab(),
      HistoricOrdersTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.content_paste)),
                  Tab(icon: Icon(Icons.list)),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
//          physics: NeverScrollableScrollPhysics(),
            children: _pages,
          ),
        ),
      ),
    );
  }
}
