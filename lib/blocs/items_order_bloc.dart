import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/models/dto/item_dto.dart';
import 'package:idrink/models/dto/order_dto.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

import '../api.dart';

class ItemBloc extends BlocBase {
  final api = Api();

  OrderDTO _orderDTO;
  List<ItemDTO> _items;

  final _itemsController = BehaviorSubject<List<ItemDTO>>();
  final _stateController = BehaviorSubject<PageState>();
  final _messageController = BehaviorSubject<String>();

  Stream<List<ItemDTO>> get outItems => _itemsController.stream;
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;
  String get getMessage => _messageController.value;

  ItemBloc(this._orderDTO) {
    _allItems();
  }

  Future<void> _allItems() async {
    final token =
        await TokenService.getToken().then((token) => token.tokenEncoded);
    final response = await api.itemsOrder(token, _orderDTO.id);

    _items = ItemDTO.toList(response);
    _itemsController.sink.add(_items);
    _items = [];
  }

  @override
  void dispose() {
    _itemsController.close();
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
