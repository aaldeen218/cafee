import 'package:flutter/material.dart';

alla() {
  return Table(
    columnWidths: const {
      0: FractionColumnWidth(0.2),
      1: FractionColumnWidth(0.8),
    },
    border: TableBorder.all(),
    children: [
      buildRow(['العدد', 'العنصر'], true),
      buildRow(['2', 'شيشة نعناع'], false)
    ],
  );
}

TableRow buildRow(List<String> cells, bool isHeader) => TableRow(
    children: cells
        .map((e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                e,
                style: TextStyle(
                    fontSize: isHeader ? 25 : 18,
                    fontWeight: isHeader ? FontWeight.bold : null),
              )),
            ))
        .toList());
