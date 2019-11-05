import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/blocs/stores_bloc.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/page_state.dart';
import 'package:idrink/utils/toast_util.dart';
import 'package:idrink/widgets/divider.dart';
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
  void initState() {
    super.initState();
    _storesBloc.outState.listen((state) {
      switch (state) {
        case PageState.SUCCESS:
          break;
        case PageState.FAIL:
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: StreamBuilder(
                  stream: _storesBloc.outMessage,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data.toString(),
                      textAlign: TextAlign.center,
                    );
                  }),
            ),
          );
          break;
        case PageState.LOADING:
          break;
        case PageState.IDLE:
          break;
        case PageState.UNAUTHORIZED:
          ToastUtil.showToast(_storesBloc.getMessage, context,
              color: ToastUtil.error);
          PageService.singOut(context);
          break;
      }
    });
  }

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
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            return StoreTile(snapshot.data[index]);
                          },
                          itemCount: snapshot.data.length,
                          separatorBuilder: (context, index) =>
                              DividerDefault(),
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
