import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:afrinova/common/widgets/custom_shapes/circular_container.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'package:afrinova/features/wallet/home/widgets/transparent_app_bar.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  bool _isBalanceVisible = true;
  final List<Map<String, dynamic>> _transactions = [
    {
      'id': 't1',
      'title': 'Coffee Shop',
      'amount': -4.50,
      'date': '2023-06-15',
      'category': 'Food & Drink',
      'icon': Iconsax.coffee,
      'color': Colors.brown,
    },
    {
      'id': 't3',
      'title': 'Grocery Purchase',
      'amount': -65.99,
      'date': '2023-05-28',
      'category': 'Shopping',
      'icon': Iconsax.shopping_cart,
      'color': Colors.blue,
    },
    {
      'id': 't4',
      'title': 'Rent Pay',
      'amount': -85.75,
      'date': '2023-05-25',
      'category': 'Utilities',
      'icon': Iconsax.electricity,
      'color': Colors.orange,
    },
    {
      'id': 't5',
      'title': 'Deposit',
      'amount': 350.00,
      'date': '2023-05-20',
      'category': 'Income',
      'icon': Iconsax.money_recive,
      'color': Colors.green,
    },
    {
      'id': 't6',
      'title': 'Electronics Purchase',
      'amount': -49.99,
      'date': '2023-05-15',
      'category': 'Health',
      'icon': Iconsax.weight,
      'color': Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const TransparentAppBar(
        username: "Helen Ghirmay",
        hasNotification: true,
      ),
      body: Container(
        color: TColors.primary,
        child: Column(
          children: [
            // Top section with balance
            _buildTopSection(),

            // Bottom section with transactions
            _buildTransactionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 120, 20, 30),
      decoration: const BoxDecoration(
        color: TColors.primary,
      ),
      child: Column(
        children: [
          // Circular decorations
          Stack(
            children: [
              Positioned(
                top: -100,
                right: -150,
                child: LCircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),
              Positioned(
                bottom: -80,
                left: -100,
                child: LCircularContainer(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),

              // Balance card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Balance',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _isBalanceVisible ? Iconsax.eye : Iconsax.eye_slash,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _isBalanceVisible = !_isBalanceVisible;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _isBalanceVisible ? '\$3,542.50' : '••••••',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickActionButton(
                          icon: Iconsax.add,
                          label: 'Add Money',
                          onTap: () {},
                        ),
                        _buildQuickActionButton(
                          icon: Iconsax.send_2,
                          label: 'Send',
                          onTap: () {},
                        ),
                        _buildQuickActionButton(
                          icon: Iconsax.card,
                          label: 'Cards',
                          onTap: () {},
                        ),
                        _buildQuickActionButton(
                          icon: Iconsax.more,
                          label: 'More',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: TColors.quickButtonHalo.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsSection() {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: TColors.textPrimary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        color: TColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _transactions.length,
                itemBuilder: (context, index) {
                  final transaction = _transactions[index];
                  final isIncome = transaction['amount'] > 0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Category icon
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: transaction['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            transaction['icon'],
                            color: transaction['color'],
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Transaction details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction['title'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: TColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                transaction['category'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Amount
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              isIncome
                                  ? '+\$${transaction['amount'].abs().toStringAsFixed(2)}'
                                  : '-\$${transaction['amount'].abs().toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: isIncome ? Colors.green : Colors.red,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              transaction['date'],
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
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
    );
  }
}
