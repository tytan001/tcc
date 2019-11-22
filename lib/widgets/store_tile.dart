import 'package:flutter/material.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/page_service.dart';

class StoreTile extends StatelessWidget {
  final Store _store;

  StoreTile(this._store);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        PageService.toPageStore(context, _store);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15),
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
                          _store.name,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 20),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                ////                StreamBuilder<Map<String, Video>>(
////                  stream: bloc.outFav,
////                  builder: (context, snapshot){
////                    if(snapshot.hasData)
////                      return IconButton(
////                        icon: Icon(snapshot.data.containsKey(video.id) ?
////                        Icons.star : Icons.star_border),
////                        color: Colors.white,
////                        iconSize: 30,
////                        onPressed: (){
////                          bloc.toggleFavorite(video);
////                        },
////                      );
////                    else
////                      return CircularProgressIndicator();
////                  },
////                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
