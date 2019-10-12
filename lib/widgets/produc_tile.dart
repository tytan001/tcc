import 'package:flutter/material.dart';
import 'package:idrink/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product _product;

  ProductTile(this._product);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        color: Theme.of(context).hoverColor,
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
    );
  }
}
