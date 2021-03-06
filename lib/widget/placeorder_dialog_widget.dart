import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:grocery_app/models/customer.dart';
import 'package:grocery_app/models/invoice.dart';
import 'package:grocery_app/models/pdf_api.dart';
import 'package:grocery_app/models/pdf_invoice_api.dart';
import 'package:grocery_app/models/supplier.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:provider/provider.dart';

class PlaceOrderDialogWidget extends StatefulWidget {
  const PlaceOrderDialogWidget({Key? key}) : super(key: key);

  @override
  State<PlaceOrderDialogWidget> createState() => _PlaceOrderDialogWidgetState();
}

class _PlaceOrderDialogWidgetState extends State<PlaceOrderDialogWidget> {
  final FocusScopeNode _node = FocusScopeNode();
  final _form = GlobalKey<FormState>();
  TextEditingController fNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    final date = DateTime.now();
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    final invoice = Invoice(
      supplier: const Supplier(
        name: 'Grocery App',
        address: 'Online Food and Grocey Store',
        sMobNumber: 'Contact:  9654781325',
      ),
      customer: Customer(
        name: fNameController.text,
        cMobNumber: phoneNumberController.text,
        address: addressController.text,
      ),
      info: InvoiceInfo(
        description: 'Payment Mode: CASH',
        date: date,
      ),
      items: _cartData(),
    );

    final pdfFile = await PdfInvoiceApi.generate(invoice);

    PdfApi.openFile(pdfFile);

    Phoenix.rebirth(context);
  }

  _cartData() {
    final provider = Provider.of<CartProvider>(context, listen: false);
    final cartData = List.generate(
      provider.items.length,
      (i) => InvoiceItem(
          name: provider.items.values.toList()[i].title,
          quantity: provider.items.values.toList()[i].quantity,
          unitPrice: provider.items.values.toList()[i].price),
    );

    return cartData;
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Invoice Form',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8),
              FocusScope(
                node: _node,
                child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: fNameController,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _node.nextFocus,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: phoneNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Phone Number',
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _node.nextFocus,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a phone number.';
                          } else if (value.length < 10) {
                            return 'Please enter correct number.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(
                          labelText: 'Address',
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a address.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => _submitForm(),
                        child: const Text('Generate Invoice'),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
