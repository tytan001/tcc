import 'package:flutter/material.dart';
import 'package:idrink/pages/auth/main_auth_page.dart';
import 'package:idrink/pages/card_page.dart';
import 'package:idrink/pages/main_nav_page.dart';
import 'package:idrink/pages/product_page.dart';
import 'package:idrink/pages/store_page.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/token_service.dart';

abstract class PageService {
  static void singIn(BuildContext ctx) async {
    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MainNavPage()));
  }

  static void toPageStore(BuildContext ctx, final store) async {
    Navigator.of(ctx)
        .push(MaterialPageRoute(builder: (context) => StorePage(store: store)));
  }

  static void toPageProduct(
      BuildContext ctx, final product, final store) async {
    Navigator.of(ctx).push(MaterialPageRoute(
        builder: (context) => ProductPage(product: product, store: store)));
  }

  static void toPageCard(BuildContext ctx) async {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (context) => CardPage()));
  }

  static void singOut(BuildContext ctx) async {
    TokenService.removeToken();
    ClientService.removeClient();

    Navigator.of(ctx).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => MainAuthPage()));
  }
}
