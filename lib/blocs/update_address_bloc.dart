import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/validators/address_validators.dart';
import 'package:rxdart/rxdart.dart';

class UpdateAddressBloc extends BlocBase with AddressValidators {
  final api = Api();

  final _idUserController = BehaviorSubject<int>();
  final _idController = BehaviorSubject<int>();
  final _cepController = BehaviorSubject<String>();
  final _publicPlaceController = BehaviorSubject<String>();
  final _complementController = BehaviorSubject<String>();
  final _neighborhoodController = BehaviorSubject<String>();
  final _localityController = BehaviorSubject<String>();
  final _ufController = BehaviorSubject<String>();
  final _numberController = BehaviorSubject<String>();

  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

  Stream<String> get outCep => _cepController.stream.transform(validateCep);
  Stream<String> get outPublicPlace =>
      _publicPlaceController.stream.transform(validatePublicPlace);
  Stream<String> get outComplement =>
      _complementController.stream.transform(validateComplement);
  Stream<String> get outNeighborhood =>
      _neighborhoodController.stream.transform(validateNeighborhood);
  Stream<String> get outLocality =>
      _localityController.stream.transform(validateLocality);
  Stream<String> get outUf => _ufController.stream.transform(validateUf);
  Stream<String> get outNumber =>
      _numberController.stream.transform(validateNumber);

  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;

  Function(String) get changePublicPlace => _publicPlaceController.sink.add;
  Function(String) get changeComplement => _complementController.sink.add;
  Function(String) get changeNeighborhood => _neighborhoodController.sink.add;
  Function(String) get changeLocality => _localityController.sink.add;
  Function(String) get changeUf => _ufController.sink.add;
  Function(String) get changeNumber => _numberController.sink.add;

  Stream<bool> get outSubmitValid => Observable.combineLatest7(
      outCep,
      outPublicPlace,
      outComplement,
      outNeighborhood,
      outLocality,
      outUf,
      outNumber,
      (a, b, c, d, e, f, g) => true);

  UpdateAddressBloc(Address address, int idUser) {
    _idUserController.add(idUser);
    fromAddress(address);
  }

  void submit() async {
    _stateController.add(PageState.LOADING);

    final idUser = _idUserController.value;
    final cep = _cepController.value;
    final publicPlace = _publicPlaceController.value;
    final complement = _complementController.value;
    final neighborhood = _neighborhoodController.value;
    final locality = _localityController.value;
    final uf = _ufController.value;
    final number = _numberController.value;

    try {
      final token =
          await TokenService.getToken().then((token) => token.tokenEncoded);
      await api.updateAddresses(
          token,
          Address(
                  idUser: idUser,
                  cep: cep,
                  publicPlace: publicPlace,
                  complement: complement,
                  neighborhood: neighborhood,
                  locality: locality,
                  uf: uf,
                  number: number)
              .toMap(),
          _idController.value);

      _stateController.add(PageState.SUCCESS);
    } on ResourceException catch (e) {
      _messageController.add(e.msg);
      _stateController.add(PageState.FAIL);
    } catch (e) {
      _messageController.add(e.toString());
      _stateController.add(PageState.FAIL);
    }
  }

  void fromAddress(Address address) {
    _idController.add(address.id);
    _cepController.add(address.cep);
    _publicPlaceController.add(address.publicPlace);
    _complementController.add(address.complement);
    _neighborhoodController.add(address.neighborhood);
    _localityController.add(address.locality);
    _ufController.add(address.uf);
    _numberController.add(address.number);
  }

  bool change(Address address) {
    if (address.cep == _cepController.value &&
        address.publicPlace == _publicPlaceController.value &&
        address.complement == _complementController.value &&
        address.neighborhood == _neighborhoodController.value &&
        address.locality == _localityController.value &&
        address.uf == _ufController.value &&
        address.number == _numberController.value) return false;
    return true;
  }

  @override
  void dispose() {
    _idUserController.close();
    _idController.close();
    _cepController.close();
    _publicPlaceController.close();
    _complementController.close();
    _neighborhoodController.close();
    _localityController.close();
    _ufController.close();
    _numberController.close();
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
