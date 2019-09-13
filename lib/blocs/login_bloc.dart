import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/login.dart';
import 'package:idrink/models/token.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

enum LoginState {IDLE, LOADING, SUCCESS, FAIL}

class LoginBloc extends BlocBase with LoginValidators{

  final api = Api();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>(seedValue: LoginState.LOADING);

  Stream<String> get outEmail => _emailController.stream.transform(validadeEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validadePassword);
  Stream<LoginState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
      outEmail, outPassword, (a, b) => true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  LoginBloc(){
    hasToken();
  }

  Future<void> hasToken() async{
    final token = await TokenService.getToken();
    (token != null) ? _stateController.add(LoginState.SUCCESS) : _stateController.add(LoginState.IDLE);
  }

  void submit() async{
    final email = _emailController.value;
    final password = _passwordController.value;

    _stateController.add(LoginState.LOADING);

    final response = await api.login(Login(email: email, password: password).toMap());

    response.isNotEmpty ? _stateController.add(LoginState.SUCCESS) : _stateController.add(LoginState.FAIL);
    await TokenService.saveUser(response["token"]);

    await Future.delayed(Duration(milliseconds: 1000));

    final responseOFF = await api.logout(await TokenService.getToken().then((token) => token.tokenEncoded));
    TokenService.removeToken();

    print(response.toString());
    print(responseOFF.toString());

  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
  }
}