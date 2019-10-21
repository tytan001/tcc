import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/blocs/historic_orders_bloc.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'package:idrink/widgets/historic_order_tile.dart';

class HistoricOrdersTab extends StatefulWidget {
  @override
  _HistoricOrdersTabState createState() => _HistoricOrdersTabState();
}

class _HistoricOrdersTabState extends State<HistoricOrdersTab> {
  HistoricOrdersBloc _historicOrderBloc = HistoricOrdersBloc();

//  @override
//  void initState() {
//    super.initState();
//
//    Timer.periodic(Duration(seconds: 10), (timer) {
//      _historicOrderBloc.allOrders;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<OrderDTO>>(
              stream: _historicOrderBloc.outOrders,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Container(
                    color: Theme.of(context).primaryColorLight,
                    child: RefreshIndicator(
                      onRefresh: () => _historicOrderBloc.allOrders,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return HistoricOrderTile(snapshot.data[index]);
                        },
                        itemCount: snapshot.data.length,
                      ),
                    ),
                  );
                else
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).primaryColorLight,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}
