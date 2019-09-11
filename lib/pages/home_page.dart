import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static final int profile = 0;
  static final int home = 1;
  static final int historic = 2;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: HomePage.home);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _pageController.dispose();
    super.deactivate();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Colors.orange,
            primaryColor: Colors.white,
            textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.white54)
            )
        ),
        child: BottomNavigationBar(
            currentIndex: _page,
            onTap: (p){
              _pageController.animateToPage(
                  p,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease
              );
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Clientes")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text("Pedidos")
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  title: Text("Produtos")
              )
            ]
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (p){
            setState(() {
              _page = p;
            });
          },
          children: <Widget>[
            Container(color: Colors.red,),
            Container(color: Colors.blue,),
            Container(color: Colors.yellow,),
          ],
        ),

      ),
    );
  }
}
