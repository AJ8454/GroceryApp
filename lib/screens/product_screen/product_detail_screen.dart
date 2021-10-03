import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grocery_app/provider/product_provider.dart';
import 'package:grocery_app/utility/constant.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedData = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BackButton(),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 180,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 26.0,
                        )
                      ],
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: loadedData.imageUrl.contains('firebasestorage')
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 100,
                              child: Image.network(
                                loadedData.imageUrl,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/groceries.svg',
                            ),
                          ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    loadedData.title!,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                loadedData.description!,
                style: const TextStyle(
                  fontSize: 14,
                  color: kGreyColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                ' \u20B9 ${loadedData.rate!.toString()}',
                style: const TextStyle(
                  fontSize: 28,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  elevation: 8,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {},
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
