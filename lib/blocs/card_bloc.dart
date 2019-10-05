import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/order.dart';
import 'package:idrink/models/store.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

class CardBloc extends BlocBase{
  final api = Api();

  Store store;
  Order order;
  List<Item> items = [];

  final _storeController = BehaviorSubject<Store>();
  final _orderController = BehaviorSubject<Order>();
  final _itemsController = BehaviorSubject<List<Item>>();

  Stream<Store> get outEmail =>
      _storeController.stream;
  Stream<Order> get outPassword =>
      _orderController.stream;
  Stream<List<Item>> get outItems => _itemsController.stream;

  void submit() async {
  }

  @override
  void dispose() {
    _storeController.close();
    _orderController.close();
    _itemsController.close();
  }
}
