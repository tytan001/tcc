import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

import 'package:idrink/api.dart';
import 'package:idrink/models/order.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc extends BlocBase {
  final api = Api();

  List<Order> orders;

  final StreamController<List<Order>> _ordersController =
      BehaviorSubject<List<Order>>();
  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

  Stream get outOrders => _ordersController.stream;
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;
  String get getMessage => _messageController.value;

  Future<void> get allStores => _allOrders();

  OrdersBloc() {
    _allOrders();
  }

  Future<void> _allOrders() async {
    _stateController.add(PageState.LOADING);

    try {
      final token =
          await TokenService.getToken().then((token) => token.tokenEncoded);

      final response = await api.stores(token);
      orders = Order.toList(response);
      _ordersController.sink.add(orders);
      orders = [];
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

  @override
  void dispose() {
    _ordersController.close();
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
