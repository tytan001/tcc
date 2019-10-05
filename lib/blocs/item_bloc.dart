import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:idrink/models/item.dart';
import 'package:rxdart/rxdart.dart';

import 'dart:async';

class ItemBloc extends BlocBase{

  Item _item;

  final _itemController = BehaviorSubject<Item>();

  Stream<Item> get outItem =>
      _itemController.stream;

  Item get valueItem => _itemController.value;

  Function(Item) get changeItem => _itemController.sink.add;

  ItemBloc(item){
    this._item = item;
    _itemController.sink.add(item);
  }

  void moreOne(){
    _item.quantity += 1;
    _itemController.sink.add(_item);
  }

  void lessOne(){
    if(_item.quantity > 0)
      _item.quantity -= 1;
    else
      _item.quantity = 0;
    _itemController.sink.add(_item);
  }

  @override
  void dispose() {
    _itemController.close();
  }
}
