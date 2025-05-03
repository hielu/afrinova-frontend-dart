import 'dart:async';
import '../models/product.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class MockService {
  // Mock product data
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Cotton T-Shirt',
      imageUrl: 'https://example.com/tshirt.jpg',
      stock: 25,
    ),
    Product(
      id: '2',
      name: 'Ceramic Mug',
      imageUrl: 'https://example.com/mug.jpg',
      stock: 42,
    ),
    Product(
      id: '3',
      name: 'Denim Cap',
      imageUrl: 'https://example.com/cap.jpg',
      stock: 12,
    ),
    Product(
      id: '4',
      name: 'Leather Wallet',
      imageUrl: 'https://example.com/wallet.jpg',
      stock: 8,
    ),
    Product(
      id: '5',
      name: 'Sunglasses',
      imageUrl: 'https://example.com/sunglasses.jpg',
      stock: 15,
    ),
  ];

  // Simulate network delay
  Future<List<Product>> getProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return List.from(_products);
  }

  // Reload products (for pull-to-refresh)
  Future<List<Product>> reloadProducts() async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    return List.from(_products);
  }

  // Add a product
  Future<void> addProduct(Product product) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _products.add(product);
  }

  // Update a product
  Future<void> updateProduct(Product updatedProduct) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
    }
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _products.removeWhere((p) => p.id == id);
  }

  // Helper method to get a product icon based on its name
  static IconData getProductIcon(String productName) {
    final name = productName.toLowerCase();
    if (name.contains('shirt') || name.contains('clothing')) {
      return Icons.checkroom;
    } else if (name.contains('mug') || name.contains('cup')) {
      return Icons.coffee;
    } else if (name.contains('cap') || name.contains('hat')) {
      return Icons.face;
    } else if (name.contains('wallet')) {
      return Icons.account_balance_wallet;
    } else if (name.contains('glass') || name.contains('sunglass')) {
      return Icons.visibility;
    } else {
      return Icons.shopping_bag;
    }
  }

  // Helper method for image placeholder
  static Widget getImagePlaceholder(String productName) {
    return Container(
      color: TColors.primary.withOpacity(0.1),
      child: Center(
        child: Icon(
          getProductIcon(productName),
          color: TColors.primary,
          size: 24,
        ),
      ),
    );
  }
}

// Create a singleton instance
final mockService = MockService();
