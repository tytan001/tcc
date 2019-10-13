import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/client.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

class UpdateProfileBloc extends BlocBase with SignUpValidators {
  final api = Api();

  final _idController = BehaviorSubject<int>();
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();

  final _stateController = BehaviorSubject<PageState>();

  final _messageController = BehaviorSubject<String>();

  Stream<String> get outName => _nameController.stream.transform(validateName);
  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);
  Stream<String> get outPhone =>
      _phoneController.stream.transform(validatePhone);

  Stream<PageState> get outState => _stateController.stream;

  Stream<String> get outMessage => _messageController.stream;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest3(outName, outEmail, outPhone, (a, b, c) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;

  UpdateProfileBloc() {
    getUserName();
  }

  void submit() async {
    _stateController.add(PageState.LOADING);

    final id = _idController.value;
    final name = _nameController.value;
    final email = _emailController.value;
    final phone = _phoneController.value;

    try {
      Map<String, dynamic> response = await api.updateClient(
          Client(name: name, email: email, phone: phone).toMap(), id);

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

  Future<void> getUserName() async {
    final client = await ClientService.getClient();

    _idController.add(client.id);
    _nameController.add(client.name);
    _emailController.add(client.email);
    _phoneController.add(client.phone);
  }

  @override
  void dispose() {
    _idController.close();
    _nameController.close();
    _emailController.close();
    _phoneController.close();
    _stateController.close();

    _messageController.close();
    super.dispose();
  }
}
