import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

import 'package:idrink/api.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

class StoresBloc extends BlocBase {
  final api = Api();

  List<Store> stores;

  final StreamController<List<Store>> _storesController =
      BehaviorSubject<List<Store>>();
  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

  Stream get outStores => _storesController.stream;
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;
  String get getMessage => _messageController.value;

  final StreamController<String> _searchController = BehaviorSubject<String>();
  Sink get inSearch => _searchController.sink;

  Future<void> get allStores => _allStores();

  StoresBloc() {
    _allStores();

    _searchController.stream.listen(_search);
  }

  Future<void> _allStores() async {
    _stateController.add(PageState.LOADING);

    try {
      final token =
          await TokenService.getToken().then((token) => token.tokenEncoded);

      final response = await api.stores(token);
      stores = Store.toList(response);
      _storesController.sink.add(stores);
      stores = [];
    } on ResourceException catch (e) {
      if (e.code == 401) {
        _messageController.add("Erro de autenticação");
        _stateController.add(PageState.AUTHORIZED);
      }
      _messageController.add(e.msg);
      _stateController.add(PageState.FAIL);
    } catch (e) {
      _messageController.add(e.toString());
      _stateController.add(PageState.FAIL);
    }
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
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
