import 'package:flutter/material.dart';
import 'package:idrink/api.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/utils/toast_util.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: FlatButton(
          color: Theme.of(context).accentColor,
          onPressed: () async {
            try {
              final api = Api();
              await api.logout(await TokenService.getToken()
                  .then((token) => token.tokenEncoded));
              PageService.singOut(context);
            } on ResourceException catch (e) {
              ToastUtil.showToast(e.msg, context, color: ToastUtil.error);
              PageService.singOut(context);
            } catch (e) {
              ToastUtil.showToast(e.msg, context, color: ToastUtil.error);
              PageService.singOut(context);
            }
          },
          child: Text(
            "Sair",
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}