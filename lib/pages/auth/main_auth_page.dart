import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/pages/auth/sign_in_page.dart';
import 'package:idrink/pages/auth/sign_up_page.dart';

class MainAuthPage extends StatefulWidget {
  static final int signIn = 0;
  static final int signUp = 1;

  @override
  _MainAuthPageState createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  StreamController<bool> _isLoadingStream;
  List<Widget> _pages;

  static final PageController _pageController = PageController(initialPage: MainAuthPage.signIn);

  @override
  void initState() {
    _isLoadingStream = StreamController<bool>.broadcast();
    _pages = [
      SignInPage(_pageController, _isLoadingStream),
      SignUpPage(_pageController, _isLoadingStream),
    ];
    super.initState();
  }

  @override
  void dispose() {
    _isLoadingStream.close();
    super.dispose();
  }

  @override
  void deactivate() {
    _isLoadingStream.close();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // Box decoration takes a gradient
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.red[800],
            Colors.orange[700],
            Colors.orangeAccent[400],
            Colors.yellow,
          ],
        ),
      ),
      child: StreamBuilder(
        stream: _isLoadingStream.stream.asBroadcastStream(),
        builder: (_, snap) => _loadPageView(snap),
      ),
    );
  }

  PageView _loadPageView(AsyncSnapshot<bool> snap) {
    if (snap.hasData && snap.data) {
      return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pages,
      );
    } else {
      return PageView(
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        children: _pages,
      );
    }
  }
}
