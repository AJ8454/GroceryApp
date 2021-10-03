import 'package:flutter/material.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/widget/home_screen_widget/grid_items.dart';
import 'package:provider/provider.dart';

import '../snack_bar.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({Key? key}) : super(key: key);

  Future<void> fetchAllProducts(context) async {
    try {
      await Provider.of<ProductProvider>(context).fetchAndSetProducts();
    } catch (error) {
      SnackBarWidget.showSnackBar(
        context,
        'No Product added yet.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductProvider>(context);
    return RefreshIndicator(
      onRefresh: () => fetchAllProducts(context),
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.5,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: productData.items.length,
        itemBuilder: (context, i) => GridItems(
          id: productData.items[i].id,
          imageUrl: productData.items[i].imageUrl,
          price: productData.items[i].rate.toString(),
          title: productData.items[i].title,
        ),
      ),
    );
  }
}
