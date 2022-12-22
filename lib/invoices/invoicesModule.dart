import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;

class LoginModule {
  static Future<List<Invoices>> showdata(uid, date1, date2) async {
    globals.mysh();
    var url = Uri.parse(
        globals.http + '/invoices/' + uid + '/' + date1 + '/' + date2);
    http.Response response = await http.get(url);
    var json = response.body;
    List<Invoices> user1 = invoicesFromJson(json);

    return user1;
  }
}
// To parse this JSON data, do
//
//     final invoices = invoicesFromJson(jsonString);

List<Invoices> invoicesFromJson(String str) =>
    List<Invoices>.from(json.decode(str).map((x) => Invoices.fromJson(x)));

String invoicesToJson(List<Invoices> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Invoices {
  Invoices({
    required this.id,
    required this.bid,
    required this.bdate,
    required this.cid,
    required this.btotal,
    required this.bnote,
    required this.bstat,
    required this.un,
  });

  String id;
  String bid;
  DateTime bdate;
  String cid;
  double btotal;
  String bnote;
  String bstat;
  String un;

  factory Invoices.fromJson(Map<String, dynamic> json) => Invoices(
        id: json["ID"],
        bid: json["bid"],
        bdate: DateTime.parse(json["bdate"]),
        cid: json["cid"],
        btotal: double.parse(json["btotal"]),
        bnote: json["bnote"],
        bstat: json["bstat"],
        un: json["un"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "bid": bid,
        "bdate":
            "${bdate.year.toString().padLeft(4, '0')}-${bdate.month.toString().padLeft(2, '0')}-${bdate.day.toString().padLeft(2, '0')}",
        "cid": cid,
        "btotal": btotal,
        "bnote": bnote,
        "bstat": bstat,
        "un": un,
      };
}
