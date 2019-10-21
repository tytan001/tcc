import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:idrink/blocs/address_bloc.dart';
import 'package:idrink/blocs/update_address_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/dialogs/dialog_loading.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/widgets/input_field_mask_init_value.dart';
import 'package:idrink/widgets/input_field_init_value.dart';

class UpdateAddressPage extends StatefulWidget {
  final AddressBloc addressBloc;
  final Address address;

  const UpdateAddressPage({this.addressBloc, this.address});

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  final userBloc = BlocProvider.getBloc<UserBloc>();
  UpdateAddressBloc _addressBloc;
  final _maskController = MaskedTextController(mask: '00000-000');

  @override
  void initState() {
    super.initState();
    _addressBloc = UpdateAddressBloc(widget.address, userBloc.idUser);
    _addressBloc.outState.listen((state) {
      switch (state) {
        case PageState.SUCCESS:
          widget.addressBloc.allAddress;
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
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
        case PageState.AUTHORIZED:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Cadastrar Endereço de Entrega"),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: _addressBloc.outSubmitValid,
            builder: (context, snapshot) {
              return IconButton(
                icon: Icon(Icons.save),
                onPressed: _addressBloc.change(widget.address)
                    ? _addressBloc.submit
                    : null,
                color: Theme.of(context).accentColor,
                disabledColor: Theme.of(context).hoverColor,
              );
            },
          )
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(
              height: 26.0,
            ),
            InputFieldMaskInitValue(
              label: "Cep",
              hint: "Cep",
              stream: _addressBloc.outCep,
              controller: _maskController,
              noBorder: true,
              enable: false,
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldInitValue(
              label: "Logradouro",
              hint: "Logradouro",
              stream: _addressBloc.outPublicPlace,
              onChanged: _addressBloc.changePublicPlace,
              noBorder: true,
            ),
            SizedBox(
              height: 26.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 1.75,
                  child: InputFieldInitValue(
                    label: "Complemento",
                    hint: "Complemento",
                    stream: _addressBloc.outComplement,
                    onChanged: _addressBloc.changeComplement,
                    noBorder: true,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 4,
                  child: InputFieldInitValue(
                    label: "Número",
                    hint: "Número",
                    stream: _addressBloc.outNumber,
                    onChanged: _addressBloc.changeNumber,
                    number: true,
                    noBorder: true,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldInitValue(
              label: "Bairro",
              hint: "Bairro",
              stream: _addressBloc.outNeighborhood,
              onChanged: _addressBloc.changeNeighborhood,
              noBorder: true,
            ),
            SizedBox(
              height: 26.0,
            ),
            Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: InputFieldInitValue(
                    label: "Cidade",
                    hint: "Cidade",
                    stream: _addressBloc.outLocality,
                    onChanged: _addressBloc.changeLocality,
                    noBorder: true,
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.5,
                  child: InputFieldInitValue(
                    label: "UF",
                    hint: "UF",
                    stream: _addressBloc.outUf,
                    onChanged: _addressBloc.changeUf,
                    noBorder: true,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 26.0,
            ),
          ],
        ),
      ),
    );
  }
}
