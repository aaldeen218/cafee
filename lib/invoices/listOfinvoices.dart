import 'package:cafee/invoicesDetails/listOfinvoicesDetalis.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dimension.dart';
import '../mainColor.dart';
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
  var inputFormatDate = DateFormat('yyyy-MM-dd || HH:mm:ss');

  @override
  void initState() {
    Getmyshare();
    var inputFormat = DateFormat('yyyy-MM-dd 04:00:00');
    var date_now = inputFormat.format(DateTime.now());

    var date_now2 = inputFormat.format(DateTime.now().add(Duration(hours: 28)));
    date1 = date_now;
    date2 = date_now2;
    print(date1);
    print(date2);
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
          size: Dimensions.Size_30,
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
      initialDateRange: dateRange ?? initialDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appBarColor2, // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.blueAccent, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    return (setState(() {
      dateRange = newDateRange!;
      var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
      date1 = inputFormat.format(newDateRange.start.add(Duration(hours: 4)));
      date2 = inputFormat.format(newDateRange.end.add(Duration(hours: 28)));
      (setState(() {
        var inputFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
        date1 = inputFormat.format(newDateRange.start.add(Duration(hours: 4)));
        date2 = inputFormat.format(newDateRange.end.add(Duration(hours: 28)));
        print(date1.toString());
        print(date2.toString());
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
                              style: TextStyle(fontSize: Dimensions.Size_20),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.Size_10 / 2)),
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
                            fontSize: Dimensions.Size_30 / 2,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "الاجمالي " +
                            tomoney(snapshot.data![i].btotal.toString()),
                        style: TextStyle(
                            fontSize: Dimensions.Size_30 / 2,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        inputFormatDate.format(snapshot.data![i].bdate),
                        style: TextStyle(
                            fontSize: Dimensions.Size_30 / 2,
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
