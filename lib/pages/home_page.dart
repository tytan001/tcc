import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/lojas_bloc.dart';
import 'package:idrink/widgets/lojatile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _storesBloc = StoresBloc();
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
//    final bloc = BlocProvider.of<StoresBloc>(context);
//    bloc.allStores();

//    return Container(color: Colors.red,);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 1.0, 10.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                            hintText: "Search",
                            labelText: "Search",
                            labelStyle: TextStyle(color: Colors.black54),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context).buttonColor)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Theme.of(context).buttonColor))),
                        style: TextStyle(fontSize: 18.0),
                        onSubmitted: (text) {
                          if (_searchController.text.isNotEmpty)
                            _storesBloc.inSearch.add(_searchController.text);
                        })),
//                SizedBox(
//                  width: 20.0,
//                ),
//                RaisedButton(
//                  color: Theme.of(context).accentColor,
//                  child: Text("ADD"),
//                  textColor: Theme.of(context).primaryColor,
//                  onPressed: (){
//                    if(_searchController.text.isNotEmpty)
//                    bloc.inSearch.add(_searchController.text);
//                    },
//                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: StreamBuilder(
                stream: _storesBloc.outStores,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return RefreshIndicator(
                      onRefresh: () => _storesBloc.allStores(),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < snapshot.data.length) {
                            return LojaTile(snapshot.data[index]);
                          } else if (index > 1) {
                            _storesBloc.inSearch.add(null);
                            return Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                        itemCount: snapshot.data.length,
                      ),
                    );
                  else
                    return Container();
                }),
          )
        ],
      ),
    );
  }
}
