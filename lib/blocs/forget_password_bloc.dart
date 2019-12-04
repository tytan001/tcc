import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/client.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

class ForgetPasswordBloc extends BlocBase with SignUpValidators {
  final api = Api();

  final _emailController = BehaviorSubject<String>();

  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);

  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;
  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(outEmail, outEmail, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;

  void submit() async {
    _stateController.add(PageState.LOADING);

    try {
      await api.forgetPassword(Client(email: _emailController.value).toMap());
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
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
