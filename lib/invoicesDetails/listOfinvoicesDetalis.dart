import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'invoicesModule.dart';

class listOfinvoicesDetalis extends StatefulWidget {
  const listOfinvoicesDetalis({Key? key}) : super(key: key);
  static String name_route = "listOfinvoicesDetalis";

  @override
  State<listOfinvoicesDetalis> createState() => _ListOfinvoicesState();
}

class _ListOfinvoicesState extends State<listOfinvoicesDetalis> {
  var inputFormatDate = DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Card(
              color: Colors.blueGrey,
              elevation: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "الاجمالي",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "الكمية",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "اسم الصنف",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Expanded(child: GetData(context))
          ],
        ),
      ),
    );
  }

  GetData(ctx) {
    final arg_home =
        ModalRoute.of(ctx)!.settings.arguments as Map<String, Object>;
    return (FutureBuilder<List<InvoicesDetails>>(
        future: invoicesModule.showdata(arg_home["bid"]),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
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
                child: show(snapshot, context),
              )),
            );
          }
        }));
  }

  show(AsyncSnapshot<List<InvoicesDetails>> snapshot, context) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          tomoney(snapshot.data![i].total),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          snapshot.data![i].qty,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          snapshot.data![i].pname,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.blue,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(
              color: Colors.black26,
              indent: 10,
              endIndent: 10,
            )
          ],
        );
      },
    );
  }
}

tomoney(String number) {
  final oCcy = NumberFormat("#,##0", "en_US");
  return oCcy.format(double.parse(number));
}
