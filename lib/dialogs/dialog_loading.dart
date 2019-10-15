import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.of(context).size.width / 10,
        height: MediaQuery.of(context).size.height / 10,
        color: Theme.of(context).primaryColor,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(
              Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
    );
  }
}
