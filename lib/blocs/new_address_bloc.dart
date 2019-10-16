import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/validators/sign_up_validators.dart';
import 'package:rxdart/rxdart.dart';

class NewAddressBloc extends BlocBase with SignUpValidators {
  final api = Api();

  final _idController = BehaviorSubject<int>();
  final _cepController = BehaviorSubject<String>();
  final _publicPlaceController = BehaviorSubject<String>();
  final _complementController = BehaviorSubject<String>();
  final _neighborhoodController = BehaviorSubject<String>();
  final _localityController = BehaviorSubject<String>();
  final _ufController = BehaviorSubject<String>();
  final _numberController = BehaviorSubject<String>();

  Stream<String> get outCep => _cepController.stream;
  Stream<String> get outPublicPlace => _publicPlaceController.stream;
  Stream<String> get outComplement => _complementController.stream;
  Stream<String> get outNeighborhood => _neighborhoodController.stream;
  Stream<String> get outLocality => _localityController.stream;
  Stream<String> get outUf => _ufController.stream;
  Stream<String> get outNumber => _numberController.stream;

  Function(String) get changeCep => _cepController.sink.add;
  Function(String) get changePublicPlace => _publicPlaceController.sink.add;
  Function(String) get changeComplement => _complementController.sink.add;
  Function(String) get changeNeighborhood => _neighborhoodController.sink.add;
  Function(String) get changeLocality => _localityController.sink.add;
  Function(String) get changeUf => _ufController.sink.add;
  Function(String) get changeNumber => _numberController.sink.add;

  NewAddressBloc(Map<String, dynamic> response, int id) {
    _idController.add(id);
    fromJson(response);
  }

  void fromJson(Map<String, dynamic> response) {
    _cepController.add(response["cep"]);
    _publicPlaceController.add(response["logradouro"]);
    _complementController.add(response["complemento"]);
    _neighborhoodController.add(response["bairro"]);
    _localityController.add(response["localidade"]);
    _ufController.add(response["uf"]);
    _numberController.add(response["0"]);
  }

  @override
  void dispose() {
    _idController.close();
    _cepController.close();
    _publicPlaceController.close();
    _complementController.close();
    _neighborhoodController.close();
    _localityController.close();
    _ufController.close();
    _numberController.close();
    super.dispose();
  }
}
