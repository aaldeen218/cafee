import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;

class LoginModule {
  static Future<List<Login>> showdata(user_name, password) async {
    globals.mysh();
    var url = Uri.parse(globals.http + '/login/' + user_name + '/' + password);
    http.Response response = await http.get(url);
    var json = response.body;
    List<Login> user1 = loginFromJson(json);

    return user1;
  }
}

List<Login> loginFromJson(String str) =>
    List<Login>.from(json.decode(str).map((x) => Login.fromJson(x)));

String loginToJson(List<Login> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Login {
  Login({
    required this.uid,
    required this.fullname,
    required this.ugroup,
    this.pname = "",
  });

  String uid;
  String fullname;
  String ugroup;
  String pname = "";

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        uid: json["uid"],
        fullname: json["fullname"],
        ugroup: json["ugroup"],
        pname: json["pname"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullname": fullname,
        "ugroup": ugroup,
        "pname": pname,
      };
}
