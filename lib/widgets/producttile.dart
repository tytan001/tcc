import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/blocs/item_bloc.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/product.dart';

class ProductTile extends StatelessWidget {
  final Product _product;

  ProductTile(this._product);

  @override
  Widget build(BuildContext context) {
//    final bloc = BlocProvider.of<CardBloc>(context);
    final CardBloc bloc = BlocProvider.getBloc<CardBloc>();

    Item item = Item(idProduct: _product.id, quantity: 0);
    ItemBloc itemBloc = ItemBloc(item);

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
                      padding: EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: <Widget>[
                          FlatButton(
                              onPressed: (){
                                itemBloc.lessOne();
                              },
                              child: Icon(Icons.remove_circle_outline)
                          ),
                          Expanded(
                              child: Center(
                                child: StreamBuilder(
                                  stream: itemBloc.outItem,
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData){
                                      return Text(snapshot.data.quantity.toString());
                                    } else{
                                      return Container(
                                        color: Theme.of(context).primaryColor,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation(
                                              Theme.of(context).accentColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )
                              )
                          ),
                          FlatButton(
                              onPressed: (){
                                itemBloc.moreOne();
                                bloc.items.add(itemBloc.valueItem);
                                print(itemBloc.valueItem);

                              },
                              child: Icon(Icons.add_circle)
                          )
                        ],
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
    );
  }
}
