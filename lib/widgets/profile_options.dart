import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final String label;
  final Function() onTap;
  final bool line;

  ProfileOption({this.label, this.onTap, this.line});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
                  color: Theme.of(context).primaryColor,
                  onPressed: onTap,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        label,
                        style: TextStyle(fontSize: 18.0),
                      )),
                ),
              ),
            ],
          ),
        ),
        if (line ?? false)
          Divider(
            color: Theme.of(context).hoverColor,
          )
      ],
    );
//    return GestureDetector(
//      onTap: onTap,
//      child: Container(
//        margin: EdgeInsets.only(left: 10.0),
//        child: Row(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: <Widget>[
//            Container(
//              child: Text(label),
//            )
//          ],
//        ),
//      ),
//    );
  }
}
