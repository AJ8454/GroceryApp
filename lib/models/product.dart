import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String? id;
  final String? title;
  final String? description;
  final double? rate;
  final String imageUrl;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.rate,
    required this.imageUrl,
  });
}
