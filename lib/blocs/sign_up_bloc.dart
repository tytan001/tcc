import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/cliente.dart';
import 'package:idrink/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

enum SignUpState {IDLE, LOADING, SUCCESS, FAIL}

class SignUpBloc extends BlocBase with SignUpValidators{

  final api = Api();

  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<SignUpState>();

  Stream<String> get outName => _nameController.stream.transform(validadeName);
  Stream<String> get outEmail => _emailController.stream.transform(validadeEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validadePassword);
  Stream<String> get outPhone => _phoneController.stream.transform(validadePhone);
  Stream<SignUpState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest4(
      outName, outEmail, outPassword, outPhone, (a, b, c, d) => true
  );

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;

  SignUpBloc(){
    print("Test");
  }

  void submit() async{
    final name = _nameController.value;
    final email = _emailController.value;
    final password = _passwordController.value;
    final phone = _phoneController.value;

    _stateController.add(SignUpState.LOADING);

    Map<String, dynamic> response = await api.createCliente(Cliente(name: name, email: email, password: password, phone: phone).toMap());

    print(response);
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