class Shop {
  final int id;
  final String name;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String category;
  final bool isVerified;
  final int productCount;

  Shop({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.category,
    this.isVerified = false,
    required this.productCount,
  });

  // Sample data for testing
  static List<Shop> getSampleShops() {
    return [
      Shop(
        id: 1,
        name: "ElectroTech",
        imageUrl: "https://fakestoreapi.com/img/81QpkIctqPL._AC_SX679_.jpg",
        rating: 4.8,
        reviewCount: 520,
        category: "electronics",
        isVerified: true,
        productCount: 45,
      ),
      Shop(
        id: 2,
        name: "Fashion Hub",
        imageUrl:
            "https://fakestoreapi.com/img/71YAIFU48IL._AC_UL640_QL65_ML3_.jpg",
        rating: 4.6,
        reviewCount: 342,
        category: "clothing",
        isVerified: true,
        productCount: 78,
      ),
      Shop(
        id: 3,
        name: "Jewelry Box",
        imageUrl:
            "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg",
        rating: 4.9,
        reviewCount: 189,
        category: "jewelery",
        isVerified: true,
        productCount: 32,
      ),
      Shop(
        id: 4,
        name: "Tech Gadgets",
        imageUrl: "https://fakestoreapi.com/img/61IBBVJvSDL._AC_SY879_.jpg",
        rating: 4.5,
        reviewCount: 275,
        category: "electronics",
        isVerified: false,
        productCount: 56,
      ),
      Shop(
        id: 5,
        name: "Style Avenue",
        imageUrl: "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg",
        rating: 4.7,
        reviewCount: 310,
        category: "clothing",
        isVerified: true,
        productCount: 64,
      ),
    ];
  }
}
