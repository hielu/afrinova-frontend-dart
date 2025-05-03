import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:afrinova/features/shop/controllers/product_controller.dart';
import 'package:afrinova/features/shop/models/product_model.dart';
import 'package:afrinova/features/shop/models/shop_model.dart';
import 'package:afrinova/features/shop/screens/product_detail_screen.dart';
import 'package:afrinova/features/shop/widgets/product_card.dart';
import 'package:afrinova/features/shop/widgets/promo_carousel.dart';
import 'package:afrinova/features/shop/widgets/promo_carousel_items.dart';
import 'package:afrinova/features/shop/widgets/section_title.dart';
import 'package:afrinova/features/shop/widgets/shop_card.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final ProductController productController = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    // Filter products by the selected category
    productController.filterByCategory(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category.toUpperCase(),
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
            productController.resetFilter();
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (productController.hasError.value) {
          return Center(
            child: Text(
              'Error: ${productController.errorMessage.value}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (productController.filteredProducts.isEmpty) {
          return const Center(
            child: Text('No products found in this category.'),
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
                      'title': 'Limited Time',
                      'subtitle': 'Exclusive deals on ${widget.category}',
                      'icon': FontAwesomeIcons.clock,
                      'onTap': () {},
                    },
                    {
                      'type': 'primary',
                      'title': 'Special Offers',
                      'subtitle': 'Up to 50% off',
                      'onTap': () {},
                    },
                  ],
                ),
              ),

              // Most Popular Products
              SectionTitle(
                title: 'Most Popular',
                onViewAllPressed: () {},
              ),
              _buildProductList(productController.getMostPopularProducts()),

              // Popular Shops in this Category
              SectionTitle(
                title: 'Popular Shops',
                onViewAllPressed: () {},
              ),
              _buildShopList(
                  productController.getShopsByCategory(widget.category)),

              // Featured Products
              SectionTitle(
                title: 'Featured Products',
                onViewAllPressed: () {},
              ),
              _buildProductList(productController.getFeaturedProducts()),

              // New Arrivals
              SectionTitle(
                title: 'New Arrivals',
                onViewAllPressed: () {},
              ),
              _buildProductGrid(productController.getNewArrivals()),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return SizedBox(
      height: 280,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ProductCard(
              product: products[index],
              onTap: () {
                // Navigate to product detail screen
                Get.to(() => ProductDetailScreen(product: products[index]));
              },
              width: MediaQuery.of(context).size.width < 400 ? 140 : 160,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid(List<Product> products) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
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
              // Navigate to product detail screen
              Get.to(() => ProductDetailScreen(product: products[index]));
            },
            showAddToCart: screenWidth >= 360,
          );
        },
      ),
    );
  }

  Widget _buildShopList(List<Shop> shops) {
    if (shops.isEmpty) {
      return const SizedBox.shrink(); // Don't show if no shops in this category
    }

    // Sort shops by rating for this category view
    final sortedShops = List<Shop>.from(shops)
      ..sort((a, b) => b.rating.compareTo(a.rating));

    // Take top 5 or less if fewer shops available
    final limitedShops = sortedShops.take(5).toList();

    return SizedBox(
      height: 220,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: limitedShops.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ShopCard(
              shop: limitedShops[index],
              onTap: () {
                // Navigate to shop detail
              },
              width: MediaQuery.of(context).size.width < 400 ? 160 : 180,
            ),
          );
        },
      ),
    );
  }
}
