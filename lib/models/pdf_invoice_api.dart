import 'dart:io';

import 'package:grocery_app/models/invoice.dart';
import 'package:grocery_app/models/pdf_api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildTitle(invoice),
        ],
      ),
    );
    return PdfApi.saveDocument(name: 'Grocery_invoice.pdf', pdf: pdf);
  }

  static Widget buildTitle(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'INVOICE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text(invoice.info.description),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );
}
