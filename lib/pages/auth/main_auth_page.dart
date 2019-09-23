import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idrink/pages/auth/sign_in_page.dart';
import 'package:idrink/pages/auth/sign_up_page.dart';
import 'package:idrink/widgets/gradient.dart';

class MainAuthPage extends StatefulWidget {
  static final int signIn = 0;
  static final int signUp = 1;

  @override
  _MainAuthPageState createState() => _MainAuthPageState();
}

class _MainAuthPageState extends State<MainAuthPage> {
  StreamController<bool> _isLoadingStream;
  List<Widget> _pages;

  static final PageController _pageController =
      PageController(initialPage: MainAuthPage.signIn);

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _isLoadingStream = StreamController<bool>.broadcast();
    _pages = [
      SignInPage(_pageController, _isLoadingStream),
      SignUpPage(_pageController, _isLoadingStream),
    ];
  }

  @override
  void dispose() {
    _isLoadingStream.close();
    _defaultOrientation();
    super.dispose();
  }

  @override
  void deactivate() {
    _isLoadingStream.close();
    _defaultOrientation();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GradientBackground(),
        StreamBuilder(
          stream: _isLoadingStream.stream.asBroadcastStream(),
          builder: (_, snap) => _loadPageView(snap),
        ),
      ],
    );
  }

  PageView _loadPageView(AsyncSnapshot<bool> snap) {
    return PageView(
      physics: (snap.hasData && snap.data)
          ? NeverScrollableScrollPhysics()
          : BouncingScrollPhysics(),
      controller: _pageController,
      children: _pages,
    );
  }

  void _defaultOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
