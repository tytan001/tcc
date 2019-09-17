import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/blocs/login_bloc.dart';
import 'package:idrink/pages/auth/main_auth_page.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/widgets/input_field.dart';
import 'package:idrink/widgets/ou_divider.dart';

class SignInPage extends StatefulWidget {
  final PageController _pageController;
  final StreamController<bool> _isLoadingStream;

  SignInPage(this._pageController, this._isLoadingStream);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCCESS:
          PageService.singIn(context);
          break;
        case LoginState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content: Text("Você não possui os privilégios necessários"),
                  ));
          break;
        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<LoginState>(
          stream: _loginBloc.outState,
          builder: (context, snapshot) {
            if (snapshot.data == LoginState.LOADING ||
                snapshot.data == LoginState.SUCCESS) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).accentColor,
                  ),
                ),
              );
            } else {
              return Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      // Box decoration takes a gradient
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.1, 0.5, 0.7, 0.9],
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          Colors.red[800],
                          Colors.orange[700],
                          Colors.orangeAccent[400],
                          Colors.yellow,
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                          margin: EdgeInsets.only(
                              top: margeTop(),
                              bottom: MediaQuery.of(context).viewInsets.bottom +
                                  MediaQuery.of(context).size.height / 14),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                            child: ListView(
                              children: <Widget>[
                                InputField(
                                  label: "E-mail",
                                  hint: "E-mail",
                                  email: true,
                                  stream: _loginBloc.outEmail,
                                  onChanged: _loginBloc.changeEmail,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                InputField(
                                  label: "Password",
                                  hint: "Password",
                                  password: true,
                                  stream: _loginBloc.outPassword,
                                  onChanged: _loginBloc.changePassword,
                                ),
                                SizedBox(
                                  height: 16.0,
                                ),
                                StreamBuilder<bool>(
                                    stream: _loginBloc.outSubmitValid,
                                    builder: (context, snapshot) {
                                      return SizedBox(
                                        height: 44.0,
                                        child: RaisedButton(
                                          child: Text(
                                            "Entrar",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          textColor: Colors.white,
                                          color: Theme.of(context).buttonColor,
                                          onPressed: snapshot.hasData
                                              ? _loginBloc.submit
                                              : null,
                                          disabledColor: Theme.of(context)
                                              .buttonColor
                                              .withAlpha(140),
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 16.0,
                                ),
                                OuDivider(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Novo usuario ?"),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: FlatButton(
                                        onPressed: () {
//                                Navigator.of(context).pushReplacement(
//                                MaterialPageRoute(builder: (context)=>SignUpPage()));
                                          widget._pageController.animateToPage(
                                              MainAuthPage.signUp,
                                              duration:
                                                  Duration(milliseconds: 500),
                                              curve: Curves.fastOutSlowIn);
                                        },
                                        child: Text(
                                          "Cadastrar",
                                          textAlign: TextAlign.center,
                                        ),
                                        padding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )))
                ],
              );
            }
          }),
    );
  }

  double margeTop() {
    return (MediaQuery.of(context).viewInsets.vertical != 0)
        ? MediaQuery.of(context).viewInsets.vertical / 3
        : MediaQuery.of(context).size.height / 2.2;
  }
}
