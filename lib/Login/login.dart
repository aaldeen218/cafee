import 'package:cafee/MyHomeScreen.dart';
import 'package:cafee/dimension.dart';
import 'package:cafee/mainColor.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'LoginModule.dart';
import '/globals.dart' as globals;
import 'package:flutter_svg/flutter_svg.dart';

bool isLoading = false;

class login extends StatefulWidget {
  static String name_route = "login";

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var myController = TextEditingController();
  var myController2 = TextEditingController();
  var myControllerIP = TextEditingController();
  String div = "";

  @override
  void initState() {
    mysh();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          print("Confirm Exit");
          return true;
        },
        child: Scaffold(
          body: div == "UG-0000000" ? MyHomeScreen() : buildContainer(),
        ),
      );
  // mysh();

  Container buildContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Stack(
        children: [
          isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: Dimensions.Size_50 * 2,
                    width: Dimensions.Size_50 * 2,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: Dimensions.Size_30 / 2,
                    ),
                  ))
              : Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onLongPress: () {
                            final Alert = AlertDialog(
                              title: Column(
                                children: [
                                  Text(
                                    "معلومات الاتصال",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  Divider(
                                    height: 2,
                                    thickness: 1,
                                    color: Colors.black,
                                  ),
                                  TextField(
                                    controller: myControllerIP,
                                    keyboardType: TextInputType.text,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  Dimensions.Size_50),
                                              bottomLeft: Radius.circular(
                                                  Dimensions.Size_50),
                                              topLeft: Radius.circular(
                                                  Dimensions.Size_10 / 2),
                                              bottomRight: Radius.circular(
                                                  Dimensions.Size_10 / 2)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        hintText: "IP",
                                        hintStyle: TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.blue,
                                        )),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: Dimensions.Size_30 / 2,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ],
                              ),
                              content: Container(
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                              style: ButtonStyle(
                                                foregroundColor:
                                                    MaterialStateProperty.all(
                                                        Color(0xff000000)),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  Color(0xffd3def4),
                                                ),
                                              ),
                                              onPressed: () async {
                                                SharedPreferences pref =
                                                    await SharedPreferences
                                                        .getInstance();

                                                pref.setString("http",
                                                    myControllerIP.text);
                                                globals.mysh();
                                                // globals.http = myController.text;

                                                Navigator.of(context).pop();
                                              },
                                              child: Text("موافق")),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                            showDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierColor: Colors.black.withOpacity(0.6),
                                builder: (BuildContext ctx) {
                                  return Alert;
                                });
                          },
                          child: SvgPicture.asset(
                            'assets/images/cafe_svg.svg',
                            height: Dimensions.screenHeight / 3,
                            width: Dimensions.screenHeight / 3,
                          ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(Dimensions.Size_10),
                                child: TextField(
                                  controller: myController,
                                  keyboardType: TextInputType.text,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(
                                                Dimensions.Size_50),
                                            bottomLeft: Radius.circular(
                                                Dimensions.Size_50),
                                            topLeft: Radius.circular(
                                                Dimensions.Size_10 / 2),
                                            bottomRight: Radius.circular(
                                                Dimensions.Size_10 / 2)),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFB5EAE8),
                                      hintText: "اسم المستخدم",
                                      hintStyle: TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.blueGrey,
                                      )),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Dimensions.Size_30 / 2,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(Dimensions.Size_10),
                                child: TextField(
                                  controller: myController2,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(
                                                Dimensions.Size_50),
                                            topLeft: Radius.circular(
                                                Dimensions.Size_50),
                                            bottomLeft: Radius.circular(
                                                Dimensions.Size_10 / 2),
                                            topRight: Radius.circular(
                                                Dimensions.Size_10 / 2)),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFB5EAE8),
                                      hintText: "كلمة المرور",
                                      alignLabelWithHint: false,
                                      hintStyle: TextStyle(
                                        color: Colors.blueGrey,
                                      )),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: Dimensions.Size_30 / 2,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xED62C377)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Dimensions.Size_50),
                                          bottomLeft: Radius.circular(
                                              Dimensions.Size_50),
                                          bottomRight: Radius.circular(
                                              Dimensions.Size_10 / 2),
                                          topLeft: Radius.circular(
                                              Dimensions.Size_10 / 2)))),
                              foregroundColor:
                                  MaterialStateProperty.all(Color(0xff000000)),

                              /*backgroundColor: MaterialStateProperty.all(
                          Color(0xffa9ecb8),
                        )*/
                            ),
                            onPressed: () {
                              setState(() {
                                isLoading = false;
                                if (myController.text.isEmpty ||
                                    myController2.text.isEmpty) {
                                  var bar = SnackBar(
                                    duration: Duration(seconds: 3),
                                    backgroundColor:
                                        Colors.black.withOpacity(0.5),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          "الرجاء اكمال الحقول",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(bar);
                                } else {
                                  setState(() {
                                    isLoading = true;
                                    GetData(
                                        myController.text, myController2.text);
                                  });
                                }
                              });
                            },
                            child: Text(
                              "دخول",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.Size_30 / 2,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  GetData(user_name, user_pass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    clear_pref();
    Future<List<Login>> x = LoginModule.showdata(user_name, user_pass);

    x.then((value) {
      if (value.isNotEmpty) {
        setState(() {
          isLoading = false;
        });
        if (value[0].ugroup != "") {
          pref.setString("uid", value[0].uid);
          pref.setString("user_name", user_name);
          pref.setString("ufullname", value[0].fullname);
          pref.setString("ugroup", value[0].ugroup);
          pref.setString("pname", value[0].pname);
          pref.setBool("IsFirst", false);

          if (value[0].ugroup == "UG-0000000")
            Navigator.of(context).popAndPushNamed(MyHomeScreen.name_route);
        }
      } else {
        setState(() {
          isLoading = false;

          var bar = SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.black.withOpacity(0.5),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  "الرجاء التاكد من بيانات الدخول",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Icon(
                  Icons.error_outline,
                  color: Colors.white,
                )
              ],
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(bar);
        });
      }
    });
  }

  mysh() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      div = pref.getString("ugroup").toString();
    });
  }
}

clear_pref() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setString("uid", "");
  pref.setString("ufullname", "");
  pref.setString("ugroup", "");
  pref.setString("user_name", "");
}
