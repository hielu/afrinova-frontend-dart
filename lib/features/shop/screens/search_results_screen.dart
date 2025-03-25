import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afrinova/features/shop/controllers/product_controller.dart';
import 'package:afrinova/features/shop/models/product_model.dart';
import 'package:afrinova/features/shop/widgets/filter_bottom_sheet.dart';
import 'package:afrinova/features/shop/widgets/product_card.dart';
import 'package:afrinova/features/wallet/home/widgets/custom_search_bar.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'package:afrinova/features/shop/screens/product_detail_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String? searchQuery;
  final String? currentCategory;
  final Map<String, dynamic>? initialFilters;
  final String? title;

  const SearchResultsScreen({
    super.key,
    this.searchQuery,
    this.currentCategory,
    this.initialFilters,
    this.title,
  });

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  late final ProductController _productController;
  late final TextEditingController _searchController;

  List<Product> _filteredProducts = [];
  Map<String, dynamic> _activeFilters = {};
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _productController = Get.find<ProductController>();
    _searchController = TextEditingController(text: widget.searchQuery ?? '');
    _searchQuery = widget.searchQuery ?? '';

    // Initialize with any provided filters
    if (widget.initialFilters != null) {
      _activeFilters = Map<String, dynamic>.from(widget.initialFilters!);
    }

    // Apply initial filtering
    _applyFilters();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      _isLoading = true;
    });

    // Start with all products or category-specific products
    List<Product> products = [];

    if (widget.currentCategory != null &&
        (!_activeFilters.containsKey('searchAllCategories') ||
            !_activeFilters['searchAllCategories'])) {
      // Filter by current category only
      _productController.filterByCategory(widget.currentCategory!);
      products = _productController.filteredProducts;
    } else {
      // Get all products
      products = _productController.allProducts;
    }

    // Apply search query if present
    if (_searchQuery.isNotEmpty) {
      products = products
          .where((product) =>
              product.title
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              product.description
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Apply category filters if present
    if (_activeFilters.containsKey('categories') &&
        (_activeFilters['categories'] as List).isNotEmpty) {
      final categories = _activeFilters['categories'] as List;
      products = products
          .where((product) => categories.contains(product.category))
          .toList();
    }

    // Apply price range filter if present
    if (_activeFilters.containsKey('priceRange')) {
      final priceRange = _activeFilters['priceRange'] as Map<String, dynamic>;
      products = products
          .where((product) =>
              product.price >= priceRange['min'] &&
              product.price <= priceRange['max'])
          .toList();
    }

    // Apply rating filter if present
    if (_activeFilters.containsKey('minRating') &&
        _activeFilters['minRating'] > 0) {
      final minRating = _activeFilters['minRating'] as double;
      products =
          products.where((product) => product.rating >= minRating).toList();
    }

    // Apply brand filters if present
    if (_activeFilters.containsKey('brands') &&
        (_activeFilters['brands'] as List).isNotEmpty) {
      final brands = _activeFilters['brands'] as List;
      // Note: This is a placeholder. In a real app, you'd have brand info in your product model
      // products = products.where((product) => brands.contains(product.brand)).toList();
    }

    // Apply availability filters if present
    if (_activeFilters.containsKey('availability')) {
      final availability =
          _activeFilters['availability'] as Map<String, dynamic>;

      // In stock filter - assuming countInStock > 0 means in stock
      // In a real app, you'd have this property in your model
      if (availability['inStock']) {
        // Placeholder - implement when you have stock information
        // products = products.where((product) => product.countInStock > 0).toList();
      }

      // On sale filter (placeholder)
      if (availability['onSale']) {
        // products = products.where((product) => product.onSale).toList();
      }

      // Free shipping filter (placeholder)
      if (availability['freeShipping']) {
        // products = products.where((product) => product.freeShipping).toList();
      }
    }

    // Apply sort if present
    if (_activeFilters.containsKey('sortBy') &&
        _activeFilters['sortBy'] != null) {
      final sortBy = _activeFilters['sortBy'] as String;

      switch (sortBy) {
        case 'Lowest Price':
          products.sort((a, b) => a.price.compareTo(b.price));
          break;
        case 'Highest Price':
          products.sort((a, b) => b.price.compareTo(a.price));
          break;
        case 'Most Popular':
          products.sort((a, b) => b.reviewCount.compareTo(a.reviewCount));
          break;
        case 'Best Rated':
          products.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'Newest':
          // In a real app, you'd sort by date
          products.sort((a, b) => b.id.compareTo(a.id));
          break;
      }
    }

    // Update state with filtered products
    setState(() {
      _filteredProducts = products;
      _isLoading = false;
    });
  }

  void _showFilterBottomSheet() {
    Get.bottomSheet(
      FilterBottomSheet(
        currentCategory: widget.currentCategory,
        initialFilters: _activeFilters,
        onApplyFilters: (filters) {
          setState(() {
            _activeFilters = filters;
          });
          _applyFilters();
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void _handleSearch(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    // Determine the screen title
    String screenTitle = widget.title ?? 'Search Results';
    if (widget.currentCategory != null &&
        (!_activeFilters.containsKey('searchAllCategories') ||
            !_activeFilters['searchAllCategories'])) {
      screenTitle = widget.currentCategory!;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          screenTitle,
          style: const TextStyle(
            color: Color(0xFF0A1A3B),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0A1A3B)),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Color(0xFF0A1A3B)),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchBar(
              hintText: 'Search products...',
              backgroundColor: Colors.grey[200],
              controller: _searchController,
              onSubmitted: _handleSearch,
              onTap: () {
                // Already on search screen, so just focus the field
              },
              suffixIcon: IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.grey),
                onPressed: _showFilterBottomSheet,
              ),
            ),
          ),

          // Active filters display
          if (_activeFilters.isNotEmpty &&
              ((_activeFilters['categories'] as List?)?.isNotEmpty == true ||
                  _activeFilters['sortBy'] != null))
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey[100],
              child: Row(
                children: [
                  const Icon(Icons.filter_list, size: 16, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _buildActiveFiltersText(),
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _activeFilters = {};
                      });
                      _applyFilters();
                    },
                    child: const Text(
                      'Clear All',
                      style: TextStyle(
                        color: TColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Results count
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredProducts.length} products found',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // View toggle (grid/list) - optional
                // IconButton(
                //   icon: Icon(Icons.grid_view, color: Colors.grey[700]),
                //   onPressed: () {
                //     // Toggle view mode
                //   },
                // ),
              ],
            ),
          ),

          // Results grid
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredProducts.isEmpty
                    ? _buildEmptyState()
                    : _buildProductGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No products found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _activeFilters = {};
                _searchController.clear();
                _searchQuery = '';
              });
              _applyFilters();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: TColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }

  Widget _buildProductGrid() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredProducts.length,
      itemBuilder: (context, index) {
        final product = _filteredProducts[index];
        return ProductCard(
          product: product,
          onTap: () {
            // Navigate to product detail
            Get.to(() => ProductDetailScreen(product: product));
          },
        );
      },
    );
  }

  String _buildActiveFiltersText() {
    List<String> filterTexts = [];

    // Add sort filter
    if (_activeFilters.containsKey('sortBy') &&
        _activeFilters['sortBy'] != null) {
      filterTexts.add('Sort: ${_activeFilters['sortBy']}');
    }

    // Add category filters
    if (_activeFilters.containsKey('categories') &&
        (_activeFilters['categories'] as List).isNotEmpty) {
      final categories = _activeFilters['categories'] as List;
      if (categories.length == 1) {
        filterTexts.add('Category: ${categories[0]}');
      } else if (categories.length > 1) {
        filterTexts.add('Categories: ${categories.length} selected');
      }
    }

    // Add price range
    if (_activeFilters.containsKey('priceRange')) {
      final priceRange = _activeFilters['priceRange'] as Map<String, dynamic>;
      filterTexts.add(
          'Price: \$${priceRange['min'].round()} - \$${priceRange['max'].round()}');
    }

    return filterTexts.join(' • ');
  }
}
