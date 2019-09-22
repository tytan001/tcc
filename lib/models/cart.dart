import 'package:idrink/models/client.dart';
import 'package:idrink/models/item.dart';
import 'package:idrink/models/order.dart';
import 'package:idrink/models/store.dart';

class Cart {
  final Client client;
  final Store store;
  final Order order;
  final List<Item> items;

  Cart({this.client, this.store, this.order, this.items});

//  factory Login.fromJson(Map<String, dynamic> json) {
//    return Login(
//      email: json['customer_email'],
//      password: json['customer_password'],
//    );
//  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["client"] = client;
    map["store"] = store;
    map["orders"] = order;
    map["items"] = items;

    return map;
  }

  @override
  String toString() {
    return " Email: $client\n Password: $store\n Email: $order\n Password: $items\n";
  }
}
