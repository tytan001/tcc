import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

class AddressBloc extends BlocBase with SignUpValidators {
  final api = Api();

  List<Address> addresses;

  Map<String, dynamic> response;

  final StreamController<List<Address>> _addressesController =
      BehaviorSubject<List<Address>>();
  final _stateController =
      BehaviorSubject<PageState>(seedValue: PageState.IDLE);
  final _messageController = BehaviorSubject<String>();

  Stream get outAddresses => _addressesController.stream;
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;
  Future<void> get allAddress => _allAddress();

  AddressBloc() {
    _allAddress();
  }

  Future<void> _allAddress() async {
    final token =
        await TokenService.getToken().then((token) => token.tokenEncoded);
    final response = await api.addresses(token);
    addresses = Address.toList(response);
    if (addresses != null) _addressesController.add(addresses);
    addresses = [];
  }

  void searchCep(String cep) async {
    _stateController.add(PageState.LOADING);

    try {
      if (cep != null) {
        response = await api.viaCep(cep);
        _stateController.add(PageState.SUCCESS);
      }
      return null;
    } on ResourceException catch (e) {
      _messageController.add(e.msg);
      _stateController.add(PageState.FAIL);
      return null;
    } catch (e) {
      _messageController.add(e.toString());
      _stateController.add(PageState.FAIL);
      return null;
    }
  }

  @override
  void dispose() {
    _addressesController.close();
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
