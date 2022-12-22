import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;

class invoicesModule {
  static Future<List<InvoicesDetails>> showdata(bid) async {
    globals.mysh();
    var url = Uri.parse(globals.http + '/invoicesDetalis/' + bid);
    http.Response response = await http.get(url);
    var json = response.body;
    List<InvoicesDetails> user1 = invoicesDetailsFromJson(json);

    return user1;
  }
}
// To parse this JSON data, do
//
//     final invoicesDetails = invoicesDetailsFromJson(jsonString);

List<InvoicesDetails> invoicesDetailsFromJson(String str) =>
    List<InvoicesDetails>.from(
        json.decode(str).map((x) => InvoicesDetails.fromJson(x)));

String invoicesDetailsToJson(List<InvoicesDetails> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InvoicesDetails {
  InvoicesDetails({
    required this.id,
    required this.bid,
    required this.pid,
    required this.qty,
    required this.price,
    required this.total,
    required this.batchno,
    required this.unit,
    required this.profits,
    required this.pname,
  });

  String id;
  String bid;
  String pid;
  String qty;
  String price;
  String total;
  String batchno;
  String unit;
  String profits;
  String pname;

  factory InvoicesDetails.fromJson(Map<String, dynamic> json) =>
      InvoicesDetails(
        id: json["ID"],
        bid: json["bid"],
        pid: json["pid"],
        qty: json["qty"],
        price: json["price"],
        total: json["total"],
        batchno: json["batchno"],
        unit: json["unit"],
        profits: json["profits"],
        pname: json["pname"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "bid": bid,
        "pid": pid,
        "qty": qty,
        "price": price,
        "total": total,
        "batchno": batchno,
        "unit": unit,
        "profits": profits,
        "pname": pname,
      };
}
