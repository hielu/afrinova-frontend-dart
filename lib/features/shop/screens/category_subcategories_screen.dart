import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afrinova/features/shop/models/category_model.dart';
import 'package:afrinova/features/shop/screens/subcategory_screen.dart';
import 'package:afrinova/features/shop/widgets/subcategory_card.dart';
import 'package:afrinova/features/wallet/home/widgets/custom_search_bar.dart';

class CategorySubcategoriesScreen extends StatelessWidget {
  final CategoryModel category;

  const CategorySubcategoriesScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            backgroundColor: category.color,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Color.fromARGB(150, 0, 0, 0),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Category Image with Error Handling
                  Image.network(
                    category.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to a colored background with icon
                      return Container(
                        color: category.color.withOpacity(0.7),
                        child: Center(
                          child: Icon(
                            category.icon,
                            color: Colors.white,
                            size: 60,
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: category.color.withOpacity(0.5),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
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

                  // Product Count
                  Positioned(
                    bottom: 60,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '${category.productCount}+ products',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CustomSearchBar(
                hintText: 'Search in ${category.name}...',
                backgroundColor: Colors.grey[200],
                onTap: () {
                  // Handle search
                  print('Search tapped');
                },
              ),
            ),
          ),

          // Subcategories Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                'Browse ${category.name}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A1A3B),
                ),
              ),
            ),
          ),

          // Subcategories Grid
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.1,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final subcategory = category.subcategories[index];
                  return SubcategoryCard(
                    subcategory: subcategory,
                    onTap: () => _navigateToSubcategory(subcategory.name),
                  );
                },
                childCount: category.subcategories.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToSubcategory(String subcategoryName) {
    Get.to(() => SubcategoryScreen(
          category: category.name.toLowerCase(),
          subcategory: subcategoryName,
        ));
  }
}
