import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:afrinova/features/shop/models/product_model.dart';

class ProductService {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Fetch all products
  static Future<List<Product>> getAllProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      // Return some dummy products in case of error
      return _getDummyProducts();
    }
  }

  // Fetch products by category
  static Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products/category/$category'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load products by category: ${response.statusCode}');
      }
    } catch (e) {
      // Filter dummy products by category in case of error
      return _getDummyProducts()
          .where((product) => product.category == category)
          .toList();
    }
  }

  // Get all categories
  static Future<List<String>> getAllCategories() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/products/categories'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((category) => category.toString()).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      // Return dummy categories in case of error
      return [
        'electronics',
        'jewelery',
        'men\'s clothing',
        'women\'s clothing'
      ];
    }
  }

  // Dummy products for offline/error fallback
  static List<Product> _getDummyProducts() {
    return [
      Product(
        id: 1,
        title: "Fjallraven - Foldsack No. 1 Backpack",
        price: 109.95,
        description:
            "Your perfect pack for everyday use and walks in the forest.",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        rating: 4.3,
        reviewCount: 120,
      ),
      Product(
        id: 2,
        title: "Mens Casual Premium Slim Fit T-Shirts",
        price: 22.3,
        description: "Slim-fitting style, contrast raglan long sleeve.",
        category: "men's clothing",
        image:
            "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg",
        rating: 4.1,
        reviewCount: 259,
      ),
      Product(
        id: 9,
        title: "WD 2TB Elements Portable External Hard Drive",
        price: 64.0,
        description: "USB 3.0 and USB 2.0 Compatibility",
        category: "electronics",
        image: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
        rating: 3.3,
        reviewCount: 203,
      ),
      Product(
        id: 14,
        title: "Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor",
        price: 999.99,
        description: "49 INCH SUPER ULTRAWIDE 32:9 CURVED GAMING MONITOR",
        category: "electronics",
        image: "https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg",
        rating: 2.2,
        reviewCount: 140,
      ),
      Product(
        id: 15,
        title: "BIYLACLESEN Women's 3-in-1 Snowboard Jacket",
        price: 56.99,
        description: "Note:The Jackets is US standard size",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg",
        rating: 2.6,
        reviewCount: 235,
      ),
      Product(
        id: 16,
        title:
            "Lock and Love Women's Removable Hooded Faux Leather Moto Biker Jacket",
        price: 29.95,
        description: "100% POLYURETHANE(shell) 100% POLYESTER(lining)",
        category: "women's clothing",
        image: "https://fakestoreapi.com/img/81XH0e8fefL._AC_UY879_.jpg",
        rating: 2.9,
        reviewCount: 340,
      ),
      Product(
        id: 7,
        title: "White Gold Plated Princess",
        price: 9.99,
        description:
            "Classic Created Wedding Engagement Solitaire Diamond Promise Ring for Her.",
        category: "jewelery",
        image:
            "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
        rating: 3.0,
        reviewCount: 400,
      ),
      Product(
        id: 8,
        title: "Pierced Owl Rose Gold Plated Stainless Steel Double",
        price: 10.99,
        description: "Rose Gold Plated Double Flared Tunnel Plug Earrings.",
        category: "jewelery",
        image:
            "https://fakestoreapi.com/img/51UDEzMJVpL._AC_UL640_QL65_ML3_.jpg",
        rating: 1.9,
        reviewCount: 100,
      ),
    ];
  }
}
