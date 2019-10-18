import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/login.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

class LoginBloc extends BlocBase with LoginValidators {
  final api = Api();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController =
      BehaviorSubject<PageState>(seedValue: PageState.LOADING);
  final _messageController = BehaviorSubject<String>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword);
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outEmail, outPassword, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  LoginBloc() {
    hasToken();
  }

  Future<void> hasToken() async {
//    final responseOFF = await api.logout(await TokenService.getToken().then((token) => token.tokenEncoded));
//    TokenService.removeToken();
//    ClientService.removeClient();

    final token = await TokenService.getToken();
    final cliente = await ClientService.getClient();

    (token != null)
        ? _stateController.add(PageState.SUCCESS)
        : _stateController.add(PageState.IDLE);
  }

  void submit() async {
    _stateController.add(PageState.LOADING);

    final email = _emailController.value;
    final password = _passwordController.value;

    try {
      final response =
          await api.login(Login(email: email, password: password).toMap());

      await TokenService.saveToken(response["token"]);
      await ClientService.saveClient(response["0"]);
      _stateController.add(PageState.SUCCESS);
    } on ResourceException catch (e) {
      _stateController.add(PageState.FAIL);
      _messageController.add(e.msg);
    } catch (e) {
      _stateController.add(PageState.FAIL);
      _messageController.add(e.toString());
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
