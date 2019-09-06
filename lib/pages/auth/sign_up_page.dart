import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/blocs/sign_up_bloc.dart';
import 'package:idrink/widgets/input_field_sign_up.dart';

class SignUpPage extends StatefulWidget {
  final PageController _pageController;
  final StreamController<bool> _isLoadingStream;

  SignUpPage(this._pageController, this._isLoadingStream);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final _signUpBloc = SignUpBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<SignUpState>(
        stream: _signUpBloc.outState,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(top: 60.0,),
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                InputFieldSignUp(
                  label: "Name",
                  hint: "Name",
                  email: false,
                  password: false,
                  phone: false,
                  stream: _signUpBloc.outName,
                  onChanged: _signUpBloc.changeName,
                ),
                SizedBox(height: 16.0,),
                InputFieldSignUp(
                  label: "E-mail",
                  hint: "E-mail",
                  email: true,
                  password: false,
                  phone: false,
                  stream: _signUpBloc.outEmail,
                  onChanged: _signUpBloc.changeEmail,
                ),
                SizedBox(height: 16.0,),
                InputFieldSignUp(
                  label: "Password",
                  hint: "Password",
                  email: false,
                  password: true,
                  phone: false,
                  stream: _signUpBloc.outPassword,
                  onChanged: _signUpBloc.changePassword,
                ),
                SizedBox(height: 16.0,),
                InputFieldSignUp(
                  label: "Phone",
                  hint: "Phone",
                  email: false,
                  password: false,
                  phone: true,
                  stream: _signUpBloc.outPhone,
                  onChanged: _signUpBloc.changePhone,
                ),
                SizedBox(height: 16.0,),
                StreamBuilder<bool>(
                  stream: _signUpBloc.outSubmitValid,
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
                        onPressed: snapshot.hasData ? _signUpBloc.submit : null,
                        disabledColor: Theme.of(context).primaryColor.withAlpha(140),
                      ),
                    );
                  }
                )
              ],
            ),
          );
        },
      )
    );
  }
}
