import 'package:cafee/Login/login.dart';
import 'package:flutter/material.dart';
import '/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class settings extends StatefulWidget {
  static String name_route = "settings";

  const settings({Key? key}) : super(key: key);

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool IsFirst = true;
  @override
  void initState() {
    // TODO: implement initState
    mysh();
  }

  mysh() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    IsFirst = pref.getBool("IsFirst")!;
    print(IsFirst.toString() + "ISFirst");
  }

  @override
  Widget build(BuildContext context) {
    mysh();
    var myController = TextEditingController();

    return Scaffold(
      body: IsFirst
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: myController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "IP",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  ElevatedButton(
                    child: Text("OK"),
                    onPressed: () async {
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();

                      pref.setString("http", myController.text);
                      globals.mysh();
                      // globals.http = myController.text;
                      Navigator.of(context).pushNamed(login.name_route);
                    },
                  )
                ],
              ),
            )
          : login(),
    );
  }
}
