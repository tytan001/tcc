import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

enum LoginState {IDLE, LOADING, SUCCESS, FAIL}

class LoginBloc extends BlocBase with LoginValidators{

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validadeEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validadePassword);
  Stream<LoginState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
      outEmail, outPassword, (a, b) => true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  LoginBloc(){
    print("Test");
  }

  void submit() async{
    final email = _emailController.value;
    final password = _passwordController.value;

    _stateController.add(LoginState.LOADING);
    
    await Future.delayed(Duration(milliseconds: 1000));

//    _emailController.sink.addError("Test");
//    _passwordController.sink.addError("TestPassword");
    _stateController.add(LoginState.IDLE);
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
  }
}