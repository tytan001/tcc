import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/order.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

enum CardState { EMPTY, CHANGED, EQUAL, DIFFERENT, FULL }

class CardBloc extends BlocBase {
  final api = Api();

  List<Item> items;
  List<Product> products;

  final _storeController = BehaviorSubject<Store>();
  final _orderController = BehaviorSubject<Order>();
  final _itemsController = BehaviorSubject<List<Item>>(seedValue: []);
  final _productsController = BehaviorSubject<List<Product>>(seedValue: []);
  final _stateController =
      BehaviorSubject<CardState>(seedValue: CardState.EMPTY);

  Stream<List<Product>> get outProducts => _productsController.stream;
  Stream<CardState> get outState => _stateController.stream;

  Store get getStore => _storeController.value;
  List<Item> get getItems => _itemsController.value;

  Function(Store) get addStore => _storeController.sink.add;
  Function(CardState) get changeState => _stateController.sink.add;

  bool addCard(final Item item, final Product product, final Store store) {
    items = _itemsController.value;
    products = _productsController.value;

    if (stateCard(store)) {
      if (items.contains(item) && products.contains(product)) {
        items.forEach((i) =>
            i.idProduct == item.idProduct ? i.quantity += item.quantity : null);
      } else {
        items.add(item);
        products.add(product);
      }

      _itemsController.sink.add(items);
      _productsController.sink.add(products);
      return true;
    } else {
      return false;
    }

//    items.contains(item)?
//    items.forEach((i)=> i.idProduct == item.idProduct? i.quantity += item.quantity: null):
//    items.add(item);
  }

  bool stateCard(final Store store) {
    if (_storeController.value == store) {
      _stateController.sink.add(CardState.EQUAL);
      return true;
    } else if (_stateController.value == CardState.CHANGED) {
      _changed(store);
      return true;
    } else if (_stateController.value == CardState.EMPTY) {
      _stateController.sink.add(CardState.FULL);
      _storeController.sink.add(store);
      return true;
    } else if (_storeController.value != store) {
      _stateController.sink.add(CardState.DIFFERENT);
      return false;
    } else {
      return true;
    }
  }

  void _changed(final Store store) {
    _stateController.sink.add(CardState.FULL);
    _storeController.sink.add(store);
    items = _itemsController.value;
    products = _productsController.value;
    items.clear();
    products.clear();
    _itemsController.sink.add(items);
    _productsController.sink.add(products);
  }

  void submit() async {}

  @override
  void dispose() {
    _storeController.close();
    _orderController.close();
    _itemsController.close();
    _productsController.close();
    _stateController.close();
    super.dispose();
  }
}
