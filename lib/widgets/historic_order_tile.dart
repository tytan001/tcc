import 'package:flutter/material.dart';
import 'package:idrink/blocs/items_order_bloc.dart';
import 'package:idrink/models/dto/item_dto.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'package:idrink/widgets/items_order_tile.dart';
import 'package:idrink/widgets/total_price.dart';

class HistoricOrderTile extends StatelessWidget {
  final OrderDTO _order;

  HistoricOrderTile(this._order);

  @override
  Widget build(BuildContext context) {
    ItemOrderBloc _itemOrderBloc = ItemOrderBloc(_order);

    return Container(
      child: Card(
        child: ExpansionTile(
          title: Text(
            _order.nameStore,
            style: TextStyle(
                color: typeHistory(context, _order),
                fontWeight: FontWeight.bold),
          ),
          children: <Widget>[
            StreamBuilder<List<ItemDTO>>(
              stream: _itemOrderBloc.outItems,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Column(
                    children: <Widget>[
                      Container(
                        color: Theme.of(context).primaryColorLight,
                        child: Column(
                          children: snapshot.data.map((i) {
                            return ItemsOrderTile(i);
                          }).toList(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        color: Theme.of(context).primaryColorLight,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TotalPrice(snapshot.data),
                          ],
                        ),
                      )
                    ],
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
          ],
        ),
      ),
    );
  }

  Color typeHistory(BuildContext context, OrderDTO _order) {
    Color cor = Theme.of(context).primaryColorDark;

    if (_order.status == "delivered")
      cor = Colors.green;
    else if (_order.status == "canceled") cor = Colors.redAccent;

    return cor;
  }
}
