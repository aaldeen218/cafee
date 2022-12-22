// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:ffi';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;

class PreInvoices_class {
  static Future<List<PreInvoices>> showdata(uid) async {
    var url;
    globals.mysh();
    url = Uri.parse(globals.http + '/pre_invoices/' + uid);
    // print(uid);
    http.Response response = await http.get(url);
    var json = response.body;

    List<PreInvoices> user1 = preInvoicesFromJson(json);
    //print(user1[0].cname);

    return user1;
  }

  static insertData(dd) async {
    var url;
    print(preInvoicesToJson(dd));
    url = Uri.parse(globals.http + '/store');
    http.Response response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: preInvoicesToJson(dd),
    );
    if (response.statusCode == 200) {
      print("Ok");
    } else {
      throw Exception('Failed ' + response.statusCode.toString());
    }
  }
// To parse this JSON data, do
//
//     final preInvoices = preInvoicesFromJson(jsonString);

}

List<PreInvoices> preInvoicesFromJson(String str) => List<PreInvoices>.from(
    json.decode(str).map((x) => PreInvoices.fromJson(x)));

String preInvoicesToJson(PreInvoices data) => json.encode(data);

class PreInvoices {
  PreInvoices({
    this.ID = "",
    required this.bid,
    required this.bdate,
    required this.cname,
    required this.btotal,
    required this.bnote,
    required this.bstat,
    required this.uid,
    required this.un,
  });

  String ID;
  String bid;
  DateTime bdate;
  String cname;
  double btotal;
  String bnote;
  String bstat;
  String uid;
  String un;

  factory PreInvoices.fromJson(Map<String, dynamic> json) => PreInvoices(
        ID: json["id"],
        bid: json["bid"],
        bdate: DateTime.parse(json["bdate"]),
        cname: json["cname"],
        btotal: double.parse(json["btotal"]),
        bnote: json["bnote"],
        bstat: json["bstat"],
        uid: json["uid"],
        un: json["un"],
      );

  Map<String, dynamic> toJson() => {
        "bid": bid,
        "bdate":
            "${bdate.year.toString().padLeft(4, '0')}-${bdate.month.toString().padLeft(2, '0')}-${bdate.day.toString().padLeft(2, '0')} ${bdate.hour.toString().padLeft(2, '0')}:${bdate.minute.toString().padLeft(2, '0')}:${bdate.second.toString().padLeft(2, '0')}",
        "cname": cname,
        "btotal": btotal,
        "bnote": bnote,
        "bstat": bstat,
        "uid": uid,
        "un": un,
      };
}
