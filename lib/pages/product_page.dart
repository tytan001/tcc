import 'package:flutter/material.dart';
import 'package:idrink/blocs/item_bloc.dart';
import 'package:idrink/blocs/products_bloc.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/widgets/producttile.dart';

class ProductPage extends StatefulWidget {
  final Store store;
  final Product product;

  ProductPage({this.store, this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    ItemBloc _itemBloc = ItemBloc(new Item(idProduct: widget.product.id));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.product.name),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Text("R\$ ${widget.product.price}"),
          ),
        ));
  }
}
