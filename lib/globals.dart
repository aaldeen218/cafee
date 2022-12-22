//var http = "http://192.168.86.211:8000";

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

var http = "";
//http://10.0.2.2:8000
//var http = "http://192.168.8.136:8000";
//var http = "http://127.0.0.1:8000";
//var http = "http://localhost:8000";

//var emp_id_global = "";
var empGender_global = "";

mysh() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  http = pref.getString("http").toString();
  print(http + " Http");
}
