import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/order.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

class CardBloc extends BlocBase {
  final api = Api();

//  Store store;
//  Order order;
  List<Item> items;
  List<Product> products;

  final _storeController = BehaviorSubject<Store>();
  final _orderController = BehaviorSubject<Order>();
  final _itemsController = BehaviorSubject<List<Item>>(seedValue: []);
  final _productsController = BehaviorSubject<List<Product>>(seedValue: []);

  Stream<Store> get outEmail => _storeController.stream;
  Stream<Order> get outPassword => _orderController.stream;
//  Stream<List<Item>> get outItems => _itemsController.stream;
  Stream<List<Product>> get outProducts => _productsController.stream;

  Store get getStore => _storeController.value;

  Function(Store) get addStore => _storeController.sink.add;

  void addCard(final Item item, final Product product, final Store store) {
    items = _itemsController.value;
    products = _productsController.value;

    if (items.contains(item) && products.contains(product)) {
      items.forEach((i) =>
          i.idProduct == item.idProduct ? i.quantity += item.quantity : null);
    } else {
      items.add(item);
      products.add(product);
    }

//    items.contains(item)?
//    items.forEach((i)=> i.idProduct == item.idProduct? i.quantity += item.quantity: null):
//    items.add(item);

    _storeController.sink.add(store);
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
    super.dispose();
  }
}
