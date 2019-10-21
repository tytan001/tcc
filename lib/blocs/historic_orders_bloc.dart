import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

import 'package:idrink/api.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

class HistoricOrdersBloc extends BlocBase {
  final api = Api();

  List<OrderDTO> orders;

  final StreamController<List<OrderDTO>> _ordersController =
      BehaviorSubject<List<OrderDTO>>();
  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

  Stream get outOrders => _ordersController.stream;
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;
  String get getMessage => _messageController.value;

  Future<void> get allOrders => _allOrders();

  HistoricOrdersBloc() {
    _allOrders();
  }

  Future<void> _allOrders() async {
    _stateController.add(PageState.LOADING);

    try {
      final token =
          await TokenService.getToken().then((token) => token.tokenEncoded);

      final response = await api.historicOrders(token);
      orders = OrderDTO.toList(response);
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
