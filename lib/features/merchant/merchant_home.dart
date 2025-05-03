import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'widgets/snapshot_tile.dart';
import 'widgets/quick_action_button.dart';
import 'product_list.dart';
import 'product_form.dart';

class MerchantHomeScreen extends StatefulWidget {
  final String shopName;

  const MerchantHomeScreen({
    super.key,
    required this.shopName,
  });

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  final List<Map<String, dynamic>> _mockOrders = [
    {
      'id': '12345',
      'customer': 'Alice',
      'amount': 45000,
      'status': 'New',
      'time': DateTime.now().subtract(const Duration(hours: 1)),
    },
    {
      'id': '12344',
      'customer': 'Bob',
      'amount': 23000,
      'status': 'Processing',
      'time': DateTime.now().subtract(const Duration(hours: 3)),
    },
    {
      'id': '12343',
      'customer': 'Carol',
      'amount': 15000,
      'status': 'Shipped',
      'time': DateTime.now().subtract(const Duration(hours: 5)),
    },
  ];

  final List<Map<String, dynamic>> _mockProducts = [
    {
      'name': 'T-Shirt',
      'image': 'https://via.placeholder.com/60',
      'sold': 50,
    },
    {
      'name': 'Mug',
      'image': 'https://via.placeholder.com/60',
      'sold': 30,
    },
    {
      'name': 'Hat',
      'image': 'https://via.placeholder.com/60',
      'sold': 20,
    },
  ];

  String _getTimeAgo(DateTime time) {
    final Duration difference = DateTime.now().difference(time);
    if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat.MMMd().format(time);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat.yMMMMd().format(DateTime.now());

    return Scaffold(
      backgroundColor: TColors.light,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: TColors.primary,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.shopName,
              style: const TextStyle(
                color: TColors.textWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              formattedDate,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: TColors.textWhite.withOpacity(0.8),
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: TColors.textWhite,
                ),
                onPressed: () {},
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: TColors.secondary,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: TColors.textWhite,
                      width: 1.5,
                    ),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: TColors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          // Top decorative container that extends from app bar
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: TColors.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Rows with enhanced styling
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Stats header
                      Row(
                        children: [
                          Icon(
                            Icons.insights,
                            color: TColors.primary.withOpacity(0.8),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Today\'s Statistics',
                            style: TextStyle(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Stats Row 1
                      const Row(
                        children: [
                          SnapshotTile(
                            title: 'Today\'s Revenue',
                            value: 'UGX 150K',
                            icon: Icons.attach_money,
                            iconColor: Colors.green,
                          ),
                          SizedBox(width: 8),
                          SnapshotTile(
                            title: 'New Orders',
                            value: '5',
                            icon: Icons.shopping_bag,
                            iconColor: Colors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Stats Row 2
                      const Row(
                        children: [
                          SnapshotTile(
                            title: 'To Ship',
                            value: '3',
                            icon: Icons.local_shipping,
                            iconColor: Colors.orange,
                          ),
                          SizedBox(width: 8),
                          SnapshotTile(
                            title: 'Low Stock',
                            value: '2',
                            icon: Icons.inventory,
                            iconColor: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Quick Actions with improved styling
                Container(
                  decoration: BoxDecoration(
                    gradient: TColors.primaryGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: TColors.primary.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.touch_app,
                            color: TColors.textWhite,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Quick Actions',
                            style: TextStyle(
                              color: TColors.textWhite.withOpacity(0.9),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Row 1
                      Row(
                        children: [
                          QuickActionButton(
                            icon: Icons.add,
                            label: 'Add Product',
                            iconColor: TColors.textWhite,
                            backgroundColor: Colors.white.withOpacity(0.15),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProductFormScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          QuickActionButton(
                            icon: Icons.shopping_bag,
                            label: 'View Orders',
                            iconColor: TColors.textWhite,
                            backgroundColor: Colors.white.withOpacity(0.15),
                            onTap: () {
                              // Show a snackbar for now since we haven't created the orders screen
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Orders feature coming soon'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Row 2
                      Row(
                        children: [
                          QuickActionButton(
                            icon: Icons.inventory_2,
                            label: 'View Products',
                            iconColor: TColors.textWhite,
                            backgroundColor: Colors.white.withOpacity(0.15),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProductListScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 8),
                          QuickActionButton(
                            icon: Icons.message,
                            label: 'Messages',
                            iconColor: TColors.textWhite,
                            backgroundColor: Colors.white.withOpacity(0.15),
                            onTap: () {
                              // Keep the named route for now since we haven't created this screen yet
                              // Will be replaced with direct navigation when the screen is created
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Messages feature coming soon'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Recent Orders section with improved styling
                _buildSectionHeader('Recent Orders', Icons.receipt_long),
                const SizedBox(height: 8),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: _mockOrders.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    itemBuilder: (context, index) {
                      final order = _mockOrders[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '#${order['id']}',
                              style: TextStyle(
                                color: TColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            _buildStatusBadge(order['status']),
                          ],
                        ),
                        subtitle: Text(
                          '${order['customer']} • UGX ${(order['amount'] / 1000).toStringAsFixed(0)}K',
                          style: TextStyle(
                            color: TColors.textSecondary,
                          ),
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _getTimeAgo(order['time']),
                              style: TextStyle(
                                color: TColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: TColors.primary.withOpacity(0.5),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/merchant/orders/detail',
                            arguments: {'orderId': order['id']},
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Top Selling Products with improved styling
                _buildSectionHeader('Top Selling Products', Icons.trending_up),
                const SizedBox(height: 8),
                SizedBox(
                  height: 140,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _mockProducts.length,
                    itemBuilder: (context, index) {
                      final product = _mockProducts[index];
                      return Container(
                        width: 130,
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: TColors.secondary,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(16),
                                    bottomLeft: Radius.circular(16),
                                  ),
                                ),
                                child: Text(
                                  '#${index + 1}',
                                  style: const TextStyle(
                                    color: TColors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    color: TColors.primary.withOpacity(0.1),
                                    child: Center(
                                      child: Icon(
                                        _getProductIcon(product['name']),
                                        color: TColors.primary,
                                        size: 32,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: TColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: TColors.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '${product['sold']} sold',
                                    style: TextStyle(
                                      color: TColors.primary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: TColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: TColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status) {
    Color badgeColor;
    IconData statusIcon;

    switch (status) {
      case 'New':
        badgeColor = Colors.blue;
        statusIcon = Icons.fiber_new;
        break;
      case 'Processing':
        badgeColor = TColors.secondary;
        statusIcon = Icons.hourglass_bottom;
        break;
      case 'Shipped':
        badgeColor = Colors.green;
        statusIcon = Icons.local_shipping;
        break;
      default:
        badgeColor = Colors.grey;
        statusIcon = Icons.circle;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: badgeColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            size: 12,
            color: badgeColor,
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              color: badgeColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getProductIcon(String productName) {
    // Using standard icons from Flutter's Material design icons
    if (productName.toLowerCase().contains('shirt')) {
      return Icons.checkroom; // Clothing icon
    } else if (productName.toLowerCase().contains('mug')) {
      return Icons.coffee; // Coffee icon
    } else if (productName.toLowerCase().contains('hat')) {
      return Icons.face; // Face icon can represent hat
    } else {
      return Icons.shopping_bag; // Default shopping item
    }
  }
}
