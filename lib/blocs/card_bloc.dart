import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/api.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/order.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

class CardBloc extends BlocBase {
  final api = Api();

  List<Item> items;
  List<Product> products;

  Item _auxItem;
  Product _auxProduct;

  final _storeController = BehaviorSubject<Store>();
  final _orderController = BehaviorSubject<Order>();
  final _addressController = BehaviorSubject<Address>();
  final _itemsController = BehaviorSubject<List<Item>>(seedValue: []);
  final _productsController = BehaviorSubject<List<Product>>(seedValue: []);
  final _stateCardController =
      BehaviorSubject<CardState>(seedValue: CardState.EMPTY);
  final _stateController =
      BehaviorSubject<PageState>(seedValue: PageState.IDLE);
  final _messageController = BehaviorSubject<String>();

  Stream<List<Product>> get outProducts => _productsController.stream;
  Stream<Address> get outAddress => _addressController.stream;
  Stream<CardState> get outCardState => _stateCardController.stream;
  Stream<PageState> get outState => _stateController.stream;
  Stream<String> get outMessage => _messageController.stream;

  Store get getStore => _storeController.value;
  List<Item> get getItems => _itemsController.value;

  Function(Store) get addStore => _storeController.sink.add;
  Function(Address) get addAddress => _addressController.sink.add;
  Function(CardState) get changeState => _stateCardController.sink.add;

  void updateLists() {
    _itemsController.sink.add(items);
    _productsController.sink.add(products);
    items = [];
    products = [];
  }

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
      updateLists();
      return true;
    } else {
      return false;
    }
  }

  bool stateCard(final Store store) {
    if (_storeController.value == store) {
      _stateCardController.sink.add(CardState.EQUAL);
      return true;
    } else if (_stateCardController.value == CardState.CHANGED) {
      _changedStore(store);
      return true;
    } else if (_stateCardController.value == CardState.EMPTY) {
      _stateCardController.sink.add(CardState.FULL);
      _storeController.sink.add(store);
      return true;
    } else if (_storeController.value != store) {
      _stateCardController.sink.add(CardState.DIFFERENT);
      return false;
    } else {
      return true;
    }
  }

  void _changedStore(final Store store) {
    _stateCardController.sink.add(CardState.FULL);
    _storeController.sink.add(store);
    items = _itemsController.value..clear();
    products = _productsController.value..clear();
    updateLists();
  }

  void deleteItemCard(final int index) {
    items = _itemsController.value;
    products = _productsController.value;
    _auxItem = items[index];
    _auxProduct = products[index];
    items.removeAt(index);
    products.removeAt(index);
    updateLists();
  }

  void unDeleteItemCard() {
    items = _itemsController.value..add(_auxItem);
    products = _productsController.value..add(_auxProduct);
    _auxItem = null;
    _auxProduct = null;
    updateLists();
  }

  void submit(int idUser) async {
    _stateController.add(PageState.LOADING);

    try {
      inputCompleted();

      final token =
          await TokenService.getToken().then((token) => token.tokenEncoded);

      Map<String, dynamic> response = await api.createOrder(
          token,
          Order(
                  idAddress: _addressController.value.id,
                  idClient: idUser,
                  idStore: _storeController.value.id)
              .toMap());

      _orderController.add(Order.fromJson(response));
      _itemsController.value.forEach((i) async {
        i.idOrder = _orderController.value.id;
        await api.createItems(token, i.toMap());
      });

      _stateController.add(PageState.SUCCESS);
      success();
    } on ResourceException catch (e) {
      _messageController.add(e.msg);
      _stateController.add(PageState.FAIL);
    } catch (e) {
      _messageController.add(e.toString());
      _stateController.add(PageState.FAIL);
    } finally {
      _stateController.add(PageState.IDLE);
    }
  }

  bool inputCompleted() {
    if (_addressController.value == null) {
      _messageController.add("Campo de endereço deve esta preenchido!");
      return false;
    }
    return true;
  }

  void success() {
    _storeController.add(null);
    _orderController.add(null);
    _addressController.add(null);
    _itemsController.add([]);
    _productsController.add([]);
    _stateCardController.add(CardState.EMPTY);
    _messageController.add(null);
  }

  @override
  void dispose() {
    _storeController.close();
    _orderController.close();
    _addressController.close();
    _itemsController.close();
    _productsController.close();
    _stateCardController.close();
    _stateController.close();
    _messageController.close();
    super.dispose();
  }
}
