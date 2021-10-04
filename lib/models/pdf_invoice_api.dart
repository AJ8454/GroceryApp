import 'dart:io';

import 'package:grocery_app/models/invoice.dart';
import 'package:grocery_app/models/pdf_api.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import 'customer.dart';
import 'supplier.dart';

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();

    pdf.addPage(
      MultiPage(
        build: (context) => [
          buildHeader(invoice),
          SizedBox(height: 3 * PdfPageFormat.cm),
          buildTitle(invoice),
          buildInvoice(invoice),
          Divider(),
          buildTotal(invoice),
        ],
        footer: (context) => buildFooter(invoice),
      ),
    );
    return PdfApi.saveDocument(name: 'Grocery_invoice.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.supplier),
              Container(
                height: 50,
                width: 50,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: 'Pandit',
                ),
              ),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name!, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(customer.address!),
        ],
      );

  static Widget buildInvoiceInfo(InvoiceInfo info) {
    final titles = <String>[
      'Invoice Date:',
    ];
    final data = <String>[DateFormat.yMd().format(info.date)];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(titles.length, (index) {
        final title = titles[index];
        final value = data[index];

        return buildText(title: title, value: value, width: 200);
      }),
    );
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

  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'Product Name',
      'Quantity',
      'Unit Price',
      'Total',
    ];

    final data = invoice.items.map((item) {
      final total = item.unitPrice * item.quantity;
      return [
        item.name,
        '${item.quantity}',
        '${item.unitPrice}',
        total.toStringAsFixed(2),
      ];
    }).toList();

    return Table.fromTextArray(
      data: data,
      headers: headers,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: const BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.unitPrice * item.quantity)
        .reduce((item1, item2) => item1 + item2);

    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildText(
                  title: 'Total amount due',
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  value: '$netTotal',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          )
        ],
      ),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }

  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(
            title: 'Thank You for buying Products from Grocery App',
            value: ' ',
          ),
        ],
      );

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }
}
