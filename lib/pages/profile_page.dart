import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/api.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/utils/toast_util.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
  final StreamController<bool> _isLoadingStream;

  ProfilePage(this._isLoadingStream);
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder(
              future: getUserName(),
              builder: (context, snapshot) {
                return Text(
                    "User: ${snapshot.data.toString() == "null" ? "Ghost" : snapshot.data.toString()}");
              }),
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: FlatButton(
              color: Theme.of(context).accentColor,
              onPressed: () async {
                try {
                  widget._isLoadingStream.add(true);
                  final api = Api();
                  await api.logout(await TokenService.getToken()
                      .then((token) => token.tokenEncoded));
                  PageService.singOut(context);
                } on ResourceException catch (e) {
                  ToastUtil.showToast(e.msg, context, color: ToastUtil.error);
                  PageService.singOut(context);
                } catch (e) {
                  ToastUtil.showToast(e.toString(), context,
                      color: ToastUtil.error);
                  PageService.singOut(context);
                }
              },
              child: Text(
                "Sair",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<String> getUserName() async {
    return await ClientService.getClient().then((client) {
      return client.name;
    });
  }
}
