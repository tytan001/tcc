import 'package:flutter/material.dart';
import 'package:idrink/blocs/address_bloc.dart';
import 'package:idrink/blocs/delete_address_bloc.dart';
import 'package:idrink/dialogs/dialog_loading.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/services/page_state.dart';

class OptionsAddressDialog extends StatefulWidget {
  final Address address;
  final AddressBloc addressBloc;

  OptionsAddressDialog({this.address, this.addressBloc});

  @override
  _OptionsAddressDialogState createState() => _OptionsAddressDialogState();
}

class _OptionsAddressDialogState extends State<OptionsAddressDialog> {
  DeleteAddressBloc _deleteAddressBloc;

  @override
  void initState() {
    super.initState();
    _deleteAddressBloc = DeleteAddressBloc(widget.address);
    _deleteAddressBloc.outState.listen((state) {
      switch (state) {
        case PageState.SUCCESS:
          widget.addressBloc.allAddress;
          Navigator.pop(context);
          Navigator.pop(context);
          break;
        case PageState.FAIL:
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: StreamBuilder(
                  stream: _deleteAddressBloc.outMessage,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data.toString(),
                      textAlign: TextAlign.center,
                    );
                  }),
            ),
          );
          break;
        case PageState.LOADING:
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => WillPopScope(
              child: LoadingDialog(),
              onWillPop: () => Future.value(false),
            ),
          );
          break;
        case PageState.IDLE:
          break;
        case PageState.AUTHORIZED:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          0.0, MediaQuery.of(context).size.height * 0.60, 0.0, 0.0),
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: Text(
              widget.address.cep,
              style: TextStyle(
                  fontSize: 24.0,
                  color: Theme.of(context).primaryColorDark,
                  decoration: TextDecoration.none),
            ),
          ),
          Container(
            child: Text(
              "${widget.address.complement} Nº${widget.address.number} ${widget.address.neighborhood}",
              style: TextStyle(
                fontSize: 14.0,
                color: Theme.of(context).hoverColor,
                decoration: TextDecoration.none,
              ),
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Text(
              "${widget.address.locality} - ${widget.address.uf}",
              style: TextStyle(
                fontSize: 14.0,
                color: Theme.of(context).hoverColor,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 1.5),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.transparent,
                    onPressed: () => _deleteAddressBloc.delete(),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.delete_forever),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Excluir",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorLight,
                    border: Border.all(
                        color: Theme.of(context).accentColor, width: 1.5),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.transparent,
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.edit),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            "Editar",
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                color: Colors.transparent,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancelar",
                  style: TextStyle(color: Colors.red),
                )),
          ),
        ],
      ),
    );
  }
}
