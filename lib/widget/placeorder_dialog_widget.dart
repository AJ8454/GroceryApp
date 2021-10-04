import 'package:flutter/material.dart';
import 'package:grocery_app/models/customer.dart';
import 'package:grocery_app/models/invoice.dart';
import 'package:grocery_app/models/pdf_api.dart';
import 'package:grocery_app/models/pdf_invoice_api.dart';
import 'package:grocery_app/models/supplier.dart';

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
  List<InvoiceItem> dataInvoice = [];

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
          name: 'Samarth Pandit',
          address: 'NalaSupara',
          sMobNumber: '9654781325',
        ),
        customer: Customer(
          name: fNameController.text,
          cMobNumber: phoneNumberController.text,
          address: addressController.text,
        ),
        info: InvoiceInfo(
          description: 'xyz description',
          date: date,
        ),
        items: const [
          InvoiceItem(name: 'Rice', quantity: 5, unitPrice: 900),
          InvoiceItem(name: 'Rice', quantity: 5, unitPrice: 900),
          InvoiceItem(name: 'Rice', quantity: 5, unitPrice: 900),
          InvoiceItem(name: 'Rice', quantity: 5, unitPrice: 900),
        ]);

    final pdfFile = await PdfInvoiceApi.generate(invoice);

    PdfApi.openFile(pdfFile);
    //Navigator.of(context).pop();
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
