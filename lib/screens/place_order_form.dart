// import 'package:flutter/material.dart';

// class PlaceOrderForm extends StatefulWidget {
//   const PlaceOrderForm({Key? key}) : super(key: key);

//   @override
//   State<PlaceOrderForm> createState() => _PlaceOrderFormState();
// }

// class _PlaceOrderFormState extends State<PlaceOrderForm> {
//    final FocusScopeNode _node = FocusScopeNode();

//   final _form = GlobalKey<FormState>();

//    DateTime? date;

//   String? uploadDate;

//   String getText() {
//     if (date == null) {
//       return 'Select Date';
//     } else {
//       return DateFormat('dd/MM/yyyy').format(date!);
//     }
//   }

//    @override
//   void dispose() {
//     _node.dispose();
//     super.dispose();
//   }

//   Future<void> _submitForm() async {
//     final isValid = _form.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     _form.currentState!.save();
//     setState(() {
//       _isLoading = true;
//     });

//     if (_editProduct.id != null) {
//       await Provider.of<StockProvider>(context, listen: false)
//           .updateProduct(_editProduct.id!, _editProduct)
//           .then(
//             (_) => ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(
//                   'Product Updated.',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 backgroundColor: Colors.orange[400],
//               ),
//             ),
//           );
//       Navigator.of(context).pop();
//     } else {
//       try {
//         await Provider.of<StockProvider>(context, listen: false)
//             .addProduct(_editProduct)
//             .then(
//               (_) => ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     'Product Saved.',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                   backgroundColor: Colors.green,
//                 ),
//               ),
//             );
//       } catch (e) {
//         await showDialog<Null>(
//           context: context,
//           builder: (ctx) => AlertDialog(
//             title: Text('An Error occured!'),
//             content: Text('Something went wrong.'),
//             actions: [
//               TextButton(
//                 child: Text('Okay', style: TextStyle(color: Colors.red)),
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                 },
//               )
//             ],
//           ),
//         );
//       }
//     }
  
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Invoice Form')),
//     body: Expanded(
//                       child: SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             children: [
//                               FocusScope(
//                                 node: _node,
//                                 child: Form(
//                                   key: _form,
//                                   child: Column(
//                                     children: [
//                                       TextFormField(
//                                         initialValue: _initValues['title'],
//                                         decoration:
//                                             InputDecoration(labelText: 'Title'),
//                                         textInputAction: TextInputAction.next,
//                                         onEditingComplete: _node.nextFocus,
//                                         onSaved: (value) {
//                                           _editProduct = Product(
//                                             title: value!,
//                                             id: _editProduct.id,
//                                             color: _editProduct.color,
//                                             dateTime: _editProduct.dateTime,
//                                             gstNo: _editProduct.gstNo,
//                                             //imageUrl: _editProduct.imageUrl,
//                                             quantity: _editProduct.quantity,
//                                             rate: _editProduct.rate,
//                                             size: _editProduct.size,
//                                             supplier: _editProduct.supplier,
//                                             type: _editProduct.type,
//                                           );
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter a title.';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                       TextFormField(
//                                         initialValue: _initValues['size'],
//                                         decoration:
//                                             InputDecoration(labelText: 'Size'),
//                                         textInputAction: TextInputAction.next,
//                                         onEditingComplete: _node.nextFocus,
//                                         keyboardType: TextInputType.number,
//                                         onSaved: (value) {
//                                           _editProduct = Product(
//                                             title: _editProduct.title,
//                                             id: _editProduct.id,
//                                             color: _editProduct.color,
//                                             dateTime: _editProduct.dateTime,
//                                             gstNo: _editProduct.gstNo,
//                                             //imageUrl: _editProduct.imageUrl,
//                                             quantity: _editProduct.quantity,
//                                             rate: _editProduct.rate,
//                                             size: double.parse(value!),
//                                             supplier: _editProduct.supplier,
//                                             type: _editProduct.type,
//                                           );
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter the size.';
//                                           }
//                                           if (double.tryParse(value) == null) {
//                                             return 'Please enter a valid size.';
//                                           }

//                                           return null;
//                                         },
//                                       ),
//                                       TextFormField(
//                                         initialValue: _initValues['type'],
//                                         decoration:
//                                             InputDecoration(labelText: 'Type'),
//                                         textInputAction: TextInputAction.next,
//                                         onEditingComplete: _node.nextFocus,
//                                         onSaved: (value) {
//                                           _editProduct = Product(
//                                             title: _editProduct.title,
//                                             id: _editProduct.id,
//                                             color: _editProduct.color,
//                                             dateTime: _editProduct.dateTime,
//                                             gstNo: _editProduct.gstNo,
//                                             //imageUrl: _editProduct.imageUrl,
//                                             quantity: _editProduct.quantity,
//                                             rate: _editProduct.rate,
//                                             size: _editProduct.size,
//                                             supplier: _editProduct.supplier,
//                                             type: value!,
//                                           );
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter a type.';
//                                           }

//                                           return null;
//                                         },
//                                       ),
//                                       TextFormField(
//                                         initialValue: _initValues['quantity'],
//                                         decoration: InputDecoration(
//                                             labelText: 'Quantity'),
//                                         textInputAction: TextInputAction.next,
//                                         keyboardType: TextInputType.number,
//                                         onEditingComplete: _node.nextFocus,
//                                         onSaved: (value) {
//                                           _editProduct = Product(
//                                             title: _editProduct.title,
//                                             id: _editProduct.id,
//                                             color: _editProduct.color,
//                                             dateTime: _editProduct.dateTime,
//                                             gstNo: _editProduct.gstNo,
//                                             //imageUrl: _editProduct.imageUrl,
//                                             quantity: double.parse(value!),
//                                             rate: _editProduct.rate,
//                                             size: _editProduct.size,
//                                             supplier: _editProduct.supplier,
//                                             type: _editProduct.type,
//                                           );
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter a quantity.';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                       TextFormField(
//                                         initialValue: _initValues['color'],
//                                         decoration:
//                                             InputDecoration(labelText: 'Color'),
//                                         textInputAction: TextInputAction.next,
//                                         keyboardType: TextInputType.text,
//                                         onEditingComplete: _node.nextFocus,
//                                         onSaved: (value) {
//                                           _editProduct = Product(
//                                             title: _editProduct.title,
//                                             id: _editProduct.id,
//                                             color: value!,
//                                             dateTime: _editProduct.dateTime,
//                                             gstNo: _editProduct.gstNo,
//                                             //imageUrl: _editProduct.imageUrl,
//                                             quantity: _editProduct.quantity,
//                                             rate: _editProduct.rate,
//                                             size: _editProduct.size,
//                                             supplier: _editProduct.supplier,
//                                             type: _editProduct.type,
//                                           );
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter a color.';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                       TextFormField(
//                                         initialValue: _initValues['supplier'],
//                                         decoration: InputDecoration(
//                                             labelText: 'Supplier'),
//                                         textInputAction: TextInputAction.next,
//                                         onEditingComplete: _node.nextFocus,
//                                         onSaved: (value) {
//                                           _editProduct = Product(
//                                             title: _editProduct.title,
//                                             id: _editProduct.id,
//                                             color: _editProduct.color,
//                                             dateTime: _editProduct.dateTime,
//                                             gstNo: _editProduct.gstNo,
//                                             //imageUrl: _editProduct.imageUrl,
//                                             quantity: _editProduct.quantity,
//                                             rate: _editProduct.rate,
//                                             size: _editProduct.size,
//                                             supplier: value!,
//                                             type: _editProduct.type,
//                                           );
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter a supplier.';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                       const SizedBox(height: 32),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             'Date :',
//                                             style: TextStyle(
//                                                 fontSize: 15.sp,
//                                                 color: Colors.black),
//                                           ),
//                                           const SizedBox(width: 32),
//                                           ElevatedButton(
//                                             style: ElevatedButton.styleFrom(
//                                               elevation: 8,
//                                               padding: EdgeInsets.symmetric(
//                                                   horizontal: 24),
//                                             ),
//                                             child: Text(
//                                               getText(),
//                                               style: TextStyle(
//                                                 fontSize: 15.sp,
//                                               ),
//                                             ),
//                                             onPressed: () => pickDate(context),
//                                           )
//                                         ],
//                                       ),
//                                       TextFormField(
//                                         initialValue: _initValues['rate'],
//                                         decoration:
//                                             InputDecoration(labelText: 'Rate'),
//                                         textInputAction: TextInputAction.next,
//                                         keyboardType: TextInputType.number,
//                                         onEditingComplete: _node.nextFocus,
//                                         onSaved: (value) {
//                                           _editProduct = Product(
//                                             title: _editProduct.title,
//                                             id: _editProduct.id,
//                                             color: _editProduct.color,
//                                             dateTime: _editProduct.dateTime,
//                                             gstNo: _editProduct.gstNo,
//                                             //imageUrl: _editProduct.imageUrl,
//                                             quantity: _editProduct.quantity,
//                                             rate: double.parse(value!),
//                                             size: _editProduct.size,
//                                             supplier: _editProduct.supplier,
//                                             type: _editProduct.type,
//                                           );
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter a rate.';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                       TextFormField(
//                                         initialValue: _initValues['gstNo'],
//                                         decoration: InputDecoration(
//                                             labelText: 'GST No'),
//                                         onSaved: (value) {
//                                           _editProduct = Product(
//                                             title: _editProduct.title,
//                                             id: _editProduct.id,
//                                             color: _editProduct.color,
//                                             dateTime: _editProduct.dateTime,
//                                             gstNo: value!,
//                                             //imageUrl: _editProduct.imageUrl,
//                                             quantity: _editProduct.quantity,
//                                             rate: _editProduct.rate,
//                                             size: _editProduct.size,
//                                             supplier: _editProduct.supplier,
//                                             type: _editProduct.type,
//                                           );
//                                         },
//                                         validator: (value) {
//                                           if (value!.isEmpty) {
//                                             return 'Please enter a GST no.';
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                       const SizedBox(height: 25),
//                                       ElevatedButton(
//                                         style: ElevatedButton.styleFrom(
//                                           minimumSize: Size(80.w, 50),
//                                           primary: Colors.amber,
//                                           elevation: 8,
//                                         ),
//                                         onPressed: () => _submitForm(),
//                                         child: Text(
//                                           'Save',
//                                           style: TextStyle(
//                                             fontSize: 20,
//                                             color: Colors.grey[800],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               ]  ),
//                         ),
//                       ),
//     ),
//     );
//   }
// }
