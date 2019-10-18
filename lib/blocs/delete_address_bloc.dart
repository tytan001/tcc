import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/address_validators.dart';
import 'package:rxdart/rxdart.dart';

class DeleteAddressBloc extends BlocBase with AddressValidators {
  final api = Api();

  final _addressController = BehaviorSubject<Address>();
  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;

  DeleteAddressBloc(Address address) {
    _addressController.add(address);
  }

  void delete() async {
    _stateController.add(PageState.LOADING);

    try {
      final token =
          await TokenService.getToken().then((token) => token.tokenEncoded);
      await api.deleteAddresses(token, _addressController.value.id);

      _stateController.add(PageState.SUCCESS);
    } on ResourceException catch (e) {
      _messageController.add(e.msg);
      _stateController.add(PageState.SUCCESS);
    } catch (e) {
      _messageController.add(e.toString());
      _stateController.add(PageState.SUCCESS);
    }
  }

  @override
  void dispose() {
    _addressController.close();
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
