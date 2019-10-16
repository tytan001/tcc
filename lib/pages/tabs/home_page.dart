import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/stores_bloc.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/widgets/store_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  final StreamController<bool> _isLoadingStream;

  HomePage(this._isLoadingStream);
}

class _HomePageState extends State<HomePage> {
  final _storesBloc = StoresBloc();
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(context).buttonColor,
                      ),
                      hintText: "Search",
                      labelText: "Search",
                      labelStyle: TextStyle(color: Colors.black54),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Theme.of(context).buttonColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                            BorderSide(color: Theme.of(context).buttonColor),
                      ),
                    ),
                    style: TextStyle(fontSize: 18.0),
                    onSubmitted: (text) {
                      if (_searchController.text.isNotEmpty)
                        _storesBloc.inSearch.add(_searchController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: StreamBuilder<List<Store>>(
                stream: _storesBloc.outStores,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Container(
                      color: Theme.of(context).primaryColor,
                      child: RefreshIndicator(
                        onRefresh: () => _storesBloc.allStores,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return StoreTile(snapshot.data[index]);
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
          )
        ],
      ),
    );
  }
}
