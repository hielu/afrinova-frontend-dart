import 'package:flutter/material.dart';
import 'package:afrinova/features/shop/models/product_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:afrinova/features/shop/screens/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  final bool showRating;
  final bool showAddToCart;
  final double? width;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.showRating = true,
    this.showAddToCart = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = width ?? (screenWidth < 400 ? 140.0 : 160.0);

    return GestureDetector(
      onTap: onTap ??
          () {
            // Always navigate to product detail screen if no custom onTap is provided
            Get.to(() => ProductDetailScreen(product: product));
          },
      child: Container(
        width: cardWidth,
        constraints: const BoxConstraints(
          minHeight: 200,
          maxHeight: 280,
        ),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Product Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Container(
                height: 110,
                width: double.infinity,
                color: Colors.grey[200],
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Product Details
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Price
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF0A1A3B),
                      ),
                    ),

                    if (showRating) ...[
                      const SizedBox(height: 4),

                      // Rating
                      Row(
                        children: [
                          // Star icons - limit to 3 on small screens
                          ...List.generate(screenWidth < 400 ? 3 : 5, (index) {
                            return Icon(
                              index < product.rating.floor()
                                  ? Icons.star
                                  : index < product.rating
                                      ? Icons.star_half
                                      : Icons.star_border,
                              size: 12,
                              color: Colors.amber,
                            );
                          }),

                          const SizedBox(width: 2),

                          // Rating text
                          Expanded(
                            child: Text(
                              '(${product.reviewCount})',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],

                    if (showAddToCart && screenWidth >= 360) ...[
                      const SizedBox(height: 8),

                      // Add to Cart Button
                      SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(FontAwesomeIcons.cartPlus, size: 12),
                          label:
                              const Text('Add', style: TextStyle(fontSize: 11)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A1A3B),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            minimumSize: const Size(0, 30),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
