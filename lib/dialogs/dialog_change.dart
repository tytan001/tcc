import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:idrink/blocs/card_bloc.dart';

class ChangeDialog extends StatelessWidget {
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
    final CardBloc bloc = BlocProvider.getBloc<CardBloc>();
    final _textController =
        MoneyMaskedTextController(leftSymbol: 'R\$ ', precision: 2);

    double margeTop() {
      return (MediaQuery.of(context).viewInsets.vertical != 0)
          ? MediaQuery.of(context).viewInsets.vertical / 3
          : MediaQuery.of(context).size.height / 10;
    }

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          margin: EdgeInsets.only(top: margeTop()),
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
                "Troco para:",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
              ),
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  "Qual a quantia em dinheiro que irá ultilizar para pagar?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Theme.of(context).buttonColor,
                          ),
                          hintText: "Ex.: R\$ 99,99",
                          labelStyle: TextStyle(color: Colors.black54),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).buttonColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                color: Theme.of(context).buttonColor),
                          ),
                        ),
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        style: TextStyle(fontSize: 18.0),
                        onSubmitted: (text) {
                          if (_textController.text.isNotEmpty) {
                            bloc.changeChange(
                                _textController.text.replaceAll("R\$ ", ""));
                            Navigator.pop(context);
                          }
                        },
                      ),
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
                        if (_textController.text.isNotEmpty) {
                          bloc.changeChange(
                              _textController.text.replaceAll("R\$ ", ""));
                          Navigator.pop(context);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("Adicionar", style: TextStyle(fontSize: 13.0)),
                        ],
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
//                    Navigator.of(context).pop();
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Cancelar",
                          style: TextStyle(fontSize: 11.0),
                        ),
                      ],
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
}
