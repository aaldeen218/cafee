// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;

class categories_madule {
  static Future<List<Categories>> showdata() async {
    var url;
    url = Uri.parse(globals.http + '/categories');

    http.Response response = await http.get(url);
    var json = response.body;

    List<Categories> user1 = categoriesFromJson(json);
// print(user1[0].patName);
    print("categories_madule");
    return user1;
  }
// To parse this JSON data, do
}

List<Categories> categoriesFromJson(String str) =>
    List<Categories>.from(json.decode(str).map((x) => Categories.fromJson(x)));

String categoriesToJson(List<Categories> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categories {
  Categories({
    required this.gname,
  });

  String gname;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        gname: json["gname"],
      );

  Map<String, dynamic> toJson() => {
        "gname": gname,
      };
}
