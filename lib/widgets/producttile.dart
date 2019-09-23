import 'package:flutter/material.dart';
import 'package:idrink/models/product.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/utils/toast_util.dart';

class ProductTile extends StatelessWidget {
  final Store _store;
  final Product _product;

  ProductTile(this._store, this._product);

  @override
  Widget build(BuildContext context) {
//    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return GestureDetector(
      onTap: () {
        ToastUtil.showToast(
            "Nome da Loja: ${_store.name} \nNome: ${_product.name} \nPreço: ${_product.price}",
            context,
            color: ToastUtil.black);
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 1),
                        child: Text(
                          _product.name,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 20),
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 1),
                        child: Text(
                          "+ R\$ ${_product.price}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 16),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        child: Divider(
                          color: Theme.of(context).primaryColorDark,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                ),
//                StreamBuilder<Map<String, Video>>(
//                  stream: bloc.outFav,
//                  builder: (context, snapshot){
//                    if(snapshot.hasData)
//                      return IconButton(
//                        icon: Icon(snapshot.data.containsKey(video.id) ?
//                        Icons.star : Icons.star_border),
//                        color: Colors.white,
//                        iconSize: 30,
//                        onPressed: (){
//                          bloc.toggleFavorite(video);
//                        },
//                      );
//                    else
//                      return CircularProgressIndicator();
//                  },
//                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
