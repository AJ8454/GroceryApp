import 'package:flutter/material.dart';
import 'package:grocery_app/utility/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text(kApptitle, style: kAppbarTextStyle),
      ),
    );
  }
}