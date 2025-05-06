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
      price: 29.99,
      description: 'High-quality cotton t-shirt in various colors.',
      category: 'Clothing',
      isActive: true,
      viewCount: 245,
      soldCount: 37,
      variants: [
        ProductVariant(id: '1-1', name: 'Small', stock: 8),
        ProductVariant(id: '1-2', name: 'Medium', stock: 10),
        ProductVariant(id: '1-3', name: 'Large', stock: 7),
      ],
    ),
    Product(
      id: '2',
      name: 'Ceramic Mug',
      imageUrl: 'https://example.com/mug.jpg',
      stock: 42,
      price: 12.99,
      description: 'Durable ceramic mug with aesthetic designs.',
      category: 'Home & Kitchen',
      isActive: true,
      viewCount: 128,
      soldCount: 23,
    ),
    Product(
      id: '3',
      name: 'Denim Cap',
      imageUrl: 'https://example.com/cap.jpg',
      stock: 12,
      price: 19.99,
      description: 'Stylish denim cap for casual wear.',
      category: 'Clothing',
      isActive: true,
      viewCount: 89,
      soldCount: 14,
    ),
    Product(
      id: '4',
      name: 'Leather Wallet',
      imageUrl: 'https://example.com/wallet.jpg',
      stock: 3,
      price: 49.99,
      description: 'Genuine leather wallet with multiple card slots.',
      category: 'Accessories',
      isActive: true,
      viewCount: 156,
      soldCount: 19,
    ),
    Product(
      id: '5',
      name: 'Sunglasses',
      imageUrl: 'https://example.com/sunglasses.jpg',
      stock: 15,
      price: 59.99,
      description: 'UV-protected sunglasses with polarized lenses.',
      category: 'Accessories',
      isActive: false, // Example of inactive product
      viewCount: 210,
      soldCount: 28,
      variants: [
        ProductVariant(id: '5-1', name: 'Black Frame', stock: 8),
        ProductVariant(id: '5-2', name: 'Brown Frame', stock: 7),
      ],
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

  // Get products with low stock
  Future<List<Product>> getLowStockProducts({int threshold = 5}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _products.where((p) => p.stock < threshold && p.isActive).toList();
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

  // Toggle product active status
  Future<Product> toggleProductActiveStatus(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      final product = _products[index];
      final updatedProduct = product.copyWith(isActive: !product.isActive);
      _products[index] = updatedProduct;
      return updatedProduct;
    }
    throw Exception('Product not found');
  }

  // Delete a product
  Future<void> deleteProduct(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _products.removeWhere((p) => p.id == id);
  }

  // Generate mock QR code data for a product
  String generateProductQRData(String productId) {
    return 'https://afrinova.com/shop/product/$productId';
  }

  // Increment view count for a product
  Future<void> incrementProductViewCount(String id) async {
    final index = _products.indexWhere((p) => p.id == id);
    if (index != -1) {
      final product = _products[index];
      _products[index] = product.copyWith(viewCount: product.viewCount + 1);
    }
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
