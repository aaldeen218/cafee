// ignore_for_file: public_member_api_docs

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'newItemOrder.dart';
import 'table.dart';

class print_pos {
  /// create PDF & print it
  void createPdf(List<NewitemsOrder> data) async {
    final doc = pw.Document();
    final ttf = await fontFromAssetBundle('assets/font/arial.ttf');

    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');
    data.forEach((element) {
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.roll80,
          build: (pw.Context context) {
            return (pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(element.bid,
                      textDirection: pw.TextDirection.ltr,
                      style: pw.TextStyle(
                          font: ttf,
                          fontSize: 12,
                          fontWeight: pw.FontWeight.bold)),
                  pw.Table(
                      columnWidths: const {
                        0: pw.FractionColumnWidth(0.2),
                        1: pw.FractionColumnWidth(0.8),
                      },
                      border: pw.TableBorder.all(),
                      children: [
                        pw.TableRow(children: <pw.Widget>[
                          pw.Center(
                            child: pw.Text("العدد",
                                textDirection: pw.TextDirection.rtl,
                                style: pw.TextStyle(
                                    font: ttf,
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                          pw.Center(
                            child: pw.Text("العنصر",
                                textDirection: pw.TextDirection.rtl,
                                style: pw.TextStyle(
                                    font: ttf,
                                    fontSize: 20,
                                    fontWeight: pw.FontWeight.bold)),
                          ),
                        ]),
                        pw.TableRow(children: <pw.Widget>[
                          pw.Center(
                              child: pw.Text(element.qty.toString(),
                                  textDirection: pw.TextDirection.rtl,
                                  style:
                                      pw.TextStyle(font: ttf, fontSize: 15))),
                          pw.Center(
                              child: pw.Text(
                            element.name,
                            textDirection: pw.TextDirection.rtl,
                            style: pw.TextStyle(
                              font: ttf,
                              fontSize: 15,
                            ),
                          )),
                        ]),
                      ]),
                  pw.Text(
                    "الويتر " + element.uname,
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(font: ttf, fontSize: 10),
                  ),
                  pw.Text(
                    "رقم الطاولة " + "{ " + element.table + " }",
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(font: ttf, fontSize: 10),
                  ),
                  pw.Text(
                    DateFormat('a ss:mm:hh  | yyyy-MM-dd  ')
                        .format(DateTime.now()),
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(font: ttf, fontSize: 10),
                  ),
                ]));
          },
        ),
      );
    });

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );

    /// share the document to other applications:
    // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
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
}
