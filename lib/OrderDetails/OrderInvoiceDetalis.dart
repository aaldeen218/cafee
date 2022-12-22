import 'package:cafee/mainColor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'OrderModels.dart';

class OrderInvoiceDetalis extends StatelessWidget {
  const OrderInvoiceDetalis({Key? key}) : super(key: key);
  static String name_route = "OrderInvoiceDetalis";

  @override
  Widget build(BuildContext context) {
    final arg_home =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: appBarColor2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "اجمالي الفاتورة\n",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        tomoney(arg_home["total"].toString()),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFFA63737),
                            fontSize: 23,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                )),
            Expanded(flex: 4, child: GetData(context)),
          ],
        ),
      ),
    );
  }
}

GetData(ctx) {
  final arg_home =
      ModalRoute.of(ctx)!.settings.arguments as Map<String, Object>;
  return (FutureBuilder<List<OrderModels>>(
      future: OrderModels_class.showdata(arg_home["ID"].toString()),
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

show(AsyncSnapshot<List<OrderModels>> snapshot, context) {
  return ListView.builder(
    itemCount: snapshot.data!.length,
    itemBuilder: (context, i) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tomoney(snapshot.data![i].total.toString()),
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFA63737),
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  snapshot.data![i].pname,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                ),
                Text(
                  snapshot.data![i].qty.toString(),
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 20,
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Divider(),
        ],
      );
    },
  );
}

tomoney(String number) {
  final oCcy = NumberFormat("#,##0", "en_US");
  return oCcy.format(double.parse(number));
}
