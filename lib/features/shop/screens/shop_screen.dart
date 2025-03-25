import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afrinova/features/shop/models/category_model.dart';
import 'package:afrinova/features/shop/screens/all_categories_screen.dart';
import 'package:afrinova/features/shop/screens/category_subcategories_screen.dart';
import 'package:afrinova/features/shop/screens/product_detail_screen.dart';
import 'package:afrinova/features/shop/screens/search_results_screen.dart';
import 'package:afrinova/features/shop/screens/subcategory_screen.dart';
import 'package:afrinova/features/shop/widgets/category_card.dart';
import 'package:afrinova/features/shop/widgets/filter_bottom_sheet.dart';
import 'package:afrinova/features/shop/widgets/subcategory_card.dart';
import 'package:afrinova/features/wallet/home/widgets/custom_search_bar.dart';
import 'package:afrinova/utils/constants/colors.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<CategoryModel> _categories = CategoryModel.getCategories();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _categories.length + 1, // +1 for "All" tab
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet() {
    // Determine current category based on selected tab
    String? currentCategory;
    if (_tabController.index > 0) {
      currentCategory = _categories[_tabController.index - 1].name;
    }

    Get.bottomSheet(
      FilterBottomSheet(
        currentCategory: currentCategory,
        onApplyFilters: (filters) {
          // Navigate to search results screen with filters
          Get.to(() => SearchResultsScreen(
                initialFilters: filters,
                currentCategory: currentCategory,
                searchQuery: _searchController.text,
              ));
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _handleSearch(String query) {
    if (query.isNotEmpty) {
      // Determine current category based on selected tab
      String? currentCategory;
      if (_tabController.index > 0) {
        currentCategory = _categories[_tabController.index - 1].name;
      }

      // Navigate to search results with the query
      Get.to(() => SearchResultsScreen(
            searchQuery: query,
            currentCategory: currentCategory,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Shop Title and View All Categories Button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Shop',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A1A3B),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const AllCategoriesScreen());
                    },
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        color: TColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: CustomSearchBar(
                hintText: 'Search products, categories...',
                backgroundColor: Colors.grey[200],
                controller: _searchController,
                readOnly: false,
                onSubmitted: _handleSearch,
                onFilterTap: _showFilterBottomSheet,
              ),
            ),

            // Category Tabs
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 8),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: TColors.primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: TColors.primary,
                indicatorWeight: 3,
                tabs: [
                  const Tab(text: 'ALL'),
                  ..._categories.map(
                      (category) => Tab(text: category.name.toUpperCase())),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // All Categories Tab
                  _buildAllCategoriesTab(),
                  // Individual Category Tabs
                  ..._categories.map((category) => _buildCategoryTab(category)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllCategoriesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured Categories Section
          const Text(
            'FEATURED CATEGORIES',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1A3B),
              letterSpacing: 1.2,
            ),
          ),

          const SizedBox(height: 16),

          // Featured Categories Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              return CategoryCard(
                category: category,
                onTap: () => _navigateToCategory(category),
              );
            },
          ),

          const SizedBox(height: 24),

          // View All Categories Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const AllCategoriesScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View All Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(CategoryModel category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category Header with Image
        SizedBox(
          height: 120,
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image with Error Handling
              Image.network(
                category.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to a colored background with icon
                  return Container(
                    color: category.color.withOpacity(0.2),
                    child: Center(
                      child: Icon(
                        category.icon,
                        color: category.color,
                        size: 40,
                      ),
                    ),
                  );
                },
              ),

              // Gradient Overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      category.color.withOpacity(0.8),
                    ],
                  ),
                ),
              ),

              // Category Title
              Positioned(
                bottom: 16,
                left: 16,
                child: Row(
                  children: [
                    Icon(
                      category.icon,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      category.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(0, 1),
                            blurRadius: 3.0,
                            color: Color.fromARGB(150, 0, 0, 0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Filter button
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: _showFilterBottomSheet,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.filter_list,
                      color: Color(0xFF0A1A3B),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Subcategories Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: category.subcategories.length,
            itemBuilder: (context, index) {
              final subcategory = category.subcategories[index];
              return SubcategoryCard(
                subcategory: subcategory,
                backgroundColor: index % 2 == 0
                    ? category.color.withOpacity(0.1)
                    : Colors.white,
                onTap: () =>
                    _navigateToSubcategory(category.name, subcategory.name),
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToCategory(CategoryModel category) {
    Get.to(() => CategorySubcategoriesScreen(category: category));
  }

  void _navigateToSubcategory(String category, String subcategory) {
    Get.to(() => SubcategoryScreen(
          category: category.toLowerCase(),
          subcategory: subcategory,
        ));
  }
}
