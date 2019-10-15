import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/client.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

class UpdatePasswordBloc extends BlocBase with SignUpValidators {
  final api = Api();

  final _idController = BehaviorSubject<int>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();

  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

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

  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;
  Stream<bool> get outSubmitValid => Observable.combineLatest2(
      outPassword, outConfirmPassword, (a, b) => true);

  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeConfirmPassword =>
      _confirmPasswordController.sink.add;

  UpdatePasswordBloc() {
    getUserID();
  }

  void submit() async {
    _stateController.add(PageState.LOADING);

    final token =
        await TokenService.getToken().then((token) => token.tokenEncoded);
    final id = _idController.value;
    final password = _passwordController.value;

    try {
      await api.updateClient(Client(password: password).toMap(), id, token);
      _stateController.add(PageState.SUCCESS);
    } on ResourceException catch (e) {
      _stateController.add(PageState.FAIL);
      _messageController.add(e.msg);
    } catch (e) {
      _stateController.add(PageState.FAIL);
      _messageController.add(e.toString());
    }
  }

  Future<void> getUserID() async {
    final client = await ClientService.getClient();
    _idController.add(client.id);
  }

  @override
  void dispose() {
    _idController.close();
    _passwordController.close();
    _confirmPasswordController.close();
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
