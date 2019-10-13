import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/blocs/item_bloc.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/page_state.dart';

class ProductPage extends StatefulWidget {
  final Store store;
  final Product product;

  ProductPage({this.store, this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CardBloc bloc = BlocProvider.getBloc<CardBloc>();

  @override
  Widget build(BuildContext context) {
    ItemBloc _itemBloc =
        ItemBloc(new Item(idProduct: widget.product.id, quantity: 0));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.product.name),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Center(
                child: Text("R\$ ${widget.product.price}"),
              ),
            ),
          ),
          Container(
            color: Colors.yellow,
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  color: Colors.red,
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          _itemBloc.lessOne();
                        },
                        child: Icon(Icons.remove_circle_outline),
                      ),
                      StreamBuilder(
                        stream: _itemBloc.outItem,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data.quantity.toString());
                          } else {
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
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(0.0),
                        onPressed: () {
                          _itemBloc.moreOne();
                        },
                        child: Icon(Icons.add_circle),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.lightBlueAccent,
                    child: FlatButton(
                      onPressed: () {
                        if (bloc.addCard(
                            _itemBloc.getItem, widget.product, widget.store))
                          PageService.toPageCard(context);
                        else
                          messageError(context, _itemBloc);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(right: 23.0),
                            child: Text(
                              "Adicionar",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                          Container(
                            child: StreamBuilder(
                              stream: _itemBloc.outItem,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    "R\$ ${snapshot.data.quantity * double.parse(widget.product.price)}",
                                    style: TextStyle(fontSize: 15.0),
                                  );
                                } else {
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
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
            },
          ),
          FlatButton(
            child: Text("Sim"),
            onPressed: () {
              Navigator.pop(context);
              bloc.changeState(CardState.CHANGED);
              if (bloc.addCard(_itemBloc.getItem, widget.product, widget.store))
                PageService.toPageCard(context);
            },
          ),
        ],
      ),
    );
  }
}
