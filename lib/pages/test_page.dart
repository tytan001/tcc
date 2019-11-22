//import 'package:bloc_pattern/bloc_pattern.dart';
//import 'package:expandable_card/expandable_card.dart';
//import 'package:flutter/material.dart';
//import 'package:idrink/blocs/card_bloc.dart';
//import 'package:idrink/blocs/products_bloc.dart';
//import 'package:idrink/blocs/user_bloc.dart';
//import 'package:idrink/dialogs/dialog_address.dart';
//import 'package:idrink/dialogs/dialog_loading.dart';
//import 'package:idrink/dialogs/dialog_product.dart';
//import 'package:idrink/models/product.dart';
//import 'package:idrink/models/store.dart';
//import 'package:idrink/widgets/address_tile.dart';
//import 'package:idrink/widgets/divider.dart';
//import 'package:idrink/widgets/produc_card_tile.dart';
//import 'package:idrink/widgets/produc_tile.dart';
//
//class TestPage extends StatefulWidget {
//  final Store store;
//
//  TestPage({this.store});
//
//  @override
//  _TestPageState createState() => _TestPageState();
//}
//
//class _TestPageState extends State<TestPage> {
//  final CardBloc bloc = BlocProvider.getBloc<CardBloc>();
//  final UserBloc user = BlocProvider.getBloc<UserBloc>();
//
//  @override
//  Widget build(BuildContext context) {
//    ProductsBloc _productsBloc = ProductsBloc(widget.store);
//    return Scaffold(
//      backgroundColor: Theme.of(context).primaryColorLight,
//      appBar: AppBar(
//        elevation: 1.0,
//        backgroundColor: Theme.of(context).primaryColorLight,
//        title: Text(widget.store.name),
//        centerTitle: true,
//      ),
//      body: StreamBuilder<bool>(
//          stream: bloc.outShowCard,
//          builder: (context, snapshot) {
//            return ExpandableCardPage(
//              page: Column(
//                children: <Widget>[
//                  Expanded(
//                    child: StreamBuilder(
//                        stream: _productsBloc.outProducts,
//                        builder: (context, snapshot) {
//                          if (snapshot.hasData)
//                            return Container(
//                              color: Theme.of(context).primaryColorLight,
//                              child: RefreshIndicator(
//                                onRefresh: () => _productsBloc.allProducts,
//                                child: ListView.separated(
//                                  itemBuilder: (context, index) {
//                                    return GestureDetector(
//                                      onTap: () {
//                                        toDialogProduct(snapshot.data[index]);
//                                      },
//                                      child: ProductTile(snapshot.data[index]),
//                                    );
//                                  },
//                                  itemCount: snapshot.data.length,
//                                  separatorBuilder: (context, index) =>
//                                      DividerDefault(),
//                                ),
//                              ),
//                            );
//                          else
//                            return Container(
//                              width: MediaQuery.of(context).size.width,
//                              height: MediaQuery.of(context).size.height,
//                              color: Theme.of(context).primaryColorLight,
//                              child: Center(
//                                child: CircularProgressIndicator(
//                                  valueColor: AlwaysStoppedAnimation(
//                                    Theme.of(context).accentColor,
//                                  ),
//                                ),
//                              ),
//                            );
//                        }),
//                  ),
//                ],
//              ),
//              expandableCard: ExpandableCard(
//                backgroundColor: Theme.of(context).buttonColor,
//                padding: EdgeInsets.all(0.0),
//                minHeight: snapshot.hasData ? snapshot.data ? 124.0 : 0.0 : 0.0,
//                maxHeight: MediaQuery.of(context).size.height,
//                hasRoundedCorners: true,
//                hasShadow: false,
//                hasHandle: false,
//                children: <Widget>[
//                  Container(height: 40, child: Text("Test")),
//                  Container(
//                    height: MediaQuery.of(context).size.height - 124,
//                    child: Column(
//                      children: <Widget>[
//                        GestureDetector(
//                          onTap: () {
//                            toDialogAddress();
//                          },
//                          child: Container(
//                            color: Theme.of(context).primaryColorLight,
//                            child: StreamBuilder(
//                              stream: bloc.outAddress,
//                              builder: (context, snapshot) {
//                                return snapshot.hasData
//                                    ? AddressTile(address: snapshot.data)
//                                    : Container(
//                                        margin: EdgeInsets.symmetric(
//                                            horizontal: 30.0, vertical: 10.0),
//                                        child: Center(
//                                          child: Text(
//                                            "Endereço de entrega vazio.",
//                                            style: TextStyle(
//                                                color: Theme.of(context)
//                                                    .accentColor,
//                                                fontSize: 24),
//                                            textAlign: TextAlign.center,
//                                          ),
//                                        ),
//                                      );
//                              },
//                            ),
//                          ),
//                        ),
//                        Expanded(
//                          child: StreamBuilder<List<Product>>(
//                              stream: bloc.outProducts,
//                              builder: (context, snapshot) {
//                                if (snapshot.hasData &&
//                                    snapshot.data.length > 0)
//                                  return Container(
//                                    color: Theme.of(context).primaryColorLight,
//                                    child: ListView.separated(
//                                      itemBuilder: (context, index) =>
//                                          buildItem(context, index,
//                                              snapshot.data[index]),
//                                      itemCount: snapshot.data.length,
//                                      separatorBuilder: (context, index) =>
//                                          DividerDefault(),
//                                    ),
//                                  );
//                                if (snapshot.hasData &&
//                                    snapshot.data.length == 0)
//                                  return Container(
//                                    color: Theme.of(context).primaryColorLight,
//                                    child: Center(
//                                      child: Text("Pege um item"),
//                                    ),
//                                  );
//                                else
//                                  return Container(
//                                    width: MediaQuery.of(context).size.width,
//                                    height: MediaQuery.of(context).size.height,
//                                    color: Theme.of(context).primaryColorLight,
//                                    child: Center(
//                                      child: CircularProgressIndicator(
//                                        valueColor: AlwaysStoppedAnimation(
//                                          Theme.of(context).accentColor,
//                                        ),
//                                      ),
//                                    ),
//                                  );
//                              }),
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Expanded(
//                              child: FlatButton(
//                                padding: EdgeInsets.all(15.0),
//                                color: Theme.of(context).buttonColor,
//                                onPressed: () {
//                                  bloc.inputCompleted()
//                                      ? bloc.submit(user.idUser)
//                                      : showDialogError();
//                                },
//                                child: Container(
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Container(
//                                        child: Text(
//                                          "Comprar",
//                                          style: TextStyle(fontSize: 18.0),
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
//                            )
//                          ],
//                        )
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            );
//          }),
//    );
//  }
//
//  Widget buildItem(context, index, Product product) {
//    return Dismissible(
//      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
//      background: Container(
//        color: Colors.red,
//        child: Align(
//          alignment: Alignment(-0.9, 0.0),
//          child: Icon(
//            Icons.delete_forever,
//            color: Colors.white,
//          ),
//        ),
//      ),
//      direction: DismissDirection.startToEnd,
//      child: ProductCardTile(product, bloc.getItems[index]),
//      onDismissed: (direction) {
//        bloc.deleteItemCard(index);
//        final snack = SnackBar(
//          content: Text("Item removido do carrinho."),
//          action: SnackBarAction(
//            label: "Desfazer",
//            onPressed: () {
//              bloc.unDeleteItemCard();
//            },
//          ),
//          duration: Duration(seconds: 2),
//        );
//        Scaffold.of(context).removeCurrentSnackBar();
//        Scaffold.of(context).showSnackBar(snack);
//      },
//    );
//  }
//
//  void showDialogLoading() {
//    showDialog(
//      context: context,
//      barrierDismissible: false,
//      builder: (context) => WillPopScope(
//        child: LoadingDialog(),
//        onWillPop: () => Future.value(false),
//      ),
//    );
//  }
//
//  void showDialogError() {
//    showDialog(
//      context: context,
//      builder: (context) => AlertDialog(
//        content: StreamBuilder(
//            stream: bloc.outMessage,
//            builder: (context, snapshot) {
//              return Text(
//                snapshot.data.toString(),
//                textAlign: TextAlign.center,
//              );
//            }),
//      ),
//    );
//  }
//
//  void toDialogAddress() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) => AddressDialog(),
//    );
//  }
//
//  void toDialogProduct(final Product product) {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) =>
//          ProductDialog(store: widget.store, product: product, bloc: bloc),
//    );
//  }
//}
