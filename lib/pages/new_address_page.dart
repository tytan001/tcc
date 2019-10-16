import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/new_address_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/widgets/input_field_password.dart';
import 'package:idrink/widgets/input_field_profile.dart';

class NewAddressPage extends StatefulWidget {
  final Map<String, dynamic> response;

  NewAddressPage({this.response});

  @override
  _NewAddressPageState createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  final userBloc = BlocProvider.getBloc<UserBloc>();

  @override
  Widget build(BuildContext context) {
    final _addressBloc = NewAddressBloc(widget.response, userBloc.idUser);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Cadastrar Endereço de Entrega"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          children: <Widget>[
            SizedBox(
              height: 26.0,
            ),
            InputFieldProfile(
              label: "Cep",
              stream: _addressBloc.outCep,
              onChanged: _addressBloc.changeCep,
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldProfile(
              label: "Logradouro",
              stream: _addressBloc.outPublicPlace,
              onChanged: _addressBloc.changePublicPlace,
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldProfile(
              label: "Complemento",
              stream: _addressBloc.outComplement,
              onChanged: _addressBloc.changeComplement,
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldProfile(
              label: "Bairro",
              stream: _addressBloc.outNeighborhood,
              onChanged: _addressBloc.changeNeighborhood,
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldProfile(
              label: "Cidade",
              stream: _addressBloc.outLocality,
              onChanged: _addressBloc.changeLocality,
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldProfile(
              label: "UF",
              stream: _addressBloc.outUf,
              onChanged: _addressBloc.changeUf,
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldPassword(
              label: "Número",
              stream: _addressBloc.outNumber,
              onChanged: _addressBloc.changeNumber,
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
