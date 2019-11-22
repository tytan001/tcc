import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/dialogs/dialog_address.dart';
import 'package:idrink/dialogs/dialog_change.dart';
import 'package:idrink/dialogs/dialog_loading.dart';
import 'package:idrink/dialogs/dialog_payment.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/utils/toast_util.dart';
import 'package:idrink/widgets/address_tile.dart';
import 'package:idrink/widgets/divider.dart';
import 'package:idrink/widgets/produc_card_tile.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  final CardBloc bloc = BlocProvider.getBloc<CardBloc>();
  final UserBloc user = BlocProvider.getBloc<UserBloc>();

  @override
  void initState() {
    super.initState();
    bloc.outState.listen((state) {
      switch (state) {
        case PageState.SUCCESS:
          Navigator.pop(context);
          returnToHome();
          break;
        case PageState.FAIL:
          Navigator.pop(context);
          showDialogError();
          break;
        case PageState.LOADING:
          showDialogLoading();
          break;
        case PageState.IDLE:
          break;
        case PageState.UNAUTHORIZED:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Carrinho"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          if (MediaQuery.of(context).viewInsets.vertical == 0)
            Container(
              margin: EdgeInsets.only(top: 10.0, left: 10.0, bottom: 2.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Entregar em:",
                  style: TextStyle(
                      color: Theme.of(context).primaryColorDark, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (MediaQuery.of(context).viewInsets.vertical == 0)
            GestureDetector(
              onTap: () {
                toDialogAddress();
              },
              child: Container(
                child: StreamBuilder(
                  stream: bloc.outAddress,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? AddressTile(address: snapshot.data)
                        : Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Selecionar endereço",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                  },
                ),
              ),
            ),
          if (MediaQuery.of(context).viewInsets.vertical == 0)
            Container(
              child: SizedBox(
                height: 20.0,
                child: DividerDefault(),
              ),
            ),
          Expanded(
            child: StreamBuilder<List<Product>>(
                stream: bloc.outProducts,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Container(
                      child: ListView.builder(
                        itemBuilder: (context, index) =>
                            buildItem(context, index, snapshot.data[index]),
                        itemCount: snapshot.data.length,
                      ),
                    );
                  else
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
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
          StreamBuilder<String>(
            stream: bloc.outPriceTotal,
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return Container(
                  margin: EdgeInsets.only(right: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Total: R\$ ${bloc.totalPrice.replaceAll(".", ",")}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              else
                return Container();
            },
          ),
          Container(
            child: SizedBox(
              height: 20.0,
              child: DividerDefault(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 50.0),
            child: StreamBuilder<String>(
              stream: bloc.outPayment,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        toDialogPayment();
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            snapshot.data == "money"
                                ? "Dinheiro"
                                : snapshot.data == "debit"
                                    ? "Cartão de débito"
                                    : snapshot.data == "credit"
                                        ? "Cartão de crédito"
                                        : null,
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontSize: 24),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    if (snapshot.data == "money")
                      GestureDetector(
                        onTap: () {
                          toDialogChange();
                        },
                        child: Container(
                          child: StreamBuilder<String>(
                            stream: bloc.outChange,
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? Container(
                                      margin: EdgeInsets.fromLTRB(
                                          12.0, 0.0, 10.0, 20.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Troco para R\$ ${snapshot.data.replaceAll(".", ",")}",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                              fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      )
                  ]);
                } else
                  return GestureDetector(
                    onTap: () {
                      toDialogPayment();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Pagamento",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.all(15.0),
                  color: Theme.of(context).buttonColor,
                  onPressed: () {
                    bloc.inputCompleted()
                        ? bloc.submit(user.idUser)
                        : showDialogError();
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "Finalizar",
                            style: TextStyle(
                              color: Theme.of(context).primaryColorLight,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildItem(context, index, Product product) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete_forever,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: ProductCardTile(product, bloc.getItems[index]),
      onDismissed: (direction) {
        bloc.deleteItemCard(index);
        final snack = SnackBar(
          content: Text("Item removido do carrinho."),
          action: SnackBarAction(
            label: "Desfazer",
            onPressed: () {
              bloc.unDeleteItemCard();
            },
          ),
          duration: Duration(seconds: 2),
        );
        Scaffold.of(context).removeCurrentSnackBar();
        Scaffold.of(context).showSnackBar(snack);
      },
    );
  }

  void showDialogLoading() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        child: LoadingDialog(),
        onWillPop: () => Future.value(false),
      ),
    );
  }

  void toDialogChange() {
    showDialog(
      context: context,
      builder: (BuildContext context) => ChangeDialog(),
    );
  }

  void showDialogError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: StreamBuilder(
          stream: bloc.outMessage,
          builder: (context, snapshot) {
            return Text(
              snapshot.data.toString(),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }

  void toDialogAddress() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddressDialog(),
    );
  }

  void toDialogPayment() {
    showDialog(
      context: context,
      builder: (BuildContext context) => PaymentDialog(),
    );
  }

  void returnToHome() {
    Navigator.pop(context);
    Navigator.pop(context);
    ToastUtil.showToast("Pedido realizado com sucesso!", context,
        color: ToastUtil.success);
  }
}
