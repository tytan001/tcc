import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/products_bloc.dart';
import 'package:idrink/models/store.dart';

class ProductPage extends StatefulWidget {
  final Store store;

  ProductPage({this.store});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
//    final _productsBloc = BlocProvider.of<ProductsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.store.name),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, widget.store.name);
        },
        child: Icon(Icons.save),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Text(widget.store.name),
        ),
      ),
    );
  }
}
