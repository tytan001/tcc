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

  @override
  Widget build(BuildContext context) {
    ProductsBloc _productsBloc = ProductsBloc(widget.store);

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
                            return GestureDetector(
                              onTap: () {
                                toDialogProduct(snapshot.data[index]);
                              },
                              child: ProductTile(snapshot.data[index]),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "Carrinho",
                                  style: TextStyle(fontSize: 18.0),
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

  void toDialogProduct(final Product product) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProductDialog(store: widget.store, product: product, bloc: bloc),
    );
  }
}
