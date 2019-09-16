import 'package:flutter/material.dart';
import 'package:idrink/models/loja.dart';

class LojaTile extends StatelessWidget {

  final Loja _loja;

  LojaTile(this._loja);

  @override
  Widget build(BuildContext context) {

//    final bloc = BlocProvider.of<FavoriteBloc>(context);

    return GestureDetector(
      onTap: (){
        //Acao do click
        print("Clicou na ${_loja.name} ");
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
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
                          _loja.name,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 20
                          ),
                          maxLines: 2,
                        ),
                      ),
//                      Padding(
//                        padding: EdgeInsets.all(8),
//                        child: Text(
//                          _loja.phone,
//                          style: TextStyle(
//                              color: Colors.black,
//                              fontSize: 14
//                          ),
//                        ),
//                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
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
