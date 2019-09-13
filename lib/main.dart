import 'package:flutter/material.dart';
import 'package:idrink/pages/auth/main_auth_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iDrink',
      theme: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.yellow,
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,
        buttonColor: Colors.blue
      ),
//      theme: ThemeData(
////        primarySwatch: Colors.blue,
////        hintColor: Colors.blue,
////        inputDecorationTheme: InputDecorationTheme(
////            enabledBorder: OutlineInputBorder(
////                borderSide: BorderSide(color: Colors.blue)))
//      ),
      debugShowCheckedModeBanner: false,
      home: MainAuthPage()
    );
  }
}