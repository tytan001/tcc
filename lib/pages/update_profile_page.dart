import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:idrink/blocs/update_profile_bloc.dart';
import 'package:idrink/widgets/input_field_mask_profile.dart';
import 'package:idrink/widgets/input_field_profile.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final _updateBloc = UpdateProfileBloc();

  var controllerMaskPhone = MaskedTextController(mask: '(00) 0 0000-0000');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Editar Perfil"),
      ),
      body: Container(
          child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        children: <Widget>[
          SizedBox(
            height: 26.0,
          ),
          InputFieldProfile(
            label: "Nome",
            stream: _updateBloc.outName,
            onChanged: _updateBloc.changeName,
          ),
          SizedBox(
            height: 26.0,
          ),
          InputFieldProfile(
            label: "Email",
            stream: _updateBloc.outEmail,
            onChanged: _updateBloc.changeEmail,
          ),
          SizedBox(
            height: 26.0,
          ),
          InputFieldMaskProfile(
            label: "Phone",
            stream: _updateBloc.outPhone,
            onChanged: _updateBloc.changePhone,
            phone: true,
            controller: controllerMaskPhone,
          ),
        ],
      )),
    );
  }
}
