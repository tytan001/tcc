import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:idrink/api.dart';
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
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: <Widget>[
//                Image.network('https://flutter.io/images/catalog-widget-placeholder.png',width: 40.0,height: 40.0,fit: BoxFit.cover,),
            _store.avatar != null && _store.avatar != "default.svg"
                ? Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          ROUTE_IMAGE + _store.avatar,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
//                : Container(
//                    margin: EdgeInsets.symmetric(horizontal: 5.0),
//                    width: 50.0,
//                    height: 50.0,
//                    decoration: BoxDecoration(
//                      shape: BoxShape.circle,
//                      image: DecorationImage(
//                        image: ExactAssetImage("images/store.png"),
//                      ),
//                    ),
////                    child: Image.asset(
////                      "images/store.png",
////                      fit: BoxFit.fill,
////                    ),
//                  ),
                : Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    child: SvgPicture.asset(
                      'images/svg/shop.svg',
                      height: 50.0,
                      width: 50.0,
                    ),
                  ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 8, 1),
                    child: Text(
                      _store.name,
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 20,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            _store.situation == "open"
                ? Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.greenAccent, width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 4.0),
                    margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                    child: Text(
                      "Aberto",
                      style: TextStyle(fontSize: 12.0, color: Colors.black87),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.redAccent, width: 1.5),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 4.0),
                    margin: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                    child: Text(
                      "Fechado",
                      style: TextStyle(fontSize: 12.0, color: Colors.black87),
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
        ),
      ),
    );
  }
}
