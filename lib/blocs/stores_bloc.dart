import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

import 'package:idrink/api.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

class StoresBloc extends BlocBase {
  final api = Api();

  List<Store> stores;

  final StreamController<List<Store>> _storesController =
      BehaviorSubject<List<Store>>();
  Stream get outStores => _storesController.stream;

  final StreamController<String> _searchController = BehaviorSubject<String>();
  Sink get inSearch => _searchController.sink;

  Future<void> get allStores => _allStores();

  StoresBloc() {
    _allStores();

    _searchController.stream.listen(_search);
  }

  Future<void> _allStores() async {
    final token =
        await TokenService.getToken().then((token) => token.tokenEncoded);

    final response = await api.stores(token);
    stores = Store.toList(response);
    _storesController.sink.add(stores);
    stores = [];
  }

  void _search(String search) async {
    final token =
        await TokenService.getToken().then((token) => token.tokenEncoded);

    if (search != null) {
      final response = await api.searchStores(token, search);
      stores = Store.toList(response);
      _storesController.sink.add(stores);
      stores = [];
    }
  }

  @override
  void dispose() {
    _storesController.close();
    _searchController.close();
    super.dispose();
  }
}
