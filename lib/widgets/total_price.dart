import 'package:flutter/material.dart';
import 'package:idrink/models/dto/item_dto.dart';

class TotalPrice extends StatelessWidget {
  final List<ItemDTO> _items;

  const TotalPrice(this._items);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Total R\$ ${(valorTotal()).toStringAsFixed(2).replaceAll(".", ",")}",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    );
  }

  double valorTotal() {
    double total = 0.0;
    _items.forEach((i) {
      total += i.quantity * i.price;
    });
    return total;
  }
}
