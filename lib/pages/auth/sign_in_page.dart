import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idrink/blocs/login_bloc.dart';
import 'package:idrink/pages/auth/main_auth_page.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/widgets/gradient.dart';
import 'package:idrink/widgets/input_field_sign_up.dart';
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
        case PageState.SUCCESS:
          widget._isLoadingStream.add(true);
          PageService.singIn(context);
          break;
        case PageState.FAIL:
          widget._isLoadingStream.add(false);
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    content: StreamBuilder(
                        stream: _loginBloc.outMessage,
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data.toString(),
                            textAlign: TextAlign.center,
                          );
                        }),
                  ));
          break;
        case PageState.LOADING:
          widget._isLoadingStream.add(true);
          break;
        case PageState.IDLE:
          widget._isLoadingStream.add(false);
          break;
        case PageState.UNAUTHORIZED:
          break;
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
        body: StreamBuilder<PageState>(
            stream: _loginBloc.outState,
            builder: (context, snapshot) {
              return Stack(
                children: <Widget>[
                  GradientBackground(),
                  Container(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        'images/svg/imageSignIn.svg',
                        height: 250.0,
                        width: 250.0,
                      ),
                    ),
                  ),
//                  Container(
//                    padding: EdgeInsets.only(top: 30.0),
//                    width: MediaQuery.of(context).size.width,
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[
//                        SvgPicture.asset(
//                          'images/svg/imageSignIn.svg',
//                          height: 200.0,
//                          width: 200.0,
//                        ),
//                        Container(
//                          child: Text(
//                            "iDrink",
//                            style: TextStyle(
//                              fontSize: 40.0,
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
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
                          margin: EdgeInsets.symmetric(horizontal: 15.0),
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
                                        textColor:
                                            Theme.of(context).primaryColorLight,
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
                                height: 6.0,
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: GestureDetector(
                                    onTap: () =>
                                        PageService.toForgetPassword(context),
                                    child: Text(
                                      "Esqueci a senha",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
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
                        )),
                  ),
                  if (snapshot.data == PageState.SUCCESS ||
                      snapshot.data == PageState.LOADING)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Theme.of(context).primaryColorLight,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            }));
  }

  double margeTop() {
    return (MediaQuery.of(context).viewInsets.vertical != 0)
        ? MediaQuery.of(context).viewInsets.vertical / 3
        : MediaQuery.of(context).size.height / 2.3;
  }
}
