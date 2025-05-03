import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:afrinova/common/widgets/custom_shapes/circular_container.dart';
import 'package:afrinova/features/shop/controllers/product_controller.dart';
import 'package:afrinova/features/shop/screens/category_screen.dart';
import 'package:afrinova/features/shop/screens/product_detail_screen.dart';
import 'package:afrinova/features/shop/screens/search_results_screen.dart';
import 'package:afrinova/features/shop/widgets/product_card.dart';
import 'package:afrinova/features/shop/widgets/promo_carousel.dart';
import 'package:afrinova/features/shop/widgets/promo_carousel_items.dart';
import 'package:afrinova/features/shop/widgets/secondary_promo_banner.dart';
import 'package:afrinova/features/shop/widgets/section_title.dart';
import 'package:afrinova/features/shop/widgets/shop_card.dart';
import 'package:afrinova/features/wallet/home/widgets/category_item.dart';
import 'package:afrinova/features/wallet/home/widgets/custom_search_bar.dart';
import 'package:afrinova/features/wallet/home/widgets/transparent_app_bar.dart';
import 'package:afrinova/features/shop/widgets/filter_bottom_sheet.dart';
import 'package:afrinova/features/merchant/merchant_home.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'package:afrinova/utils/language/language_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  bool isObscured = true; // State to track whether the value is obscured
  final LanguageController _languageController = Get.find<LanguageController>();
  late final ProductController _productController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Register for lifecycle events
    WidgetsBinding.instance.addObserver(this);

    // Initialize product controller
    _productController = Get.put(ProductController());
  }

  @override
  void dispose() {
    // Unregister from lifecycle events
    WidgetsBinding.instance.removeObserver(this);
    _searchController.dispose();
    super.dispose();
  }

  void _navigateToCategory(String category) {
    Get.to(() => CategoryScreen(category: category));
  }

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      FilterBottomSheet(
        onApplyFilters: (filters) {
          // Navigate to search results screen with filters
          Get.to(() => SearchResultsScreen(
                initialFilters: filters,
                searchQuery: _searchController.text,
                title: 'Search Results',
              ));
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _handleSearch(String query) {
    if (query.isNotEmpty) {
      // Navigate to search results with the query
      Get.to(() => SearchResultsScreen(
            searchQuery: query,
            title: 'Search Results',
          ));
    }
  }

  void _navigateToMerchantDashboard() {
    Get.to(() => const MerchantHomeScreen(shopName: 'My Shop'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Make body extend behind app bar
      appBar: const TransparentAppBar(
        username: "Helen Ghirmay",
        hasNotification: true,
      ),
      body: Obx(() {
        if (_productController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Section with Circular Decorations
                  Container(
                    color: TColors.primary,
                    padding: const EdgeInsets.all(0),
                    child: SizedBox(
                      height: 350,
                      child: Stack(
                        children: [
                          // Circular Decorations
                          Positioned(
                            top: -150,
                            right: -250,
                            child: LCircularContainer(
                                backgroundColor:
                                    TColors.textWhite.withOpacity(0.1)),
                          ),
                          Positioned(
                            top: 100,
                            right: -300,
                            child: LCircularContainer(
                                backgroundColor:
                                    TColors.textWhite.withOpacity(0.1)),
                          ),

                          // Content - Search Bar and Categories
                          Positioned(
                            top: 100, // Position below the app bar
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Search Bar
                                CustomSearchBar(
                                  hintText: 'Search in Store',
                                  backgroundColor: Colors.white,
                                  controller: _searchController,
                                  readOnly: false,
                                  onSubmitted: _handleSearch,
                                  onFilterTap: _showFilterBottomSheet,
                                ),

                                const SizedBox(height: 24),

                                // Popular Categories Title
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'Popular Categories',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 16),

                                // Categories Horizontal Scroll
                                SizedBox(
                                  height: 100,
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      CategoryItem(
                                        title: 'Electronics',
                                        icon: const FaIcon(
                                            FontAwesomeIcons.laptop),
                                        textColor: Colors.white,
                                        iconSize: 24,
                                        onTap: () =>
                                            _navigateToCategory('electronics'),
                                      ),
                                      const SizedBox(width: 16),
                                      CategoryItem(
                                        title: 'Jewelry',
                                        icon:
                                            const FaIcon(FontAwesomeIcons.gem),
                                        textColor: Colors.white,
                                        iconSize: 24,
                                        onTap: () =>
                                            _navigateToCategory('jewelery'),
                                      ),
                                      const SizedBox(width: 16),
                                      CategoryItem(
                                        title: 'Men\'s Clothing',
                                        icon: const FaIcon(
                                            FontAwesomeIcons.shirt),
                                        textColor: Colors.white,
                                        iconSize: 24,
                                        onTap: () => _navigateToCategory(
                                            'men\'s clothing'),
                                      ),
                                      const SizedBox(width: 16),
                                      CategoryItem(
                                        title: 'Women\'s Clothing',
                                        icon: const FaIcon(
                                            FontAwesomeIcons.personDress),
                                        textColor: Colors.white,
                                        iconSize: 24,
                                        onTap: () => _navigateToCategory(
                                            'women\'s clothing'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Promo Carousel with Flash Sale and Summer Sale
                  PromoCarousel(
                    promos: PromoCarouselItems.getPromos(
                      promoData: [
                        {
                          'type': 'secondary',
                          'title': 'Flash Sale',
                          'subtitle': '24 hours only - ends today!',
                          'icon': FontAwesomeIcons.bolt,
                          'onTap': () {},
                        },
                        {
                          'type': 'primary',
                          'title': 'Summer Sale',
                          'subtitle': 'Up to 50% off',
                          'onTap': () {},
                        },
                      ],
                    ),
                  ),

                  // Most Popular Products Section
                  SectionTitle(
                    title: 'Most Popular Products',
                    onViewAllPressed: () {},
                  ),
                  SizedBox(
                    height: 280,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _productController.getMostPopularProducts().length,
                      itemBuilder: (context, index) {
                        final product =
                            _productController.getMostPopularProducts()[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ProductCard(
                            product: product,
                            onTap: () {
                              // Navigate to product detail screen
                              Get.to(
                                  () => ProductDetailScreen(product: product));
                            },
                            width: MediaQuery.of(context).size.width < 400
                                ? 140
                                : 160,
                          ),
                        );
                      },
                    ),
                  ),

                  // Most Popular Shops Section
                  SectionTitle(
                    title: 'Most Popular Shops',
                    onViewAllPressed: () {},
                  ),
                  SizedBox(
                    height: 220,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: _productController.getPopularShops().length,
                      itemBuilder: (context, index) {
                        final shop =
                            _productController.getPopularShops()[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ShopCard(
                            shop: shop,
                            onTap: () {
                              // Navigate to shop detail or filter by shop
                            },
                            width: MediaQuery.of(context).size.width < 400
                                ? 160
                                : 180,
                          ),
                        );
                      },
                    ),
                  ),

                  // Featured Products Section
                  SectionTitle(
                    title: 'Featured Products',
                    onViewAllPressed: () {},
                  ),
                  SizedBox(
                    height:
                        280, // Increased height to accommodate product cards
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          _productController.getFeaturedProducts().length,
                      itemBuilder: (context, index) {
                        final product =
                            _productController.getFeaturedProducts()[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: ProductCard(
                            product: product,
                            onTap: () {
                              // Navigate to product detail screen
                              Get.to(
                                  () => ProductDetailScreen(product: product));
                            },
                            // Adapt to screen size
                            width: MediaQuery.of(context).size.width < 400
                                ? 140
                                : 160,
                          ),
                        );
                      },
                    ),
                  ),

                  // New Arrivals Section
                  SectionTitle(
                    title: 'New Arrivals',
                    onViewAllPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 3 : 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.width > 600
                                ? 0.8
                                : 0.65, // Adjusted for better fit
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _productController.getNewArrivals().length,
                      itemBuilder: (context, index) {
                        final product =
                            _productController.getNewArrivals()[index];
                        return ProductCard(
                          product: product,
                          onTap: () {
                            // Navigate to product detail screen
                            Get.to(() => ProductDetailScreen(product: product));
                          },
                          // Show add to cart only on larger screens
                          showAddToCart:
                              MediaQuery.of(context).size.width >= 360,
                        );
                      },
                    ),
                  ),

                  // Another Promo Banner
                  SecondaryPromoBanner(
                    title: 'Free Shipping',
                    subtitle: 'On orders over \$50',
                    icon: FontAwesomeIcons.truck,
                    backgroundColor: const Color(0xFF2E7D32), // Green color
                    onTap: () {},
                  ),

                  // Popular Brands Section
                  SectionTitle(
                    title: 'Popular Brands',
                    onViewAllPressed: () {},
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5, // Number of brands
                      itemBuilder: (context, index) {
                        return Container(
                          width: 100,
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Brand ${index + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0A1A3B),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Merchant Section
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: _navigateToMerchantDashboard,
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              TColors.primary,
                              TColors.primary.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.storefront,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Become a Merchant',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Sell your products and manage your store',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
