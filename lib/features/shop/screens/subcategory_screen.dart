import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afrinova/features/shop/controllers/product_controller.dart';
import 'package:afrinova/features/shop/screens/product_detail_screen.dart';
import 'package:afrinova/features/shop/widgets/product_card.dart';
import 'package:afrinova/features/shop/widgets/promo_carousel.dart';
import 'package:afrinova/features/shop/widgets/promo_carousel_items.dart';
import 'package:afrinova/features/shop/widgets/section_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubcategoryScreen extends StatefulWidget {
  final String category;
  final String subcategory;

  const SubcategoryScreen({
    super.key,
    required this.category,
    required this.subcategory,
  });

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  late final ProductController _productController;

  @override
  void initState() {
    super.initState();
    _productController = Get.find<ProductController>();

    // Filter products by category
    _productController.filterByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.subcategory,
          style: const TextStyle(
            color: Color(0xFF0A1A3B),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0A1A3B)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (_productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_productController.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Error: ${_productController.errorMessage.value}',
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () =>
                      _productController.filterByCategory(widget.category),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (_productController.filteredProducts.isEmpty) {
          return const Center(
            child: Text(
              'No products found in this subcategory',
              style: TextStyle(color: Colors.grey),
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Promo Carousel
              PromoCarousel(
                promos: PromoCarouselItems.getPromos(
                  promoData: [
                    {
                      'type': 'secondary',
                      'title': 'Special Offers',
                      'subtitle': 'Up to 40% off on ${widget.subcategory}',
                      'icon': FontAwesomeIcons.tag,
                      'onTap': () {},
                    },
                  ],
                ),
              ),

              // Product Count
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  '${_productController.filteredProducts.length} Products',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),

              // Featured Products Section
              if (_productController.getFeaturedProducts().isNotEmpty) ...[
                SectionTitle(
                  title: 'Featured ${widget.subcategory}',
                  onViewAllPressed: () {},
                ),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _productController.getFeaturedProducts().length,
                    itemBuilder: (context, index) {
                      final product =
                          _productController.getFeaturedProducts()[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ProductCard(
                          product: product,
                          onTap: () {
                            // Navigate to product detail screen
                            Get.to(() => ProductDetailScreen(product: product));
                          },
                          width: MediaQuery.of(context).size.width < 400
                              ? 140
                              : 160,
                        ),
                      );
                    },
                  ),
                ),
              ],

              // All Products Grid
              Padding(
                padding: const EdgeInsets.all(16),
                child: SectionTitle(
                  title: 'All ${widget.subcategory}',
                  showViewAll: false,
                ),
              ),
              _buildProductGrid(),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProductGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          childAspectRatio:
              MediaQuery.of(context).size.width > 600 ? 0.8 : 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _productController.filteredProducts.length,
        itemBuilder: (context, index) {
          final product = _productController.filteredProducts[index];
          return ProductCard(
            product: product,
            onTap: () {
              // Navigate to product detail screen
              Get.to(() => ProductDetailScreen(product: product));
            },
            showAddToCart: MediaQuery.of(context).size.width >= 360,
          );
        },
      ),
    );
  }
}
