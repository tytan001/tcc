import 'package:flutter/material.dart';
import 'package:idrink/models/dto/item_dto.dart';

class ItemsOrderTile extends StatelessWidget {
  final ItemDTO _itemDTO;

  ItemsOrderTile(this._itemDTO);

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
//            "R\$ ${_itemDTO.partialPrice}",
            "R\$ ${(_itemDTO.price * _itemDTO.quantity).toStringAsFixed(2).replaceAll(".", ",")}",
            style: TextStyle(
                color: Theme.of(context).primaryColorDark, fontSize: 15),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
