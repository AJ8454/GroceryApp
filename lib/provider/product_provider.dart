import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:grocery_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
// setter
  List<Product> _items = [];

// getter
  List<Product> get items {
    return [..._items];
  }

  Product findById(String? id) {
    return _items.firstWhere((prod) => prod.id! == id!);
  }

  Future<void> fetchAndSetProducts() async {
    var url =
        'https://grocery-app-952c6-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          rate: prodData['rate'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    var url =
        'https://grocery-app-952c6-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'rate': product.rate,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        rate: product.rate,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((prod) => prod.id == id);
    if (productIndex >= 0) {
      final url =
          'https://grocery-app-952c6-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(Uri.parse(url),
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'rate': newProduct.rate,
          }));
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://grocery-app-952c6-default-rtdb.firebaseio.com/products/$id.json';
    final exsistingProductIndex = _items.indexWhere((prod) => prod.id == id);
    dynamic exsistingProduct = _items[exsistingProductIndex];
    _items.removeAt(exsistingProductIndex);
    notifyListeners();

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode >= 400) {
      _items.insert(exsistingProductIndex, exsistingProduct);
      notifyListeners();
    }
    exsistingProduct = null;
  }
}
