import 'dart:math';

import 'package:cafee/pre_invoice/PreInvoice.dart';
import 'package:cafee/menu/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Login/login.dart';
import 'Order/addOrder.dart';
import 'OrderDetails/OrderInvoiceDetalis.dart';
import 'invoices/listOfinvoices.dart';
import 'mainColor.dart';
import 'order.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uid = "";
String ufullname = "";
String user_name = "";
String pname = "";

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);
  static String name_route = "MyHomeScreen";

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  var myController = TextEditingController();
  var inputFormatDate = DateFormat('yyyy-MM-dd');
  var inputFormatTime = DateFormat('HH:MM');
  int index = 0;
  final _pageViewController = PageController();

  @override
  void initState() {
    Getmyshare();
  }

  Getmyshare() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      uid = pref.getString("uid")!;
      ufullname = pref.getString("ufullname")!;
      user_name = pref.getString("user_name")!;
      pname = pref.getString("pname")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: appBarColor2,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        CupertinoIcons.person_circle,
                        color: Colors.blueGrey,
                      ),
                      iconSize: 40,
                      onPressed: () {
                        final Alert = AlertDialog(
                          title: Column(
                            children: [
                              Text(
                                "معلومات المستخدم",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              Divider(
                                height: 2,
                                thickness: 1,
                                color: Colors.black,
                              ),
                              Text(
                                ufullname,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
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
                                              Color(0xfff8dfdf),
                                            ),
                                          ),
                                          onPressed: () {
                                            clear_pref();

                                            Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                                    login.name_route);
                                          },
                                          child: Text("تسجيل الخروج")),
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
                                          onPressed: () {
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
                    ),
                    Text(
                      pname,
                      style: TextStyle(
                          fontFamily: "Digi-Madasi-Bold", fontSize: 20),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  onPageChanged: (x) => setState(() {
                    index = x;
                  }),
                  children: [
                    Scaffold(
                      body: GetData(),
                      floatingActionButton: FloatingActionButton(
                        tooltip: "اضافة طاولة",
                        backgroundColor: Colors.white,
                        onPressed: () {
                          final Alert = AlertDialog(
                            title: Column(
                              children: const [
                                Text(
                                  "اضافة طاولة جديدة",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            content: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: myController,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: "رقم الطاولة",
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
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
                                                Color(0xfff8dfdf),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("الغاء")),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              foregroundColor:
                                                  MaterialStateProperty.all(
                                                      Color(0xff000000)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                Color(0xffffffff),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (myController
                                                  .text.isNotEmpty) {
                                                var p = PreInvoices(
                                                    bid: "B-" +
                                                        randomInt(1000000,
                                                                9999999)
                                                            .toString(),
                                                    bdate: DateTime.now(),
                                                    cname: "cname",
                                                    btotal: 0,
                                                    bnote: myController.text,
                                                    bstat: "bstat",
                                                    uid: uid,
                                                    un: "User_Pc_Convert_invoice");

                                                PreInvoices_class.insertData(p);
                                                print(p.un);

                                                Navigator.of(context).pop();
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        MyHomeScreen
                                                            .name_route);
                                              }
                                            },
                                            child: Text("اضافة طلب جديد")),
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
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.green,
                          size: 35,
                        ),
                      ),
                    ),
                    menu(),
                    ListOfinvoices(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          backgroundColor: appBarColor2,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          animationDuration: Duration(milliseconds: 1500),
          selectedIndex: index,
          height: 60,
          onDestinationSelected: (x) => setState(() {
            // setState(() {
            //   index = x;
            // });
            _pageViewController.animateToPage(x,
                duration: Duration(milliseconds: 2000),
                curve: Curves.elasticOut);
          }),
          destinations: const [
            NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.white,
                ),
                selectedIcon: Icon(Icons.home),
                label: "الطبات"),
            NavigationDestination(
                icon: Icon(
                  CupertinoIcons.square_list,
                  color: Colors.white,
                ),
                selectedIcon: Icon(CupertinoIcons.square_list_fill),
                label: "المينيو"),
            NavigationDestination(
                icon: Icon(
                  Icons.history_outlined,
                  color: Colors.white,
                ),
                selectedIcon: Icon(
                  Icons.history,
                ),
                label: "السابقة "),
          ],
        ));
  }

  int randomInt(int min, int max) {
    return Random().nextInt(max - min + 1) + min;
  }

  GetData() {
    return Container(
      color: Colors.white,
      child: (FutureBuilder<List<PreInvoices>>(
          future: PreInvoices_class.showdata(uid),
          builder: (context, snapshot) {
            if (snapshot.data == null || uid == "") {
              return (Center(
                child: snapshot.connectionState == ConnectionState.waiting
                    ? CircularProgressIndicator(
                        color: Colors.amberAccent,
                      )
                    : Text("No Item Now"),
              ));
            } else {
              return Center(
                child: (Container(
                  margin: EdgeInsets.all(10),
                  child: show(snapshot, context),
                )),
              );
            }
          })),
    );
  }

  show(AsyncSnapshot<List<PreInvoices>> snapshot, context) {
    return GridView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(OrderInvoiceDetalis.name_route,
                arguments: {
                  "total": snapshot.data![i].btotal,
                  "ID": snapshot.data![i].bid
                });
          },
          child: Card(
            elevation: 3,
            color: Color(0xFFDAF1EC),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "طاولة  " + snapshot.data![i].bnote,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        inputFormatDate.format(snapshot.data![i].bdate),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.blue,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        inputFormatTime.format(snapshot.data![i].bdate),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "الاجمالي " +
                            tomoney(snapshot.data![i].btotal.toString()),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed(
                                  addOrder.name_route,
                                  arguments: {
                                    "ID": snapshot.data![i].bid,
                                    "table": snapshot.data![i].bnote
                                  });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/add_order.png',
                                  height: 50,
                                  width: 50,
                                ),
                                Icon(Icons.playlist_add),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
    );
  }
}

tomoney(String number) {
  final oCcy = NumberFormat("#,##0", "en_US");
  return oCcy.format(double.parse(number));
}
