import 'package:cafee/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Login/login.dart';
import 'Login/settings.dart';
import 'MyHomeScreen.dart';
import 'Order/addOrder.dart';
import 'OrderDetails/OrderInvoiceDetalis.dart';
import 'invoicesDetails/listOfinvoicesDetalis.dart';
import 'mainColor.dart';
import 'order.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: appBarColor2,
      systemNavigationBarContrastEnforced: true,
      // Use [light] for white status bar and [dark] for black status bar.
      statusBarIconBrightness: Brightness.light,
      // For iOS.
      // Use [dark] for white status bar and [light] for black status bar.
      statusBarBrightness: Brightness.dark,
    ),
    // Use [light] for white status bar and [dark] for black status bar.
  );
  runApp(MaterialApp(
    theme: ThemeData(
      accentColor: Colors.green,
      scaffoldBackgroundColor: Color(0xFFF2F0E4),
      fontFamily: "kufi",
    ),
    debugShowCheckedModeBanner: false,
    home: login(),
    routes: {
      MyHomeScreen.name_route: (context) => MyHomeScreen(),
      order.name_route: (context) => order(),
      addOrder.name_route: (context) => addOrder(),
      OrderInvoiceDetalis.name_route: (context) => OrderInvoiceDetalis(),
      login.name_route: (context) => login(),
      listOfinvoicesDetalis.name_route: (context) => listOfinvoicesDetalis(),
      settings.name_route: (context) => settings(),
    },
  ));
}
