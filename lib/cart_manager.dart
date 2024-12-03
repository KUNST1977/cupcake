import 'package:flutter/material.dart';

class CartManager extends ChangeNotifier {
  List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addItem(Map<String, dynamic> item) {
    _cartItems.add(item);
    notifyListeners();
  }

  void removeItem(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    _cartItems[index]['quantity'] = quantity;
    notifyListeners();
  }

  double calculateSubtotal() {
    return _cartItems.fold(
      0.0,
      (total, item) => total + (item['price'] * item['quantity']),
    );
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
