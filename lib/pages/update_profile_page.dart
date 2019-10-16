import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:idrink/blocs/update_profile_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/dialogs/dialog_loading.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/widgets/input_field_mask_profile.dart';
import 'package:idrink/widgets/input_field_profile.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  _UpdateProfilePageState createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  final userBloc = BlocProvider.getBloc<UserBloc>();
  final _updateBloc = UpdateProfileBloc();
  var controllerMaskPhone = MaskedTextController(mask: '(00) 0 0000-0000');

  @override
  void initState() {
    super.initState();
    _updateBloc.outState.listen((state) {
      switch (state) {
        case PageState.SUCCESS:
          userBloc.getUserName();
          Navigator.pop(context);
          Navigator.pop(context);
          break;
        case PageState.FAIL:
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: StreamBuilder(
                  stream: _updateBloc.outMessage,
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
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            title: Text("Editar Perfil"),
            actions: <Widget>[
              StreamBuilder<bool>(
                stream: _updateBloc.outSubmitValid,
                builder: (context, snapshot) {
                  return IconButton(
                    icon: Icon(Icons.save),
                    onPressed: snapshot.hasData &&
                            _updateBloc.change(userBloc.nameUser,
                                userBloc.emailUser, userBloc.phoneUser)
                        ? _updateBloc.submit
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
            ),
          ),
        ),
        onWillPop: _requestPop);
  }

  Future<bool> _requestPop() {
    if (_updateBloc.change(
        userBloc.nameUser, userBloc.emailUser, userBloc.phoneUser)) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações ?"),
              content: Text("Se sair, as alterações seram perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
