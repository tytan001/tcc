import 'dart:async';
import 'dart:io';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/card_bloc.dart';
import 'package:idrink/blocs/user_bloc.dart';
import 'package:idrink/pages/tabs/historic_page.dart';
import 'package:idrink/pages/tabs/home_page.dart';
import 'package:idrink/pages/tabs/profile_page.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/utils/toast_util.dart';

class MainNavPage extends StatefulWidget {
  static final int home = 0;
  static final int historic = 1;
  static final int profile = 2;

  @override
  _MainNavPageState createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
//  CardBloc cardBloc = CardBloc();
  StreamController<bool> _isLoadingStream;
  PageController _pageController;
  List<Widget> _pages;
  int _page = 0;

  @override
  void initState() {
    _isLoadingStream = StreamController<bool>.broadcast();
    _pageController = PageController(initialPage: MainNavPage.home);

    _pages = [
      HomePage(_isLoadingStream),
      HistoricPage(_isLoadingStream),
      ProfilePage(_isLoadingStream),
    ];

    getUserName();
    super.initState();
  }

  @override
  void dispose() {
    _isLoadingStream.close();
    _pageController.dispose();
    super.dispose();
  }

  Future<void> getUserName() async {
    final client = await ClientService.getClient();
    ToastUtil.showToast(
        "Bem vindo, Sr(a)${client == null ? "Ghost" : client.name}", context,
        color: ToastUtil.black);
  }

//  @override
//  void deactivate() {
//    _pageController.dispose();
//    super.deactivate();
//  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
//      backgroundColor: Colors.grey[850],
        backgroundColor: Theme.of(context).primaryColorLight,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Theme.of(context).primaryColorLight,
              primaryColor: Theme.of(context).accentColor,
              textTheme: Theme.of(context).textTheme.copyWith(
                  caption:
                      TextStyle(color: Theme.of(context).primaryColorDark))),
          child: BottomNavigationBar(
              currentIndex: _page,
              onTap: (p) {
                _pageController.animateToPage(p,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Container()),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list), title: Container()),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Container()),
              ]),
        ),
        body: SafeArea(
          child: BlocProvider(
            blocs: [
              Bloc((i) => UserBloc()),
              Bloc((i) => CardBloc()),
            ],
            child: StreamBuilder(
              stream: _isLoadingStream.stream.asBroadcastStream(),
              builder: (_, snap) => _loadPageView(snap),
            ),
          ),
        ),
      ),
      onWillPop: _requestPop,
    );
  }

  PageView _loadPageView(AsyncSnapshot<bool> snap) {
    return PageView(
      controller: _pageController,
      onPageChanged: (p) {
        setState(() {
          _page = p;
        });
      },
      physics:
          (snap.hasData && snap.data) ? NeverScrollableScrollPhysics() : null,
      children: _pages,
    );
  }

  Future<bool> _requestPop() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text("Sair do iDrink?"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Sim"),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          );
        });
    return Future.value(false);
  }
}
