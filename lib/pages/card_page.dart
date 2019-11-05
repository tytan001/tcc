import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/dialogs/dialog_address.dart';
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
          GestureDetector(
            onTap: () {
              toDialogAddress();
            },
            child: Container(
              color: Theme.of(context).primaryColorLight,
              child: StreamBuilder(
                stream: bloc.outAddress,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? AddressTile(address: snapshot.data)
                      : Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: Center(
                            child: Text(
                              "Endereço de entrega",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColorLight,
            child: SizedBox(
              height: 20.0,
              child: DividerDefault(),
            ),
          ),
          GestureDetector(
            onTap: () {
              toDialogPayment();
            },
            child: Container(
              color: Theme.of(context).primaryColorLight,
              child: StreamBuilder<String>(
                stream: bloc.outPayment,
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: Center(
                            child: Text(
                              snapshot.data == "money"
                                  ? "Dinheiro"
                                  : snapshot.data == "debit"
                                      ? "Cartão de débito"
                                      : snapshot.data == "credit"
                                          ? "Cartão de crédito"
                                          : null,
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 30.0, vertical: 10.0),
                          child: Center(
                            child: Text(
                              "Tipo de pagamento",
                              style: TextStyle(
                                  color: Theme.of(context).accentColor,
                                  fontSize: 24),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColorLight,
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
                      color: Theme.of(context).primaryColorLight,
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            buildItem(context, index, snapshot.data[index]),
                        itemCount: snapshot.data.length,
                        separatorBuilder: (context, index) => DividerDefault(),
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
                            "Comprar",
                            style: TextStyle(fontSize: 18.0),
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
            }),
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
