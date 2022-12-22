// To parse this JSON data, do
//
//     final newitemsOrder = newitemsOrderFromJson(jsonString);
import 'package:cafee/menu/items_madule.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;
import 'package:meta/meta.dart';
import 'dart:convert';

class NewItemOrder {
  static insertItemsData(List<NewitemsOrder> dd) async {
    var url;
    print(dd);

    url = Uri.parse(globals.http + '/add_pre_invoicesitems');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: newitemsOrderToJson(dd),
    );
    if (response.statusCode == 200) {
      print("Ok");
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }
}

List<NewitemsOrder> newitemsOrderFromJson(String str) =>
    List<NewitemsOrder>.from(
        json.decode(str).map((x) => NewitemsOrder.fromJson(x)));

String newitemsOrderToJson(List<NewitemsOrder> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewitemsOrder {
  NewitemsOrder(
      {required this.bid,
      required this.pid,
      required this.qty,
      required this.price,
      required this.total,
      this.name = "",
      this.uname = "",
      this.table = "0"});

  String bid;
  String pid;
  int qty;
  double price;
  double total;
  String name;
  String uname;
  String table;

  factory NewitemsOrder.fromJson(Map<String, dynamic> json) => NewitemsOrder(
        bid: json["bid"],
        pid: json["pid"],
        price: json["price"],
        qty: json["qty"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "pid": pid,
        "price": price,
        "qty": qty,
        "total": total,
      };
}
