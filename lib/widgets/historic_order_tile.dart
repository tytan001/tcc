import 'package:flutter/material.dart';
import 'package:idrink/blocs/items_historic_order_bloc.dart';
import 'package:idrink/models/dto/item_dto.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'items_historic_order_tile.dart';

class HistoricOrderTile extends StatelessWidget {
  final OrderDTO _order;

  HistoricOrderTile(this._order);

  @override
  Widget build(BuildContext context) {
    ItemHistoricOrderBloc _itemOrderBloc = ItemHistoricOrderBloc(_order);

    return Container(
      child: Card(
        child: ExpansionTile(
          title: Text(
            _order.nameStore,
            style: TextStyle(
                color: Theme.of(context).primaryColorDark,
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
                            return ItemsHistoricOrderTile(i);
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
                            Text(
                              "Total R\$ ${_itemOrderBloc.valorTotal()}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
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
}
