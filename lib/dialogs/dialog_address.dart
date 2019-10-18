import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/address_bloc.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/widgets/address_tile.dart';
import 'package:idrink/widgets/loading.dart';

class AddressDialog extends StatelessWidget {
  final CardBloc bloc = BlocProvider.getBloc<CardBloc>();
  final _addressBloc = AddressBloc();

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
          vertical: MediaQuery.of(context).size.height / 6),
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
      child: StreamBuilder<List<Address>>(
        stream: _addressBloc.outAddresses,
        builder: (context, snapshot) {
          if (snapshot.hasData) if (snapshot.data.length > 0)
            return Container(
              child: RefreshIndicator(
                onRefresh: () => _addressBloc.allAddress,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        bloc.addAddress(snapshot.data[index]);
                        Navigator.pop(context);
                      },
                      child: AddressTile(
                        address: snapshot.data[index],
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                ),
              ),
            );
          else
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 30.0),
              child: Center(
                child: Text(
                  "Você não possui endereços cadastrado",
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          else
            return Loading();
        },
      ),
    );
  }
}
