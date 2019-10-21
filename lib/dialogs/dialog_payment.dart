import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/address_bloc.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/widgets/address_tile.dart';
import 'package:idrink/widgets/loading.dart';

class PaymentDialog extends StatelessWidget {
  final CardBloc bloc = BlocProvider.getBloc<CardBloc>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 4,
          horizontal: MediaQuery.of(context).size.width / 8),
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
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Container(
                child: Text(
                  "Dinheiro",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).buttonColor,
              onPressed: () {
                bloc.changePayment("money");
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 20.0,
            ),
            RaisedButton(
              child: Container(
                child: Text(
                  "Cartão de débito",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).buttonColor,
              onPressed: () {
                bloc.changePayment("debit");
                Navigator.pop(context);
              },
            ),
            Divider(
              height: 20.0,
            ),
            RaisedButton(
              child: Container(
                child: Text(
                  "Cartão de crédito",
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              textColor: Colors.white,
              color: Theme.of(context).buttonColor,
              onPressed: () {
                bloc.changePayment("credit");
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
