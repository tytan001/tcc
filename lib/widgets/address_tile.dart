import 'package:flutter/material.dart';
import 'package:idrink/models/address.dart';

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
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          border: Border.all(color: Theme.of(context).accentColor, width: 1.5),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(12.0, 0.0, 20.0, 0.0),
              child: Center(
                child: Icon(
                  Icons.home,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    _address.cep,
                    style: TextStyle(
                      color: Theme.of(context).hoverColor,
                      fontSize: 13,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        _address.publicPlace,
                        style: TextStyle(
                          color: Theme.of(context).hoverColor,
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          _address.complement,
                          style: TextStyle(
                            color: Theme.of(context).hoverColor,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          "Nº ${_address.number}",
                          style: TextStyle(
                            color: Theme.of(context).hoverColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _address.neighborhood,
                    style: TextStyle(
                      color: Theme.of(context).hoverColor,
                      fontSize: 13,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        _address.locality,
                        style: TextStyle(
                          color: Theme.of(context).hoverColor,
                          fontSize: 13,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: Text(
                          _address.uf,
                          style: TextStyle(
                            color: Theme.of(context).hoverColor,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
