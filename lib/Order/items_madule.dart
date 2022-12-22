import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;

class items_madule {
  static Future<List<Items>> showdata() async {
    var url;
    globals.mysh();
    url = Uri.parse(globals.http + '/categories_items');

    http.Response response = await http.get(url);
    var json = response.body;
    List<Items> user1 = itemsFromJson(json);
    //print(user1[0].pname);
    return user1;
  }

// To parse this JSON data, do
}

List<Items> itemsFromJson(String str) =>
    List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String itemsToJson(List<Items> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Items {
  Items(
      {required this.gid,
      required this.gname,
      required this.pprice,
      required this.gstat,
      required this.pid,
      required this.pname,
      this.coun = 0});

  String gid;
  String gname;
  String gstat;
  String pid;
  String pname;
  double pprice;
  int coun;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        pprice: double.parse(json["pprice"]),
        gid: json["gid"],
        gname: json["gname"],
        gstat: json["gstat"],
        pid: json["pid"],
        pname: json["pname"],
      );

  Map<String, dynamic> toJson() => {
        "pprice": pprice,
        "gid": gid,
        "gname": gname,
        "gstat": gstat,
        "pid": pid,
        "pname": pname,
      };
}
