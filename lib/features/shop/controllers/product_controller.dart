import 'package:get/get.dart';
import 'package:afrinova/features/shop/models/product_model.dart';
import 'package:afrinova/features/shop/models/shop_model.dart';
import 'package:afrinova/features/shop/services/product_service.dart';

class ProductController extends GetxController {
  // Observable variables
  final RxList<Product> allProducts = <Product>[].obs;
  final RxList<Product> filteredProducts = <Product>[].obs;
  final RxList<String> categories = <String>[].obs;
  final RxString selectedCategory = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;

  // Shops data
  final RxList<Shop> allShops = <Shop>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
    fetchCategories();
    loadShops(); // Load sample shops
  }

  // Fetch all products
  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final products = await ProductService.getAllProducts();
      allProducts.value = products;
      filteredProducts.value = products;

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
    }
  }

  // Fetch all categories
  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await ProductService.getAllCategories();
      categories.value = fetchedCategories;
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  // Filter products by category
  Future<void> filterByCategory(String category) async {
    try {
      isLoading.value = true;
      hasError.value = false;
      selectedCategory.value = category;

      if (category.isEmpty) {
        // If no category selected, show all products
        filteredProducts.value = allProducts;
      } else {
        // Fetch products for the selected category
        final products = await ProductService.getProductsByCategory(category);
        filteredProducts.value = products;
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
    }
  }

  // Reset to show all products
  void resetFilter() {
    selectedCategory.value = '';
    filteredProducts.value = allProducts;
  }

  // Get featured products (top rated)
  List<Product> getFeaturedProducts() {
    final products = selectedCategory.isEmpty ? allProducts : filteredProducts;

    // Sort by rating and take top 5
    final sortedProducts = List<Product>.from(products)
      ..sort((a, b) => b.rating.compareTo(a.rating));

    return sortedProducts.take(5).toList();
  }

  // Get most popular products (most reviewed)
  List<Product> getMostPopularProducts() {
    final products = selectedCategory.isEmpty ? allProducts : filteredProducts;

    // Sort by review count and take top 5
    final sortedProducts = List<Product>.from(products)
      ..sort((a, b) => b.reviewCount.compareTo(a.reviewCount));

    return sortedProducts.take(5).toList();
  }

  // Get new arrivals (using most recent IDs as proxy for "new")
  List<Product> getNewArrivals() {
    final products = selectedCategory.isEmpty ? allProducts : filteredProducts;

    // Sort by ID (descending) and take top 4
    final sortedProducts = List<Product>.from(products)
      ..sort((a, b) => b.id.compareTo(a.id));

    return sortedProducts.take(4).toList();
  }

  // Get special offers (lowest priced items as "on sale")
  List<Product> getSpecialOffers() {
    final products = selectedCategory.isEmpty ? allProducts : filteredProducts;

    // Sort by price (ascending) and take top 3
    final sortedProducts = List<Product>.from(products)
      ..sort((a, b) => a.price.compareTo(b.price));

    return sortedProducts.take(3).toList();
  }

  // Load sample shops (in a real app, this would fetch from an API)
  void loadShops() {
    allShops.value = Shop.getSampleShops();
  }

  // Get popular shops
  List<Shop> getPopularShops() {
    // Sort by rating and review count
    final sortedShops = List<Shop>.from(allShops)
      ..sort((a, b) {
        // First sort by rating
        int ratingCompare = b.rating.compareTo(a.rating);
        // If ratings are equal, sort by review count
        if (ratingCompare == 0) {
          return b.reviewCount.compareTo(a.reviewCount);
        }
        return ratingCompare;
      });

    return sortedShops.take(5).toList();
  }

  // Get shops by category
  List<Shop> getShopsByCategory(String category) {
    if (category.isEmpty) {
      return allShops;
    }
    return allShops.where((shop) => shop.category == category).toList();
  }
}
