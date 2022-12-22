import 'package:flutter/material.dart';

class order extends StatefulWidget {
  const order({Key? key}) : super(key: key);
  static String name_route = "order";

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Order"),
      ),
    );
  }
}
