import 'package:flutter/material.dart';
import 'package:idrink/blocs/forget_password_bloc.dart';
import 'package:idrink/dialogs/dialog_loading.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/utils/toast_util.dart';
import 'package:idrink/widgets/input_field_no_init.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _forgetBloc = ForgetPasswordBloc();

  @override
  void initState() {
    super.initState();
    _forgetBloc.outState.listen((state) {
      switch (state) {
        case PageState.SUCCESS:
          Navigator.pop(context);
          Navigator.pop(context);
          ToastUtil.showToast("Email enviado.", context,
              color: ToastUtil.success);
          break;
        case PageState.FAIL:
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: StreamBuilder(
                  stream: _forgetBloc.outMessage,
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
        case PageState.UNAUTHORIZED:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text("Esqueci a senha"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40.0, right: 40.0, top: margeTop()),
        child: Column(
          children: <Widget>[
            Container(
              child: Text(
                "Digite o endereço de e-mail de login. Nós lhe enviaremos um e-mail com uma nova senha.",
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            InputFieldNoInit(
              hint: "Email",
              stream: _forgetBloc.outEmail,
              onChanged: _forgetBloc.changeEmail,
            ),
            SizedBox(
              height: heightBox(),
            ),
            StreamBuilder<bool>(
                stream: _forgetBloc.outSubmitValid,
                builder: (context, snapshot) {
                  return SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text(
                        "Enviar",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: snapshot.hasData ? _forgetBloc.submit : null,
                      color: Theme.of(context).buttonColor,
                      disabledColor:
                          Theme.of(context).buttonColor.withAlpha(140),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  double margeTop() {
    return (MediaQuery.of(context).viewInsets.vertical != 0)
        ? MediaQuery.of(context).viewInsets.vertical / 10
        : MediaQuery.of(context).size.height / 6;
  }

  double heightBox() {
    return (MediaQuery.of(context).viewInsets.vertical != 0)
        ? MediaQuery.of(context).viewInsets.vertical / 5
        : MediaQuery.of(context).size.height / 5;
  }
}
