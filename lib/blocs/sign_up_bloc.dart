import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/client.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

class SignUpBloc extends BlocBase with SignUpValidators {
  final api = Api();

  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

  Stream<String> get outName => _nameController.stream.transform(validateName);
  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validatePassword).doOnData((c) {
        if (0 != _confirmPasswordController.value.compareTo(c)) {
          _confirmPasswordController.addError("Sem correspondência!");
        } else {
          _confirmPasswordController.add(_confirmPasswordController.value);
        }
      });
  Stream<String> get outConfirmPassword => _confirmPasswordController.stream
          .transform(validatePassword)
          .doOnData((c) {
        if (0 != _passwordController.value.compareTo(c)) {
          _confirmPasswordController.addError("Sem correspondência!");
        }
      });
  Stream<String> get outPhone =>
      _phoneController.stream.transform(validatePhone);
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest5(
      outName,
      outEmail,
      outPassword,
      outConfirmPassword,
      outPhone,
      (a, b, c, d, e) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeConfirmPassword =>
      _confirmPasswordController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;

  void submit() async {
    _stateController.add(PageState.LOADING);

    final name = _nameController.value;
    final email = _emailController.value;
    final password = _passwordController.value;
    final confirmPassword = _confirmPasswordController.value;
    final phone = _phoneController.value;

//    await Future.delayed(Duration(milliseconds: 10000));

    try {
      Map<String, dynamic> response = await api.createClient(Client(
              name: name,
              email: email,
              password: password,
              confirmPassword: confirmPassword,
              phone: phone)
          .toMap());

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
    _nameController.close();
    _emailController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    _phoneController.close();
    _stateController.close();

    _messageController.close();
    super.dispose();
  }
}
