import 'package:flutter/material.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'models/product.dart';
import 'services/mock_service.dart';
import 'product_form.dart';
import 'product_analytics_screen.dart';
import 'widgets/product_qr_dialog.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> _productsFuture;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  bool _showLowStockOnly = false;

  @override
  void initState() {
    super.initState();
    _productsFuture = mockService.getProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Reload products and update state
  Future<void> _refreshProducts() async {
    setState(() {
      _productsFuture = mockService.reloadProducts();
    });
    await _productsFuture;
  }

  // Load products with low stock only
  Future<void> _toggleLowStockFilter() async {
    setState(() {
      _showLowStockOnly = !_showLowStockOnly;
      if (_showLowStockOnly) {
        _productsFuture = mockService.getLowStockProducts();
      } else {
        _productsFuture = mockService.getProducts();
      }
    });
  }

  // Show delete confirmation dialog
  Future<void> _showDeleteConfirmation(Product product) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(Icons.delete_outline, color: Colors.red[400]),
            const SizedBox(width: 8),
            const Text('Delete Product'),
          ],
        ),
        content: Text(
          'Are you sure you want to delete "${product.name}"? This action cannot be undone.',
          style: const TextStyle(fontSize: 15),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'CANCEL',
              style: TextStyle(color: TColors.primary.withOpacity(0.8)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[400],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('DELETE'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await mockService.deleteProduct(product.id);
      setState(() {
        _productsFuture = mockService.getProducts();
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text('${product.name} has been deleted'),
              ],
            ),
            backgroundColor: Colors.red[400],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
          ),
        );
      }
    }
  }

  List<Product> _filterProducts(List<Product> products) {
    if (_searchQuery.isEmpty) {
      return products;
    }

    final query = _searchQuery.toLowerCase();
    return products
        .where((product) => product.name.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.light,
      appBar: AppBar(
        title: const Text(
          'My Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: TColors.primary,
        foregroundColor: TColors.textWhite,
        elevation: 0,
        actions: [
          // Low stock filter toggle
          IconButton(
            icon: Badge(
              label: const Text('!'),
              isLabelVisible: _showLowStockOnly,
              child: Icon(
                _showLowStockOnly
                    ? Icons.warning_amber_rounded
                    : Icons.filter_alt_outlined,
                color: _showLowStockOnly ? Colors.amber : Colors.white,
              ),
            ),
            onPressed: _toggleLowStockFilter,
            tooltip: 'Filter Low Stock Items',
          ),
          // Sort button
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              // TODO: Implement sorting options
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) => SortOptionsSheet(
                  onSortOptionSelected: (option) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Sort by: $option'),
                        duration: const Duration(seconds: 1),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
              );
            },
            tooltip: 'Sort products',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Top decorative container that extends from app bar
          Container(
            height: 30,
            decoration: const BoxDecoration(
              color: TColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          FutureBuilder<List<Product>>(
            future: _productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: TColors.primary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Loading products...',
                        style: TextStyle(
                          color: TColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.error_outline,
                          size: 48,
                          color: Colors.red[400],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Error loading products',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please check your connection and try again',
                        style: TextStyle(color: TColors.textSecondary),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _refreshProducts,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              final allProducts = snapshot.data ?? [];
              final filteredProducts = _filterProducts(allProducts);

              if (allProducts.isEmpty) {
                return _buildEmptyProductsView();
              }

              if (filteredProducts.isEmpty) {
                return _buildNoSearchResultsView();
              }

              return RefreshIndicator(
                onRefresh: _refreshProducts,
                color: TColors.primary,
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                  itemCount: filteredProducts.length,
                  itemBuilder: (context, i) {
                    final product = filteredProducts[i];
                    return _buildProductCard(product);
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: TColors.primary,
        foregroundColor: TColors.textWhite,
        elevation: 4,
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const ProductFormScreen(),
            ),
          ).then((_) => _refreshProducts());
        },
      ),
    );
  }

  Widget _buildProductCard(Product product) {
    final bool isLowStock = product.stock < 5 && product.isActive;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductFormScreen(product: product),
            ),
          ).then((_) => _refreshProducts());
        },
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            // Product image and badges section
            _buildProductImageSection(product, isLowStock),

            // Analytics section
            _buildAnalyticsSection(product),

            // Variants section (if available)
            if (product.variants != null && product.variants!.isNotEmpty)
              _buildVariantsSection(product.variants!),

            // Action bar
            _buildActionBar(product),
          ],
        ),
      ),
    );
  }

  Widget _buildProductImageSection(Product product, bool isLowStock) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: SizedBox(
        height: 140,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Product image with opacity based on active status
            Opacity(
              opacity: product.isActive ? 1.0 : 0.4,
              child: _buildProductImage(product),
            ),

            // Active/Inactive overlay for inactive products
            if (!product.isActive)
              Container(
                color: Colors.black.withOpacity(0.1),
                child: const Center(
                  child: Text(
                    'INACTIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),

            // Stock level badge (only show if product is active)
            if (product.isActive)
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: _getStockColor(product.stock).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.inventory_2,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${product.stock} in stock',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Low stock alert badge
            if (isLowStock)
              Positioned(
                top: 52,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber,
                        color: Colors.white,
                        size: 14,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Low Stock',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Edit button overlay
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductFormScreen(product: product),
                      ),
                    ).then((_) => _refreshProducts());
                  },
                  constraints: const BoxConstraints(
                    minWidth: 36,
                    minHeight: 36,
                  ),
                  padding: const EdgeInsets.all(8),
                  splashRadius: 20,
                ),
              ),
            ),

            // Shadow gradient overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),

            // Product name overlay
            Positioned(
              bottom: 12,
              left: 12,
              right: 60,
              child: Text(
                product.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsSection(Product product) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // View stats
          _buildAnalyticItem(
            count: product.viewCount,
            label: 'Views',
            icon: Icons.visibility_outlined,
            color: Colors.blue,
          ),

          // Sales stats
          _buildAnalyticItem(
            count: product.soldCount,
            label: 'Sold',
            icon: Icons.shopping_cart_outlined,
            color: Colors.green,
          ),

          // Analytics button
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductAnalyticsScreen(product: product),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.analytics_outlined,
                    size: 16,
                    color: TColors.primary,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Analytics',
                    style: TextStyle(
                      color: TColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalyticItem({
    required int count,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVariantsSection(List<ProductVariant> variants) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          Text(
            'Variants',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: variants.map((variant) {
              final bool lowStock = variant.stock < 5;
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: lowStock
                      ? Colors.red.withOpacity(0.1)
                      : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                  border: lowStock
                      ? Border.all(color: Colors.red.shade300, width: 1)
                      : null,
                ),
                child: Text(
                  '${variant.name} (${variant.stock})',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: lowStock ? Colors.red.shade700 : Colors.black87,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar(Product product) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Active toggle and SKU info
          Row(
            children: [
              Switch(
                value: product.isActive,
                onChanged: (value) async {
                  final updatedProduct =
                      await mockService.toggleProductActiveStatus(product.id);
                  setState(() {
                    // Refresh the products list with the updated product
                    _productsFuture = mockService.getProducts();
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${product.name} is now ${value ? 'active' : 'inactive'}'),
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                activeColor: TColors.primary,
              ),
              const SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: product.isActive ? TColors.primary : Colors.grey,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.qr_code,
                        size: 14,
                        color: TColors.textSecondary,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'SKU: ${product.id}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: TColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),

          // Action buttons
          Row(
            children: [
              // QR code button
              IconButton(
                icon: const Icon(
                  Icons.qr_code_2,
                  color: TColors.primary,
                ),
                onPressed: () {
                  _showQRCodeDialog(product);
                },
                tooltip: 'Generate QR Code',
                iconSize: 20,
                constraints: const BoxConstraints(
                  minWidth: 36,
                  minHeight: 36,
                ),
                padding: const EdgeInsets.all(8),
                splashRadius: 20,
              ),

              // Delete button
              TextButton.icon(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red[400],
                  size: 20,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 12,
                  ),
                ),
                onPressed: () => _showDeleteConfirmation(product),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showQRCodeDialog(Product product) {
    final qrData = mockService.generateProductQRData(product.id);

    showDialog(
      context: context,
      builder: (context) => ProductQRDialog(
        product: product,
        qrData: qrData,
      ),
    );
  }

  Widget _buildEmptyProductsView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: TColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 80,
                color: TColors.primary.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No products yet',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: TColors.primary,
                  ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Start adding products to your inventory',
              style: TextStyle(
                fontSize: 16,
                color: TColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Your products will appear here once added',
              style: TextStyle(
                fontSize: 14,
                color: TColors.textSecondary.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProductFormScreen(),
                  ),
                ).then((_) => _refreshProducts());
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Your First Product'),
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoSearchResultsView() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: TColors.primary.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'No matching products',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try adjusting your search to find what you\'re looking for',
              style: TextStyle(color: TColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                _searchController.clear();
                setState(() {
                  _searchQuery = '';
                });
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: TColors.primary),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Clear Search'),
            ),
          ],
        ),
      ),
    );
  }

  // Helper to build product image or placeholder
  Widget _buildProductImage(Product product) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/images/placeholder.png',
      image: product.imageUrl,
      fit: BoxFit.cover,
      imageErrorBuilder: (context, error, stackTrace) {
        // Show placeholder with product icon on error
        return MockService.getImagePlaceholder(product.name);
      },
    );
  }

  // Helper to get color based on stock level
  Color _getStockColor(int stock) {
    if (stock <= 0) {
      return Colors.red[400]!;
    } else if (stock < 10) {
      return Colors.orange[400]!;
    } else {
      return Colors.green[500]!;
    }
  }
}

// Sort options sheet
class SortOptionsSheet extends StatelessWidget {
  final Function(String) onSortOptionSelected;

  const SortOptionsSheet({super.key, required this.onSortOptionSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Text(
            'Sort Products',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: TColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          _buildSortOption(context, 'Name (A-Z)'),
          _buildSortOption(context, 'Name (Z-A)'),
          _buildSortOption(context, 'Stock (High to Low)'),
          _buildSortOption(context, 'Stock (Low to High)'),
          _buildSortOption(context, 'Recently Added'),
        ],
      ),
    );
  }

  Widget _buildSortOption(BuildContext context, String option) {
    return InkWell(
      onTap: () => onSortOptionSelected(option),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Row(
          children: [
            Icon(
              _getIconForOption(option),
              color: TColors.primary,
              size: 20,
            ),
            const SizedBox(width: 16),
            Text(
              option,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForOption(String option) {
    if (option.contains('A-Z')) {
      return Icons.sort_by_alpha;
    } else if (option.contains('Z-A')) {
      return Icons.sort_by_alpha;
    } else if (option.contains('High to Low')) {
      return Icons.arrow_downward;
    } else if (option.contains('Low to High')) {
      return Icons.arrow_upward;
    } else {
      return Icons.access_time;
    }
  }
}
