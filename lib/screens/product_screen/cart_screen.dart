import 'package:flutter/material.dart';
import 'package:grocery_app/provider/cart_provider.dart';
import 'package:grocery_app/utility/constant.dart';
import 'package:grocery_app/widget/cart_item.dart';
import 'package:grocery_app/widget/placeorder_dialog_widget.dart';
import 'package:provider/provider.dart';

import '../place_order_form.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Chip(
              label: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Total : ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '\u{20B9} ${cart.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              backgroundColor: kCarrotColor,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, i) => CartItemView(
                id: cart.items.values.toList()[i].id!,
                title: cart.items.values.toList()[i].title,
                price: cart.items.values.toList()[i].price,
                quantity: cart.items.values.toList()[i].quantity,
                imageUrl: cart.items.values.toList()[i].imageUrl,
                productId: cart.items.keys.toList()[i],
              ),
            ),
          )
        ],
      ),
      bottomSheet: cart.totalAmount == 0.0
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: OrderButton(cart: cart),
            ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartProvider cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 50),
      ),
      onPressed: () => showDialog(
        context: context,
        builder: (ctx) => const PlaceOrderDialogWidget(),
      ),
      child: const Text(
        'PLACE ORDER',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
