import 'package:flutter/material.dart';
import 'package:idrink/blocs/products_bloc.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/widgets/producttile.dart';

class StorePage extends StatefulWidget {
  final Store store;

  StorePage({this.store});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    ProductsBloc _productsBloc = ProductsBloc(widget.store);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.store.name),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: _productsBloc.outProducts,
          builder: (context, snapshot) {
            if (snapshot.hasData)
              return Container(
                color: Theme.of(context).primaryColor,
                child: RefreshIndicator(
                  onRefresh: () => _productsBloc.allProducts,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          PageService.toPageProduct(
                              context, snapshot.data[index], widget.store);
                        },
                        child: ProductTile(snapshot.data[index]),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                ),
              );
            else
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).accentColor,
                    ),
                  ),
                ),
              );
          }),
    );
  }
}
