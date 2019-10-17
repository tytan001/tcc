import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:idrink/blocs/address_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/dialogs/dialog_loading.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/widgets/address_tile.dart';
import 'package:idrink/widgets/loading.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final userBloc = BlocProvider.getBloc<UserBloc>();
  final _addressBloc = AddressBloc();
  final _searchController = MaskedTextController(mask: '00000-000');

  @override
  void initState() {
    super.initState();
    _addressBloc.outState.listen((state) {
      switch (state) {
        case PageState.SUCCESS:
          Navigator.pop(context);
          PageService.toPageNewAddress(context, _addressBloc);
          break;
        case PageState.FAIL:
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: StreamBuilder(
                  stream: _addressBloc.outMessage,
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
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Endereço de entrega"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).buttonColor,
                      ),
                      hintText: "Cep: Ex. 99999-999",
                      labelText: "Search",
                      labelStyle: TextStyle(color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Theme.of(context).buttonColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Theme.of(context).buttonColor),
                      ),
                    ),
                    style: TextStyle(fontSize: 18.0),
                    onSubmitted: (text) {
                      if (_searchController.text.isNotEmpty)
                        _addressBloc.searchCep(_searchController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: StreamBuilder<List<Address>>(
                stream: _addressBloc.outAddresses,
                builder: (context, snapshot) {
                  if (snapshot.hasData) if (snapshot.data.length > 0)
                    return Container(
                      color: Theme.of(context).primaryColorLight,
                      child: RefreshIndicator(
                        onRefresh: () => _addressBloc.allAddress,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return AddressTile(snapshot.data[index]);
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
                              color: Theme.of(context).accentColor,
                              fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  else
                    return Loading();
                }),
          )
        ],
      ),
    );
  }
}
