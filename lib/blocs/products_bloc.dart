import 'package:bloc_pattern/bloc_pattern.dart';
import 'dart:async';

import 'package:idrink/api.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/services/token_service.dart';
import 'package:rxdart/rxdart.dart';

class ProductsBloc implements BlocBase {
  final api = Api();

  List<Product> products;

  final StreamController<List<Product>> _productsController =
      BehaviorSubject<List<Product>>();
  Stream get outProducts => _productsController.stream;

  final StreamController<String> _searchController = BehaviorSubject<String>();
  Sink get inSearch => _searchController.sink;

  Future<void> get allStores => _allStores();

  ProductsBloc() {
    _searchController.stream.listen(_search);
  }

  Future<void> _allStores() async {
    final token =
        await TokenService.getToken().then((token) => token.tokenEncoded);
    final response = await api.stores(token);

    products = Product.toList(response);

    _productsController.sink.add(products);
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
  }
}
