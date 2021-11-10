import 'package:flutter/material.dart';
import 'package:smartdreamprueba/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<Product> products = [];

  double get total {
    return products.fold(0.0, (double currentTotal, Product nextProduct) {
      return currentTotal + (nextProduct.price * nextProduct.count);
    });
  }

  int get totalProduct {
    return products.fold(0, (int currentTotal, Product nextProduct) {
      return currentTotal + nextProduct.count;
    });
  }

  void addToCart(Product product) {
    product.count = 1;
    products.add(product);
  }

  void removeFromCart(Product product) {
    products.remove(product);
    notifyListeners();
  }

  void removeListCart() {
    products = [];
    notifyListeners();
  }

  void incrementProduct(Product product) {
    product.count++;
  }

  void derementProduct(Product product) {
    if (product.count > 1) {
      product.count--;
    }
  }
}
