import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smartdreamprueba/models/product_model.dart';
import 'package:http/http.dart' as http;

class FirebaseApi extends ChangeNotifier {
  final String _baseUrl =
      'https://smartdreamprueba-default-rtdb.europe-west1.firebasedatabase.app';

  Future<List<Product>> loadProducts() async {
    final List<Product> listProducts = [];
    final url = Uri.parse(_baseUrl + '/products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = jsonDecode(resp.body);

    productsMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      listProducts.add(tempProduct);
    });

    return listProducts;
  }
}
