import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/stores_bloc.dart';
import 'package:idrink/blocs/products_bloc.dart';
import 'package:idrink/pages/home_page.dart';

class MainNavPage extends StatefulWidget {
  static final int home = 0;
  static final int historic = 1;
  static final int profile = 2;

  @override
  _MainNavPageState createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  StoresBloc storesBloc = StoresBloc();
  ProductsBloc productsBloc = ProductsBloc();
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: MainNavPage.home);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//  @override
//  void deactivate() {
//    _pageController.dispose();
//    super.deactivate();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.grey[850],
      backgroundColor: Theme.of(context).primaryColorLight,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).primaryColorLight,
            primaryColor: Theme.of(context).accentColor,
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Theme.of(context).primaryColorDark))),
        child: BottomNavigationBar(
            currentIndex: _page,
            onTap: (p) {
              _pageController.animateToPage(p,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), title: Text("Pedidos")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list), title: Text("Produtos")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), title: Text("Clientes")),
            ]),
      ),
      body: SafeArea(
        child: BlocProvider<StoresBloc>(
          bloc: storesBloc,
          child: BlocProvider(
            bloc: productsBloc,
            child: PageView(
              controller: _pageController,
              onPageChanged: (p) {
                setState(() {
                  _page = p;
                });
              },
              children: <Widget>[
                HomePage(),
                Container(
                  color: Colors.blue,
                ),
                Container(
                  color: Colors.yellow,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
