import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:idrink/blocs/address_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/dialogs/dialog_loading.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/utils/toast_util.dart';
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
          showDialogError();
          break;
        case PageState.LOADING:
          showDialogLoading();
          break;
        case PageState.IDLE:
          break;
        case PageState.UNAUTHORIZED:
          ToastUtil.showToast(_addressBloc.getMessage, context,
              color: ToastUtil.error);
          PageService.singOut(context);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Endereços"),
        elevation: 1.5,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColorLight,
            child: SizedBox(
              height: 20.0,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Container(
            color: Theme.of(context).primaryColorLight,
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
                        color: Theme.of(context).accentColor,
                      ),
                      hintText: "Cep: Ex. 99999-999",
                      labelText: "CEP",
                      labelStyle: TextStyle(color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                          width: 2,
                        ),
                      ),
                    ),
                    style: TextStyle(fontSize: 18.0),
                    onSubmitted: (text) {
                      if (_searchController.text.isNotEmpty)
                        _addressBloc.searchCep(_searchController.text);
                      _searchController.text = "";
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Theme.of(context).primaryColorLight,
            child: SizedBox(
              height: 20.0,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).primaryColorLight,
              child: StreamBuilder<List<Address>>(
                stream: _addressBloc.outAddresses,
                builder: (context, snapshot) {
                  if (snapshot.hasData) if (snapshot.data.length > 0)
                    return Container(
                      child: RefreshIndicator(
                        onRefresh: () => _addressBloc.allAddress,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return AddressTile(
                              address: snapshot.data[index],
                              addressBloc: _addressBloc,
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
                              color: Theme.of(context).accentColor,
                              fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  else
                    return Loading();
                },
              ),
            ),
          ),
        ],
      ),
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
  }
}
