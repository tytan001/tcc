import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/blocs/orders_bloc.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'package:idrink/widgets/order_tile.dart';

class OrdersTab extends StatefulWidget {
  @override
  _OrdersTabState createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  OrdersBloc _orderBloc = OrdersBloc();

  @override
  void initState() {
    super.initState();

//    Timer.periodic(Duration(seconds: 10), (timer) {
//      _orderBloc.allOrders;
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<OrderDTO>>(
              stream: _orderBloc.outOrders,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Container(
                    color: Theme.of(context).primaryColorLight,
                    child: RefreshIndicator(
                      onRefresh: () => _orderBloc.allOrders,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return OrderTile(snapshot.data[index]);
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
