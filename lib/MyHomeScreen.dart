import 'dart:math';

import 'package:cafee/dimension.dart';
import 'package:cafee/pre_invoice/PreInvoice.dart';
import 'package:cafee/menu/menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  var inputFormatDate = DateFormat('yyyy-MM-dd'); n
  var inputFormatTime = DateFormat('HH:mm');
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
                height: Dimensions.homePageAppHeight,
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
                        color: Colors.white,
                      ),
                      iconSize: Dimensions.homePageIconSize,
                      onPressed: () {
                        final Alert = AlertDialog(
                          title: Column(
                            children: [
                              Text(
                                "معلومات المستخدم",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fontSize_15),
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
                                    fontSize: Dimensions.Size_20,
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
                                          child: Text(
                                            "تسجيل الخروج",
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.fontSize_15),
                                          )),
                                      SizedBox(
                                        width: Dimensions.Size_10,
                                      ),
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
                                          child: Text(
                                            "موافق",
                                            style: TextStyle(
                                                fontSize:
                                                    Dimensions.fontSize_15),
                                          )),
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
                          color: Color(0xFFFFFFFF),
                          fontFamily: "Digi-Madasi-Bold",
                          fontSize: Dimensions.homePagefontSizeHedar),
                    ),
                    SizedBox(
                      width: Dimensions.homePageIconSize,
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
                        elevation: 5,
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
                                                    cname: ufullname,
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
                          Icons.add,
                          color: appBarColor2,
                          size: Dimensions.Size_30,
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
        bottomNavigationBar: Container(
          height: Dimensions.Size_50 * 1.5,
          decoration: BoxDecoration(
              color: appBarColor2,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.Size_50))),
          child: NavigationBar(
            backgroundColor: Colors.white.withOpacity(0.1),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            animationDuration: Duration(milliseconds: 1000),
            selectedIndex: index,
            height: Dimensions.Size_60,
            onDestinationSelected: (x) => setState(() {
              // setState(() {
              //   index = x;
              // });
              _pageViewController.animateToPage(x,
                  duration: Duration(milliseconds: 1500),
                  curve: Curves.elasticOut);
            }),
            destinations: [
              NavigationDestination(
                  tooltip: "الطلبات",
                  icon: Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: Dimensions.Size_30,
                  ),
                  selectedIcon: Icon(
                    Icons.home,
                    size: Dimensions.Size_30,
                  ),
                  label: ""),
              NavigationDestination(
                  tooltip: "المنيو",
                  icon: Icon(
                    CupertinoIcons.square_list,
                    color: Colors.white,
                    size: Dimensions.Size_30,
                  ),
                  selectedIcon: Icon(
                    CupertinoIcons.square_list_fill,
                    size: Dimensions.Size_30,
                  ),
                  label: ""),
              NavigationDestination(
                  tooltip: "الفواتير السابقة",
                  icon: Icon(
                    Icons.history_outlined,
                    color: Colors.white,
                    size: Dimensions.Size_30,
                  ),
                  selectedIcon: Icon(
                    Icons.history,
                    size: Dimensions.Size_30,
                  ),
                  label: ""),
            ],
          ),
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
                  margin: EdgeInsets.all(Dimensions.Size_10),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.Size_10 / 2)),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "طاولة  " + snapshot.data![i].bnote,
                      style: TextStyle(
                          fontSize: Dimensions.fontSize_15,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      inputFormatDate.format(snapshot.data![i].bdate),
                      style: TextStyle(
                          fontSize: Dimensions.fontSize_15,
                          color: Colors.blue,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      inputFormatTime.format(snapshot.data![i].bdate),
                      style: TextStyle(
                          fontSize: Dimensions.fontSize_15,
                          color: Colors.black,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "الاجمالي " +
                          tomoney(snapshot.data![i].btotal.toString()),
                      style: TextStyle(
                          fontSize: Dimensions.fontSize_15,
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
                                height: Dimensions.Size_50,
                                width: Dimensions.Size_50,
                              ),
                              Icon(Icons.playlist_add),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: Dimensions.Size_20,
                    height: Dimensions.Size_20,
                    child: Text(
                      snapshot.data![i].count_iinvoice.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: Dimensions.Size_10,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.Size_10 / 2),
                        color: Colors.redAccent.withOpacity(0.8)),
                  ),
                )
              ],
            ),
          ),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Get.context!.width < 900 ? 2 : 3,
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
