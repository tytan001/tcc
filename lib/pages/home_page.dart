import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/stores_bloc.dart';
import 'package:idrink/widgets/lojatile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  final _storesBloc = StoresBloc();
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _storesBloc = BlocProvider.of<StoresBloc>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
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
                      onRefresh: () => _storesBloc.allStores,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < snapshot.data.length) {
                            return LojaTile(snapshot.data[index]);
                          } else {
                            return Container(
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                            );
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

  @override
  void initState() {}
}
