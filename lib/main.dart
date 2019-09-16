import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:idrink/blocs/lojas_bloc.dart';
import 'package:idrink/pages/auth/main_auth_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'iDrink',
        theme: ThemeData(
            primaryColor: Colors.yellow,
            accentColor: Colors.orange,
            primaryColorDark: Colors.black,
            primaryColorLight: Colors.white,
            buttonColor: Colors.orangeAccent
        ),
        debugShowCheckedModeBanner: false,
        home: MainAuthPage()
    );
//    return BlocProvider(
//        bloc: StoresBloc(),
//        child: MaterialApp(
//          title: 'iDrink',
//          theme: ThemeData(
//              primaryColor: Colors.yellow,
//              accentColor: Colors.orange,
//              primaryColorDark: Colors.black,
//              primaryColorLight: Colors.white,
//              buttonColor: Colors.orangeAccent
//          ),
//          debugShowCheckedModeBanner: false,
//          home: MainAuthPage()
//        )
//    );

//    return MaterialApp(
//      title: 'iDrink',
//      theme: ThemeData(
//        primaryColor: Colors.white,
//        accentColor: Colors.yellow,
//        primaryColorDark: Colors.black,
//        primaryColorLight: Colors.white,
//        buttonColor: Colors.blue
//      ),
////      theme: ThemeData(
//////        primarySwatch: Colors.blue,
//////        hintColor: Colors.blue,
//////        inputDecorationTheme: InputDecorationTheme(
//////            enabledBorder: OutlineInputBorder(
//////                borderSide: BorderSide(color: Colors.blue)))
////      ),
//      debugShowCheckedModeBanner: false,
//      home: MainAuthPage()
//    );
  }
}