class ProductVariant {
  final String id;
  final String name;
  final int stock;

  ProductVariant({
    required this.id,
    required this.name,
    required this.stock,
  });
}

class Product {
  final String id, name, imageUrl;
  final int stock;
  final double price;
  final String description;
  final String? category;
  final bool isActive;
  final int viewCount;
  final int soldCount;
  final List<ProductVariant>? variants;
  final Map<String, String>? attributes;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.stock,
    this.price = 0.0,
    this.description = '',
    this.category,
    this.isActive = true,
    this.viewCount = 0,
    this.soldCount = 0,
    this.variants,
    this.attributes,
  });

  // Create a copy of the product with updated fields
  Product copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? stock,
    double? price,
    String? description,
    String? category,
    bool? isActive,
    int? viewCount,
    int? soldCount,
    List<ProductVariant>? variants,
    Map<String, String>? attributes,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      viewCount: viewCount ?? this.viewCount,
      soldCount: soldCount ?? this.soldCount,
      variants: variants ?? this.variants,
      attributes: attributes ?? this.attributes,
    );
  }
}
