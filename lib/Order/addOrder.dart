import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MyHomeScreen.dart';
import '../mainColor.dart';
import '../pre_invoice/PreInvoice.dart';
import 'package:intl/intl.dart';

import 'categories_madule.dart';
import 'items_madule.dart';
import 'newItemOrder.dart';
import 'print.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addOrder extends StatefulWidget {
  const addOrder({Key? key}) : super(key: key);
  static String name_route = "addOrder";

  @override
  State<addOrder> createState() => _addOrderState();
}

class _addOrderState extends State<addOrder> {
  late Future<List<Items>> futureAlbum;
  List<Items>? futureString;

  Getmyshare() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    ufullname = pref.getString("ufullname")!;
    print(ufullname);
  }

  @override
  void initState() {
    futureAlbum = items_madule.showdata();
    futureAlbum.then((value) => futureString = value);
    Getmyshare();
  }

  @override
  Widget build(BuildContext context) {
    //  futureAlbum = items_madule.showdata();
    //futureAlbum.then((value) => futureString = value);
    final arg_home =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    print(arg_home["table"].toString() + "1----------------");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor2,
        actions: [
          TextButton.icon(
              icon: Icon(
                Icons.print,
                color: Colors.white,
              ),
              onPressed: () {
                save_data(arg_home, true);
              },
              label: Text(
                "حفظ وطباعة ",
                style: TextStyle(color: Colors.white),
              )),
          TextButton.icon(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              save_data(arg_home, false);
            },
            label: Text(
              "حفظ",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        leading: TextButton(
          child: Text(
            "رجوع",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).popAndPushNamed(MyHomeScreen.name_route);
          },
        ),
      ),
      body: GetData(),
    );
  }

  void save_data(Map<String, Object> arg_home, bool print) {
    List<NewitemsOrder> dd2 = [];

    Iterable<Items>? h = futureString?.where((element) => element.coun > 0);
    h?.forEach((element) {
      dd2.add(
        NewitemsOrder(
            pid: element.pid,
            bid: arg_home["ID"].toString(),
            qty: element.coun,
            price: element.pprice,
            total: element.coun * element.pprice,
            name: element.pname,
            uname: ufullname,
            table: arg_home["table"].toString()),
      );
    });
    // var dd = <NewitemsOrder>[

    // ];
    NewItemOrder.insertItemsData(dd2);
    print
        ? {
            Navigator.of(context).popAndPushNamed(MyHomeScreen.name_route),
            print_pos().createPdf(dd2)
          }
        : Navigator.of(context).popAndPushNamed(MyHomeScreen.name_route);
  }

  GetData() {
    return (FutureBuilder<List<Categories>>(
        future: categories_madule.showdata(),
        builder: (context, snapshot) {
          if (snapshot.data == null || futureString == null) {
            return (Center(
              child: CircularProgressIndicator(
                color: Colors.amberAccent,
              ),
            ));
          } else {
            return Center(
              child: (Container(
                child: show(snapshot, context),
              )),
            );
          }
        }));
  }

  show(AsyncSnapshot<List<Categories>> snapshot, context) {
    Future<List<Items>> x = items_madule.showdata();

    return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, i) {
          int num = 0;
          List<Items>? names = futureString
              ?.where((element) => element.gname == snapshot.data![i].gname)
              .toList();
          return ExpansionTile(
            //  leading: Icon(CupertinoIcons.arrow_up_down_circle_fill),
            title: Text(
              snapshot.data![i].gname,
              textAlign: TextAlign.right,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            children: names!
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              e.coun.toString() == "0" ? "" : e.coun.toString(),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                Text(
                                  e.pname,
                                  style: TextStyle(fontSize: 20),
                                ),
                                Text(
                                  " (" + tomoney(e.pprice.toString()) + ")",
                                  style: TextStyle(
                                      fontSize: 12, color: Color(0xDCCC1515)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  e.coun++;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.add_circled_solid,
                                size: 30,
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  e.coun > 0 ? e.coun-- : 0;
                                });
                              },
                              child: Icon(
                                CupertinoIcons.minus_circle_fill,
                                size: 30,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          );
        });
  }
}

tomoney(String number) {
  final oCcy = NumberFormat("#,##0", "en_US");
  return oCcy.format(double.parse(number));
}

getlist() {
  List<Items> names = [];
  Future<List<Items>> x = items_madule.showdata();
  x.then((value) => names = value);
  print(names.length);
  return names;

  // x.then((value) {
  //   print(value);
  // });
}
