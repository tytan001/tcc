import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/blocs/item_bloc.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/page_state.dart';

class ProductDialog extends StatelessWidget {
  final Store store;
  final Product product;
  final CardBloc bloc;

  ProductDialog(
      {@required this.store, @required this.product, @required this.bloc});

  @override
  Widget build(BuildContext context) {
    ItemBloc _itemBloc = ItemBloc(new Item(idProduct: product.id, quantity: 0));

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context, _itemBloc),
    );
  }

  dialogContent(BuildContext context, ItemBloc itemBloc) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 10),
          decoration: new BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
              ),
              SizedBox(height: 16.0),
              Text(
                "R\$ ${product.price}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        itemBloc.lessOne();
                      },
                      child: Icon(Icons.remove_circle_outline),
                    ),
                    StreamBuilder(
                      stream: itemBloc.outItem,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data.quantity.toString());
                        } else {
                          return Container(
                            color: Theme.of(context).primaryColorLight,
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
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(0.0),
                      onPressed: () {
                        itemBloc.moreOne();
                      },
                      child: Icon(Icons.add_circle),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                      color: Theme.of(context).buttonColor,
                      onPressed: () {
                        if (bloc.addCard(itemBloc.getItem, product, store) &&
                            itemBloc.getItem.quantity != 0) {
                          Navigator.pop(context);
                          PageService.toPageCard(context);
                        } else if (itemBloc.getItem.quantity != 0) {
                          messageError(context, itemBloc);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Adicionar", style: TextStyle(fontSize: 13.0)),
                          StreamBuilder(
                            stream: itemBloc.outItem,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  "R\$ ${(snapshot.data.quantity * double.parse(product.price)).toStringAsFixed(2)}",
                                  style: TextStyle(fontSize: 11.0),
                                );
                              } else {
                                return Container(
                                  color: Theme.of(context).primaryColorLight,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
//                    Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancelar",
                      style: TextStyle(fontSize: 11.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  void messageError(BuildContext context, ItemBloc _itemBloc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Descartar Alterações ?"),
        content: Text(
            "Se adicionar item de outra loja, o carrinho anterior será perdida."),
        actions: <Widget>[
          FlatButton(
            child: Text("Cancelar"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("Sim"),
            onPressed: () {
              Navigator.pop(context);
              bloc.changeState(CardState.CHANGED);
              if (bloc.addCard(_itemBloc.getItem, product, store)) {
                Navigator.pop(context);
                PageService.toPageCard(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
