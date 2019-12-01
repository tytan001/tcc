import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/dialogs/dialog_product.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';

class ProductTile extends StatelessWidget {
  final Store _store;
  final Product _product;

  ProductTile(this._store, this._product);

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.getBloc<CardBloc>();

    void toDialogProduct(final Product product) {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            ProductDialog(store: _store, product: product, bloc: bloc),
      );
    }

    return FlatButton(
      onPressed:
          _store.situation == "open" ? () => toDialogProduct(_product) : null,
      child: Container(
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
                            fontSize: 20,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 1),
                        child: Text(
                          "+ R\$ ${_product.price.replaceAll(".", ",")}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
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
