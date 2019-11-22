import 'package:flutter/material.dart';

class ProfileOption extends StatelessWidget {
  final String label;
  final Function() onTap;
  final IconData icons;

  ProfileOption({this.label, this.onTap, this.icons});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColorLight,
      margin: EdgeInsets.all(1.0),
      child: FlatButton(
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 0.0, 15.0),
        color: Theme.of(context).primaryColorLight,
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (icons != null)
              Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  icons,
                  color: Theme.of(context)
                      .accentColor
                      .withAlpha(240)
                      .withBlue(100),
                  size: 35.0,
                ),
              ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
