import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afrinova/features/shop/models/category_model.dart';
import 'package:afrinova/features/shop/screens/category_subcategories_screen.dart';
import 'package:afrinova/features/shop/widgets/category_card.dart';
import 'package:afrinova/features/shop/widgets/seasonal_category_card.dart';
import 'package:afrinova/features/wallet/home/widgets/custom_search_bar.dart';

class AllCategoriesScreen extends StatelessWidget {
  const AllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get all categories
    final allCategories = CategoryModel.getCategories();
    final recentlyViewed = CategoryModel.getRecentlyViewedCategories();
    final seasonalCategories = CategoryModel.getSeasonalCategories();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'All Categories',
          style: TextStyle(
            color: Color(0xFF0A1A3B),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0A1A3B)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              CustomSearchBar(
                hintText: 'Search categories...',
                backgroundColor: Colors.grey[200],
                onTap: () {
                  // Handle search
                  print('Search tapped');
                },
              ),

              const SizedBox(height: 24),

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

              // Seasonal Categories
              SizedBox(
                height: 48,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: seasonalCategories.length,
                  itemBuilder: (context, index) {
                    final seasonal = seasonalCategories[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: SeasonalCategoryCard(
                        name: seasonal['name'],
                        icon: seasonal['icon'],
                        color: seasonal['color'],
                        imageUrl: seasonal['imageUrl'],
                        onTap: () {
                          // Navigate to seasonal category
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Recently Viewed Section
              if (recentlyViewed.isNotEmpty) ...[
                const Text(
                  'RECENTLY VIEWED',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A1A3B),
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 150, // Increased height to accommodate content
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: recentlyViewed.length,
                    itemBuilder: (context, index) {
                      final category = recentlyViewed[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: SizedBox(
                          width: 120, // Increased width for better layout
                          child: CategoryCard(
                            category: category,
                            onTap: () => _navigateToCategory(category),
                            height: 150, // Explicitly set height
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
              ],

              // All Departments Section
              const Text(
                'ALL DEPARTMENTS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1A3B),
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 16),

              // Grid of all categories
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85, // Adjusted for better fit
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: allCategories.length,
                itemBuilder: (context, index) {
                  final category = allCategories[index];
                  return CategoryCard(
                    category: category,
                    onTap: () => _navigateToCategory(category),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToCategory(CategoryModel category) {
    Get.to(() => CategorySubcategoriesScreen(category: category));
  }
}
