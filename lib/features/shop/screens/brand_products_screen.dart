import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afrinova/features/shop/controllers/product_controller.dart';
import 'package:afrinova/features/shop/models/product_model.dart';
import 'package:afrinova/features/shop/widgets/product_card.dart';

class BrandProductsScreen extends StatefulWidget {
  final String brandName;
  final String category;

  const BrandProductsScreen({
    super.key,
    required this.brandName,
    required this.category,
  });

  @override
  State<BrandProductsScreen> createState() => _BrandProductsScreenState();
}

class _BrandProductsScreenState extends State<BrandProductsScreen> {
  final ProductController _productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    // Filter products by category
    _productController.filterByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.brandName,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0A1A3B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Reset filter and go back
            _productController.resetFilter();
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (_productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_productController.hasError.value) {
          return Center(
            child: Text(
              'Error: ${_productController.errorMessage.value}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        // In a real app, we would filter products by brand
        // For now, we'll just use the category products as a demo
        final products = _productController.filteredProducts;

        if (products.isEmpty) {
          return const Center(
            child: Text(
              'No products found for this brand',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Info Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.brandName} Products',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1A3B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${products.length} products available',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Products Grid
            Expanded(
              child: _buildProductGrid(products),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenWidth > 600 ? 3 : 2,
        childAspectRatio: screenWidth > 600 ? 0.8 : 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () {
            // Navigate to product detail
          },
          showAddToCart: screenWidth >= 360,
        );
      },
    );
  }
}
