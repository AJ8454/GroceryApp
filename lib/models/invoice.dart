import 'package:grocery_app/models/cart.dart';

import 'customer.dart';
import 'supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
    required this.info,
    required this.supplier,
    required this.customer,
    required this.items,
  });
}

class InvoiceInfo {
  final String description;
  final DateTime date;

  const InvoiceInfo({
    required this.description,
    required this.date,
  });
}

class InvoiceItem {
  final String name;
  final int quantity;
  final double unitPrice;

  const InvoiceItem({
    required this.name,
    
    required this.quantity,
    
    required this.unitPrice,
  });
}