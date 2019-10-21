import 'package:flutter/material.dart';
import 'package:idrink/models/dto/item_dto.dart';

class ItemsHistoricOrderTile extends StatelessWidget {
  final ItemDTO _itemDTO;

  ItemsHistoricOrderTile(this._itemDTO);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      color: Theme.of(context).primaryColorLight,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${_itemDTO.quantity}x ${_itemDTO.productName}",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark, fontSize: 15),
            maxLines: 2,
          ),
          Text(
            "R\$ ${_itemDTO.partialPrice}",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark, fontSize: 15),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
