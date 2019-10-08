import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/blocs/item_bloc.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/page_service.dart';

class ProductTile extends StatelessWidget {
  final Product _product;
  final Store _store;

  ProductTile(this._product, this._store);

  @override
  Widget build(BuildContext context) {
//    final bloc = BlocProvider.of<CardBloc>(context);
    final CardBloc bloc = BlocProvider.getBloc<CardBloc>();

    Item item = Item(idProduct: _product.id, quantity: 0);
    ItemBloc itemBloc = ItemBloc(item);

    return GestureDetector(
      onTap: () {
        PageService.toPageProduct(context, _product, _store);
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 1),
                        child: Text(
                          _product.name,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 20),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 1),
                        child: Text(
                          "+ R\$ ${_product.price}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        child: Divider(
                          color: Theme.of(context).primaryColorDark,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
