import 'package:flutter/material.dart';
import 'package:grocery_app/widget/userdetail_form_widget.dart';

class PlaceOrderDialogWidget extends StatelessWidget {
  const PlaceOrderDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Place New Order',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              SizedBox(height: 8),
              UserDetailFormWidget(),
            ],
          ),
        ),
      );
}
