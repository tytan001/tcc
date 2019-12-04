import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/blocs/products_bloc.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/dialogs/dialog_product.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/widgets/divider.dart';
import 'package:idrink/widgets/produc_tile.dart';

class StorePage extends StatefulWidget {
  final Store store;

  StorePage({this.store});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final CardBloc bloc = BlocProvider.getBloc<CardBloc>();
  ProductsBloc _productsBloc;

  @override
  void initState() {
    super.initState();

    _productsBloc = ProductsBloc(widget.store);

//    Timer.periodic(Duration(seconds: 10), (timer) {
//      _productsBloc.allProducts;
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text(widget.store.name),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
                stream: _productsBloc.outProducts,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Container(
                      color: Theme.of(context).primaryColorLight,
                      child: RefreshIndicator(
                        onRefresh: () => _productsBloc.allProducts,
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return Container(
                              child: ProductTile(
                                  widget.store, snapshot.data[index]),
                            );
                          },
                          itemCount: snapshot.data.length,
                          separatorBuilder: (context, index) =>
                              DividerDefault(),
                        ),
                      ),
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
                }),
          ),
          StreamBuilder<bool>(
            stream: bloc.outShowCard,
            builder: (context, snapshot) {
              if (snapshot.hasData) if (snapshot.data)
                return Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.all(15.0),
                        color: Theme.of(context).buttonColor,
                        onPressed: () => PageService.toPageCard(context),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: StreamBuilder<List<Product>>(
                                    stream: bloc.outProducts,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData)
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Text(
                                            "${snapshot.data.length}",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              fontSize: 18,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      else
                                        return Container();
                                    }),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 35.0),
                                child: Text(
                                  "Carrinho",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      fontSize: 16.0),
                                ),
                              ),
                              Container(
                                child: StreamBuilder<String>(
                                  stream: bloc.outPriceTotal,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData)
                                      return Container(
                                        child: Text(
                                          "R\$ ${bloc.totalPrice.replaceAll(".", ",")}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorLight,
                                              fontSize: 18),
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    else
                                      return Container();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              return Container();
            },
          )
        ],
      ),
    );
  }
}
