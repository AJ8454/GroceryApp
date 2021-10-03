import 'package:flutter/material.dart';
import './/models/cart.dart';

class CartProvider with ChangeNotifier {
  late Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void increaseItemQuantity(
    String productId,
    double price,
    String title,
    String? imageUrl,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                existingCartItem.imageUrl!,
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price.toDouble(),
                quantity: existingCartItem.quantity + 1,
              ));
    }
    notifyListeners();
  }

   void decreaseItemQuantity(
    String productId,
    double price,
    String title,
    String? imageUrl,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                existingCartItem.imageUrl!,
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price.toDouble(),
                quantity: existingCartItem.quantity - 1,
              ));
    }
    notifyListeners();
  }

  void addItem(
    String productId,
    double price,
    String title,
    String? imageUrl,
  ) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                existingCartItem.imageUrl!,
                id: existingCartItem.id,
                title: existingCartItem.title,
                price: existingCartItem.price.toDouble(),
                quantity: existingCartItem.quantity + 1,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          imageUrl,
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                existingCartItem.imageUrl,
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
