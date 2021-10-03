import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GridItems extends StatelessWidget {
  final String? imageUrl;
  final String? price;
  final String? title;
  final String? id;

  const GridItems({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan[800],
      highlightColor: Colors.grey.withOpacity(0.5),
      onTap: () {},
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 80,
                  width: 60,
                  child: imageUrl!.contains('firebasestorage')
                      ? Image.network(
                          imageUrl!,
                        )
                      : SvgPicture.asset(
                          'assets/icons/groceries.svg',
                        ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                title!,
                style: const TextStyle(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u20B9 ${price!}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
