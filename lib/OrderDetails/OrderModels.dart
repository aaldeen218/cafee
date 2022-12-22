// To parse this JSON data, do
//
//     final orderModels = orderModelsFromJson(jsonString);
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;
import 'package:meta/meta.dart';
import 'dart:convert';

class OrderModels_class {
  static Future<List<OrderModels>> showdata(pre_bid) async {
    var url;
    url = Uri.parse(globals.http + '/show_pre_invoicesitems/' + pre_bid);

    http.Response response = await http.get(url);
    var json = response.body;
    List<OrderModels> user1 = orderModelsFromJson(json);
    print(user1[0].total);
    return user1;
  }

// To parse this JSON data, do
}

List<OrderModels> orderModelsFromJson(String str) => List<OrderModels>.from(
    json.decode(str).map((x) => OrderModels.fromJson(x)));

String orderModelsToJson(List<OrderModels> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModels {
  OrderModels({
    required this.id,
    required this.bid,
    required this.pid,
    required this.qty,
    required this.total,
    required this.pname,
  });

  String id;
  String bid;
  String pid;
  int qty;
  double total;
  String pname;

  factory OrderModels.fromJson(Map<String, dynamic> json) => OrderModels(
        id: json["ID"],
        bid: json["bid"],
        pid: json["pid"],
        qty: int.parse(json["qty"]),
        total: double.parse(json["total"]),
        pname: json["pname"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "bid": bid,
        "pid": pid,
        "qty": qty,
        "total": total,
        "pname": pname,
      };
}
