import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

import 'package:idrink/api.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc extends BlocBase {
  final api = Api();
  final Store store;

  List<Product> products;

  final StreamController<List<Product>> _productsController =
      BehaviorSubject<List<Product>>();
  Stream get outProducts => _productsController.stream;

  final StreamController<String> _searchController = BehaviorSubject<String>();
  Sink get inSearch => _searchController.sink;

  Future<void> get allProducts => _allProducts();

  ProductsBloc(this.store) {
    _allProducts();

    _searchController.stream.listen(_search);
  }

  Future<void> _allProducts() async {
    final token =
        await TokenService.getToken().then((token) => token.tokenEncoded);
    final response = await api.products(token, store.id);

    if(response != null) {
      products = Product.toList(response);
    } else {
      products = [];
    }
    _productsController.sink.add(products);
    products = [];
  }

  void _search(String search) async {
    final token =
        await TokenService.getToken().then((token) => token.tokenEncoded);

    if (search != null) {
      final response = await api.searchStores(token, search);
      products = Product.toList(response);

      _productsController.sink.add(products);
    }
  }

  @override
  void dispose() {
    _productsController.close();
    _searchController.close();
    super.dispose();
  }
}
