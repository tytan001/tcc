import 'package:flutter/material.dart';
import 'package:idrink/blocs/address_bloc.dart';
import 'package:idrink/dialogs/dialog_options_address.dart';
import 'package:idrink/models/address.dart';

class AddressTile extends StatelessWidget {
  final Address address;
  final AddressBloc addressBloc;

  AddressTile({this.address, this.addressBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Theme.of(context).accentColor, width: 1.5),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(12.0, 0.0, 20.0, 0.0),
            child: Center(
              child: Icon(
                Icons.location_on,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        address.cep,
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Text(
                    "${address.publicPlace} ${address.complement} Nº ${address.number}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 13,
                    ),
                    maxLines: 3,
                  ),
                ),
                Container(
                  child: Text(
                    address.neighborhood,
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    "${address.locality} - ${address.uf}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColorDark,
                      fontSize: 13,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          if (addressBloc != null)
            Container(
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).buttonColor,
                ),
                onPressed: () => toDialogOptionsAddress(context),
              ),
            ),
        ],
      ),
    );
  }

  void toDialogOptionsAddress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => OptionsAddressDialog(
        address: address,
        addressBloc: addressBloc,
      ),
    );
  }
}
