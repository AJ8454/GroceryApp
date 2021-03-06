import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnackBarWidget {
  static void showSnackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
}
