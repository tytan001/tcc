import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/services/client_service.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
  final api = Api();

  final _idController = BehaviorSubject<int>();
  final _nameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPasswordController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();

  int get idUser => _idController.value;
  String get nameUser => _nameController.value;
  String get emailUser => _emailController.value;
  String get phoneUser => _phoneController.value;

  UserBloc() {
    getUserName();
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
    _passwordController.close();
    _confirmPasswordController.close();
    _phoneController.close();
    super.dispose();
  }
}
