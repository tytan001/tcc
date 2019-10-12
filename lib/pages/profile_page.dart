import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idrink/api.dart';
import 'package:idrink/resources/resource_exception.dart';
import 'package:idrink/services/client_service.dart';
import 'package:idrink/services/page_service.dart';
import 'package:idrink/services/token_service.dart';
import 'package:idrink/utils/toast_util.dart';
import 'package:idrink/widgets/profile_options.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
  final StreamController<bool> _isLoadingStream;

  ProfilePage(this._isLoadingStream);
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: FutureBuilder(
            future: getUserName(),
            builder: (context, snapshot) {
              return Text(
                  "${snapshot.data.toString() == "null" ? "" : snapshot.data.toString()}");
            }),
        centerTitle: true,
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ProfileOption(
                    label: "Editar Perfil",
                    onTap: () => PageService.toPageUpdateProfile(context),
                    line: true,
                  ),
                  ProfileOption(
                    label: "Alterar senha",
                    onTap: () => PageService.toPageUpdatePassword(context),
                    line: true,
                  ),
                  ProfileOption(
                    label: "Adicionar Endereço",
                    onTap: () => PageService.toPageAddress(context),
                    line: true,
                  ),
                ],
              ),
            ),
            ProfileOption(
              label: "Sair",
              onTap: logOff,
            )
          ],
        ),
      ),
    );
  }

  void logOff() async {
    try {
      widget._isLoadingStream.add(true);
      final api = Api();
      await api.logout(
          await TokenService.getToken().then((token) => token.tokenEncoded));
      PageService.singOut(context);
    } on ResourceException catch (e) {
      ToastUtil.showToast(e.msg, context, color: ToastUtil.error);
      PageService.singOut(context);
    } catch (e) {
      ToastUtil.showToast(e.toString(), context, color: ToastUtil.error);
      PageService.singOut(context);
    }
  }

  Future<String> getUserName() async {
    return await ClientService.getClient().then((client) {
      return client.name;
    });
  }
}
