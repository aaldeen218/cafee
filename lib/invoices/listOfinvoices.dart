import 'package:cafee/invoicesDetails/listOfinvoicesDetalis.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'invoicesModule.dart';

String uid = "";
var inputFormat = DateFormat('yyyy-MM-dd');
var date_now = inputFormat.format(DateTime.now());
var date1 = date_now;
var date2 = date_now;

class ListOfinvoices extends StatefulWidget {
  const ListOfinvoices({Key? key}) : super(key: key);

  @override
  State<ListOfinvoices> createState() => _ListOfinvoicesState();
}

class _ListOfinvoicesState extends State<ListOfinvoices> {
  var inputFormatDate = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    Getmyshare();
    var inputFormat = DateFormat('yyyy-MM-dd');
    var date_now = inputFormat.format(DateTime.now());
    date1 = date_now;
    date2 = date_now;
  }

  Getmyshare() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      uid = pref.getString("uid")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetData(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          picdateTimeRange(context);
        },
        child: Icon(
          Icons.calendar_today_outlined,
          color: Color(0xFFDB5151),
          size: 30,
        ),
      ),
    );
  }

  Future picdateTimeRange(BuildContext context) async {
    final initialDateRange =
        DateTimeRange(start: DateTime.now(), end: DateTime.now());
    var dateRange;
    final newDateRange = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2018),
        lastDate: DateTime(2025),
        initialDateRange: dateRange ?? initialDateRange);

    return (setState(() {
      dateRange = newDateRange!;
      var inputFormat = DateFormat('yyyy-MM-dd');
      date1 = inputFormat.format(newDateRange.start);
      date2 = inputFormat.format(newDateRange.end);
      (setState(() {
        var inputFormat = DateFormat('yyyy-MM-dd');
        date1 = inputFormat.format(newDateRange.start);
        date2 = inputFormat.format(newDateRange.end);
      }));
    }));
  }

  GetData() {
    return Container(
      color: Colors.white,
      child: (FutureBuilder<List<Invoices>>(
          future: LoginModule.showdata(uid, date1, date2),
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
                child: Column(
                  children: [
                    Expanded(
                      child: (Container(
                        child: show(snapshot, context),
                      )),
                    ),
                    sumVal(snapshot.data) != "0"
                        ? Container(
                            width: double.infinity,
                            color: Colors.black26.withOpacity(0.2),
                            child: Text(
                              "الاجمالي " + sumVal(snapshot.data),
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            ))
                        : Text(""),
                  ],
                ),
              );
            }
          })),
    );
  }

  show(AsyncSnapshot<List<Invoices>> snapshot, context) {
    return ListView.builder(
      itemCount: snapshot.data!.length,
      itemBuilder: (context, i) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(listOfinvoicesDetalis.name_route,
                arguments: {"bid": snapshot.data![i].bid});
          },
          child: Card(
            color: Colors.teal[300],
            elevation: 3,
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
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "الاجمالي " +
                            tomoney(snapshot.data![i].btotal.toString()),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        inputFormatDate.format(snapshot.data![i].bdate),
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

tomoney(String number) {
  final oCcy = NumberFormat("#,##0", "en_US");
  return oCcy.format(double.parse(number));
}

String sumVal(List<Invoices>? data) {
  if (data!.isEmpty) return "0";
  double sum = 0.0;

  data.forEach((element) {
    sum += element.btotal;
  });
  return tomoney(sum.toString());
}
