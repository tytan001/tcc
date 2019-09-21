import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:idrink/blocs/sign_up_bloc.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/widgets/gradient.dart';
import 'package:idrink/widgets/input_field.dart';
import 'package:idrink/widgets/input_field_mask.dart';

class SignUpPage extends StatefulWidget {
  final PageController _pageController;
  final StreamController<bool> _isLoadingStream;

  SignUpPage(this._pageController, this._isLoadingStream);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpBloc = SignUpBloc();

  var controllerMaskPhone = MaskedTextController(mask: '(00) 0 0000-0000');

  @override
  void initState() {
    super.initState();

    _signUpBloc.outState.listen((state) {
      switch (state) {
        case SignUpState.SUCCESS:
          widget._isLoadingStream.add(true);
          PageService.singIn(context);
          break;
        case SignUpState.FAIL:
          widget._isLoadingStream.add(false);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Err"),
                    content: StreamBuilder(
                        stream: _signUpBloc.outMessage,
                        builder: (context, snapshot) {
                          return Text(snapshot.data.toString());
                        }),
                  ));
          break;
        case SignUpState.LOADING:
          widget._isLoadingStream.add(true);
          break;
        case SignUpState.IDLE:
          widget._isLoadingStream.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<SignUpState>(
            stream: _signUpBloc.outState,
            builder: (context, snapshot) {
              return Stack(children: <Widget>[
                GradientBackground(),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                        margin: EdgeInsets.only(
                            top: margeTop(),
                            bottom: MediaQuery.of(context).viewInsets.bottom +
                                MediaQuery.of(context).size.height / 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListView(
                            padding: EdgeInsets.all(20.0),
                            children: <Widget>[
                              InputField(
                                label: "Name",
                                hint: "Name",
                                stream: _signUpBloc.outName,
                                onChanged: _signUpBloc.changeName,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              InputField(
                                label: "E-mail",
                                hint: "E-mail",
                                email: true,
                                stream: _signUpBloc.outEmail,
                                onChanged: _signUpBloc.changeEmail,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              InputField(
                                label: "Password",
                                hint: "Password",
                                password: true,
                                stream: _signUpBloc.outPassword,
                                onChanged: _signUpBloc.changePassword,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              InputField(
                                label: "Confirm Password",
                                hint: "Confirm Password",
                                password: true,
                                stream: _signUpBloc.outConfirmPassword,
                                onChanged: _signUpBloc.changeConfirmPassword,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              InputFieldMask(
                                label: "Phone",
                                hint: "Phone",
                                phone: true,
                                stream: _signUpBloc.outPhone,
                                onChanged: _signUpBloc.changePhone,
                                controller: controllerMaskPhone,
                              ),
                              SizedBox(
                                height: 16.0,
                              ),
                              StreamBuilder<bool>(
                                  stream: _signUpBloc.outSubmitValid,
                                  builder: (context, snapshot) {
                                    return SizedBox(
                                      height: 44.0,
                                      child: RaisedButton(
                                        child: Text(
                                          "Cadastrar",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                          ),
                                        ),
                                        textColor: Colors.white,
                                        color: Theme.of(context).buttonColor,
                                        onPressed: snapshot.hasData
                                            ? _signUpBloc.submit
                                            : null,
                                        disabledColor: Theme.of(context)
                                            .buttonColor
                                            .withAlpha(140),
                                      ),
                                    );
                                  })
                            ],
                          ),
                        ))),
                if (snapshot.data == SignUpState.SUCCESS ||
                    snapshot.data == SignUpState.LOADING)
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Theme.of(context).primaryColor,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ),
              ]);
            }));
  }

  double margeTop() {
    return MediaQuery.of(context).viewInsets.vertical != 0
        ? MediaQuery.of(context).viewInsets.vertical / 10
        : MediaQuery.of(context).size.height / 3.3;
  }
}
