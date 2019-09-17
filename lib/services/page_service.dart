import 'package:flutter/material.dart';
import 'package:idrink/pages/auth/main_auth_page.dart';
import 'package:idrink/pages/main_nav_page.dart';
import 'package:idrink/pages/produto_page.dart';
import 'package:idrink/services/cliente_service.dart';
import 'package:idrink/services/token_service.dart';

abstract class PageService {
  static void singIn(BuildContext ctx) async {
    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (context) => MainNavPage()));
  }

  static void toPageProduct(BuildContext ctx, final store) async {
    Navigator.of(ctx).push(
        MaterialPageRoute(builder: (context) => ProductPage(store: store,)));
  }

  static void singOut(BuildContext ctx) async {
    TokenService.removeToken();
    ClientService.removeClient();

    Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
          builder: (BuildContext context) => MainAuthPage(),
        ));
  }
}
