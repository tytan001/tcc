import 'package:flutter/material.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/product.dart';

class ProductCardTile extends StatelessWidget {
  final Product _product;
  final Item _item;

  ProductCardTile(this._product, this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 9.0, 10.0, 1.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    "${_item.quantity}x",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 20),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    child: Text(
                      _product.name,
                      style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 20),
                      maxLines: 2,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "R\$ ${(double.parse(_product.price) * _item.quantity).toStringAsFixed(2).replaceAll(".", ",")}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 20),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
