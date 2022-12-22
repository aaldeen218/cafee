import 'package:flutter/material.dart';

import '../MyHomeScreen.dart';
import '../pre_invoice/PreInvoice.dart';
import 'package:intl/intl.dart';

import 'categories_madule.dart';
import 'items_madule.dart';

class menu extends StatefulWidget {
  const menu({Key? key}) : super(key: key);
  static String name_route = "menu";

  @override
  State<menu> createState() => _addOrderState();
}

class _addOrderState extends State<menu> {
  late Future<List<Items>> futureAlbum;
  List<Items>? futureString;

  @override
  void initState() {
    setState(() {
      futureAlbum = items_madule.showdata();

      futureAlbum.then((value) => futureString = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetData(),
    );
  }

  GetData() {
    return Container(
      color: Colors.white,
      child: (FutureBuilder<List<Categories>>(
          future: categories_madule.showdata(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
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
          })),
    );
  }

  show(AsyncSnapshot<List<Categories>> snapshot, context) {
    Future<List<Items>> x = items_madule.showdata();

    return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, i) {
          int num = 0;
          List<Items> names = futureString!
              .where((element) => element.gname == snapshot.data![i].gname)
              .toList();
          return ExpansionTile(
            //  leading: Icon(CupertinoIcons.arrow_up_down_circle_fill),
            title: Text(
              snapshot.data![i].gname,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),

            children: names
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Text(
                              "(" + tomoney(e.pprice) + ")",
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.green),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              e.pname,
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 20),
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
