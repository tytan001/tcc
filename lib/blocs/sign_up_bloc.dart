import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/client.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

enum SignUpState { IDLE, LOADING, SUCCESS, FAIL }

class SignUpBloc extends BlocBase with SignUpValidators {
  final api = Api();

  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<SignUpState>();

  Stream<String> get outName => _nameController.stream.transform(validadeName);
  Stream<String> get outEmail =>
      _emailController.stream.transform(validadeEmail);
  Stream<String> get outPassword =>
      _passwordController.stream.transform(validadePassword);
  Stream<String> get outPhone =>
      _phoneController.stream.transform(validadePhone);
  Stream<SignUpState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest4(
      outName, outEmail, outPassword, outPhone, (a, b, c, d) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;

  void submit() async {
    final name = _nameController.value;
    final email = _emailController.value;
    final password = _passwordController.value;
    final phone = _phoneController.value;

    _stateController.add(SignUpState.LOADING);

    final newClient =
        Client(name: name, email: email, password: password, phone: phone)
            .toMap();

    Map<String, dynamic> response = await api.createClient(newClient);

    await Future.delayed(Duration(milliseconds: 1000));

    if (response != null && response.isNotEmpty) {
      await TokenService.saveToken(response["token"]);
      await ClientService.saveClient(newClient);
      _stateController.add(SignUpState.SUCCESS);
    } else {
      _stateController.add(SignUpState.FAIL);
    }
  }

  @override
  void dispose() {
    _nameController.close();
    _emailController.close();
    _passwordController.close();
    _phoneController.close();
    _stateController.close();
  }
}
