import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

import 'package:idrink/api.dart';
import 'package:idrink/models/loja.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

class StoresBloc implements BlocBase {

  final api = Api();

//  List<Loja> lojas;
  List<Loja> stores;

  final StreamController<List<Loja>> _storesController = BehaviorSubject<List<Loja>>( );
  Stream get outStores => _storesController.stream;

  final StreamController<String> _searchController = BehaviorSubject<String>();
  Sink get inSearch => _searchController.sink;

  StoresBloc(){
    allStores();

    _searchController.stream.listen(_search);
  }

  Future<void> allStores() async {
    print("Entrou aqui _allStores");
    final token = await TokenService.getToken().then((token) => token.tokenEncoded);
    final response = await api.stores(token);

    stores = Loja.toList(response);

    _storesController.sink.add(stores);

  }

  void _search(String search) async {
    final token = await TokenService.getToken().then((token) => token.tokenEncoded);

//    search.isNotEmpty ? stores = await api.lojas(token) : stores = await api.searchLojas(token, search);

    if(search != null){
      print("Entrou aqui if do _search");
      final response = await api.searchStores(token, search);
      stores = Loja.toList(response);

      _storesController.sink.add(stores);
    }


  }

  @override
  void dispose() {
    _storesController.close();
    _searchController.close();
  }

}