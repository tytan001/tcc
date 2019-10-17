import 'package:flutter/material.dart';
import 'package:idrink/models/address.dart';
import 'package:idrink/models/store.dart';
import 'package:idrink/services/page_service.dart';

class AddressTile extends StatelessWidget {
  final Address _address;

  AddressTile(this._address);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
//        PageService.toPageStore(context, _address);
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 1),
                        child: Text(
                          "Text",
                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark,
                              fontSize: 20),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        child: Divider(
                          color: Theme.of(context).hoverColor,
                          height: 30,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
