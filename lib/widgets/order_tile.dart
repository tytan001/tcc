import 'package:flutter/material.dart';
import 'package:idrink/blocs/items_order_bloc.dart';
import 'package:idrink/models/dto/item_dto.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/widgets/total_price.dart';
import 'items_order_tile.dart';

class OrderTile extends StatelessWidget {
  final OrderDTO _order;

  OrderTile(this._order);

  @override
  Widget build(BuildContext context) {
    ItemOrderBloc _itemOrderBloc = ItemOrderBloc(_order);

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
                            return ItemsOrderTile(i);
                          }).toList(),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        color: Theme.of(context).primaryColorLight,
                        margin: EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RaisedButton(
                              child: Text(
                                "Chat",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              textColor: Colors.white,
                              color: Theme.of(context).buttonColor,
                              onPressed: () => PageService.toPageChat(context),
                            ),
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
}
