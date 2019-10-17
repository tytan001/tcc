import 'package:flutter/material.dart';
import 'package:idrink/blocs/update_password_bloc.dart';
import 'package:idrink/dialogs/dialog_loading.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/widgets/input_field_no_init.dart';

class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _updateBloc = UpdatePasswordBloc();

  @override
  void initState() {
    super.initState();
    _updateBloc.outState.listen((state) {
      switch (state) {
        case PageState.SUCCESS:
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Alterar senha"),
        actions: <Widget>[
          StreamBuilder<bool>(
            stream: _updateBloc.outSubmitValid,
            builder: (context, snapshot) {
              return IconButton(
                icon: Icon(Icons.save),
                onPressed: snapshot.hasData ? _updateBloc.submit : null,
                color: Theme.of(context).accentColor,
                disabledColor: Theme.of(context).hoverColor,
              );
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top: margeTop()),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 26.0,
            ),
            InputFieldNoInit(
              label: "Nova senha",
              hint: "Nova senha",
              stream: _updateBloc.outPassword,
              onChanged: _updateBloc.changePassword,
              password: true,
            ),
            SizedBox(
              height: 26.0,
            ),
            InputFieldNoInit(
              label: "Confirma nova senha",
              hint: "Confirma nova senha",
              stream: _updateBloc.outConfirmPassword,
              onChanged: _updateBloc.changeConfirmPassword,
              password: true,
            ),
            SizedBox(
              height: 26.0,
            ),
          ],
        ),
      ),
    );
  }

  double margeTop() {
    return (MediaQuery.of(context).viewInsets.vertical != 0)
        ? MediaQuery.of(context).viewInsets.vertical / 10
        : MediaQuery.of(context).size.height / 8;
  }
}
