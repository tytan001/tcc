import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/blocs/login_bloc.dart';
import 'package:idrink/pages/auth/main_auth_page.dart';
import 'package:idrink/widgets/input_field_login.dart';

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

    _loginBloc.outState.listen((state){
      switch(state){
        case LoginState.SUCCESS:
//          Navigator.of(context).pushReplacement(
//              MaterialPageRoute(builder: (context)=>HomeScreen())
//          );
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context)=>
            AlertDialog(
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
      body: StreamBuilder<LoginState>(
        stream: _loginBloc.outState,
        builder: (context, snapshot) {
          if(snapshot.data == LoginState.LOADING){
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(
                    Colors.pinkAccent),),
            );
          } else {
            return Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 60.0,),
                  color: Colors.white,
                  child: ListView(
                    padding: EdgeInsets.all(20.0),
                    children: <Widget>[
                      InputFieldLogin(
                        label: "E-mail",
                        hint: "E-mail",
                        email: true,
                        stream: _loginBloc.outEmail,
                        onChanged: _loginBloc.changeEmail,
                      ),
                      SizedBox(height: 16.0,),
                      InputFieldLogin(
                        label: "Password",
                        hint: "Password",
                        email: false,
                        stream: _loginBloc.outPassword,
                        onChanged: _loginBloc.changePassword,
                      ),
                      SizedBox(height: 16.0,),
                      StreamBuilder<bool>(
                        stream: _loginBloc.outSubmitValid,
                        builder: (context, snapshot) {
                          return SizedBox(
                            height: 44.0,
                            child: RaisedButton(
                              child: Text("Entrar",
                                style: TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                              textColor: Colors.white,
                              color: Theme.of(context).primaryColor,
                              onPressed: snapshot.hasData ? _loginBloc.submit : null,
                              disabledColor: Theme.of(context).primaryColor.withAlpha(140),
                            ),
                          );
                        }
                      ),
                      SizedBox(height: 16.0,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Novo usuario ?"),
                          SizedBox(width: 5.0,),
                          Align(
                            alignment: Alignment.center,
                            child: FlatButton(
                              onPressed: (){
//                                Navigator.of(context).pushReplacement(
//                                MaterialPageRoute(builder: (context)=>SignUpPage()));
                              widget._pageController.animateToPage(MainAuthPage.signUp, duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
                              },
                              child: Text("Cadastrar",
                                textAlign: TextAlign.center,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        }
      ),
    );
  }
}
