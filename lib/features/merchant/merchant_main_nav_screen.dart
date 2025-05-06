import 'package:flutter/material.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'merchant_home.dart';
import 'merchant_analytics_screen.dart';
import 'order_list_screen.dart';

class MerchantMainNavScreen extends StatefulWidget {
  final String shopName;

  const MerchantMainNavScreen({super.key, required this.shopName});

  @override
  State<MerchantMainNavScreen> createState() => _MerchantMainNavScreenState();
}

class _MerchantMainNavScreenState extends State<MerchantMainNavScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final Size screenSize = MediaQuery.of(context).size;
    final bool isTablet = screenSize.width > 600;

    return Scaffold(
      // Use IndexedStack to preserve state of screens when switching tabs
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Home Screen with shop name
          MerchantHomeScreen(shopName: widget.shopName),

          // OrderListScreen
          const OrderListScreen(),

          // Analytics Screen
          const MerchantAnalyticsScreen(),

          // Messaging Screen - Placeholder
          const _MerchantMessagingPlaceholder(),

          // Shop Settings Screen - Placeholder
          const _ShopSettingsPlaceholder(),
        ],
      ),
      // Custom styled bottom navigation bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: TColors.primary.withOpacity(0.03),
            selectedItemColor: TColors.primary,
            unselectedItemColor: Colors.grey.shade600,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
            elevation: 0,
            items: [
              _buildNavItem(
                  Icons.dashboard_outlined, Icons.dashboard, 'Dashboard', 0),
              _buildNavItem(
                  Icons.shopping_bag_outlined, Icons.shopping_bag, 'Orders', 1),
              _buildNavItem(
                  Icons.analytics_outlined, Icons.analytics, 'Analytics', 2),
              _buildNavItem(Icons.chat_outlined, Icons.chat, 'Messages', 3),
              _buildNavItem(
                  Icons.settings_outlined, Icons.settings, 'Settings', 4),
            ],
          ),
        ),
      ),
      // Floating action button for quick actions
      floatingActionButton: _currentIndex == 0 || _currentIndex == 1
          ? FloatingActionButton(
              onPressed: () {
                // Show quick actions sheet
                _showQuickActionsSheet(context);
              },
              backgroundColor: TColors.primary,
              elevation: 4,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  // Helper method to build nav items with indicator dots
  BottomNavigationBarItem _buildNavItem(
      IconData icon, IconData activeIcon, String label, int index) {
    final bool isSelected = _currentIndex == index;

    return BottomNavigationBarItem(
      icon: Column(
        children: [
          Icon(isSelected ? activeIcon : icon),
          const SizedBox(height: 4),
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? TColors.primary : Colors.transparent,
            ),
          ),
        ],
      ),
      label: label,
      backgroundColor: Colors.transparent,
    );
  }

  // Show quick actions sheet
  void _showQuickActionsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
          ),
          // Use SingleChildScrollView to prevent potential overflow on small screens
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Actions grid
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildActionItem(
                        context,
                        'Add Product',
                        Icons.add_box_outlined,
                        TColors.primary,
                        () {
                          Navigator.pop(context);
                          // TODO: Navigate to add product
                        },
                      ),
                      _buildActionItem(
                        context,
                        'New Order',
                        Icons.shopping_cart_outlined,
                        Colors.blue,
                        () {
                          Navigator.pop(context);
                          // TODO: Navigate to new order
                        },
                      ),
                      _buildActionItem(
                        context,
                        'Upload',
                        Icons.upload_outlined,
                        Colors.green,
                        () {
                          Navigator.pop(context);
                          // TODO: Navigate to upload
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper to build action item
  Widget _buildActionItem(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for Merchant Messaging Screen
class _MerchantMessagingPlaceholder extends StatelessWidget {
  const _MerchantMessagingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: TColors.primary,
        foregroundColor: TColors.textWhite,
        elevation: 0,
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
          // Use SingleChildScrollView to prevent potential overflow
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add some spacing from top
                    const SizedBox(height: 60),
                    Icon(
                      Icons.chat_outlined,
                      size: 80,
                      color: TColors.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Messaging',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Customer chat and messaging features are coming soon.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_outlined),
                      label: const Text('Notify Me When Available'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: TColors.primary,
                        side: const BorderSide(color: TColors.primary),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    // Add extra padding at bottom
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Placeholder for Shop Settings Screen
class _ShopSettingsPlaceholder extends StatelessWidget {
  const _ShopSettingsPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shop Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: TColors.primary,
        foregroundColor: TColors.textWhite,
        elevation: 0,
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
          // Wrap content in SingleChildScrollView to prevent overflow
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: TColors.primary.withOpacity(0.1),
                        child: const Icon(
                          Icons.store,
                          size: 60,
                          color: TColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Demo Shop',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Shop ID: SHOP12345',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(),
                _buildSettingItem(
                  icon: Icons.store_outlined,
                  title: 'Shop Profile',
                  subtitle: 'Edit your shop information',
                ),
                _buildSettingItem(
                  icon: Icons.badge_outlined,
                  title: 'Legal Information',
                  subtitle: 'Business registration, taxes, etc.',
                ),
                _buildSettingItem(
                  icon: Icons.payment_outlined,
                  title: 'Payment Settings',
                  subtitle: 'Manage your bank accounts and payment methods',
                ),
                _buildSettingItem(
                  icon: Icons.local_shipping_outlined,
                  title: 'Shipping Settings',
                  subtitle: 'Shipping zones, rates and options',
                ),
                _buildSettingItem(
                  icon: Icons.person_outline,
                  title: 'User Management',
                  subtitle: 'Add and manage staff accounts',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Note: Shop settings functionality will be available soon.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                // Add extra padding at bottom to ensure content is not hidden behind navigation bar
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return ListTile(
      leading: Icon(icon, color: TColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      contentPadding: EdgeInsets.zero,
      onTap: () {},
    );
  }
}
