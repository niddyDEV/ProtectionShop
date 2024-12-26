import 'package:flutter/material.dart';
import 'package:prk3_3_3/models/product.dart';
import 'package:prk3_3_3/api/api_service.dart';

class ProductManager with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = []; // Локальный массив для хранения продуктов

  List<Product> get products => _products;


  Future<void> fetchProducts() async {
    try {
      _products = await _apiService.getProducts();
      notifyListeners();
    } catch (e) {
      print('Error fetching products: $e');
    }
  }


  Future<void> addProduct(Product product) async {
    try {
      final newProduct = await _apiService.createProduct(product);
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print('Error adding product: $e');
    }
  }


  Future<void> removeProduct(int productId) async {
    try {
      await _apiService.deleteProduct(productId);
      _products.removeWhere((product) => product.productId == productId);
      notifyListeners();
    } catch (e) {
      print('Error deleting product: $e');
    }
  }


  Future<void> updateProduct(int productId, Product updatedProduct) async {
    try {
      final updated = await _apiService.updateProduct(productId, updatedProduct);
      final index = _products.indexWhere((product) => product.productId == productId);
      if (index != -1) {
        _products[index] = updated;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }
}