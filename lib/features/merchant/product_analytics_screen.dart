import 'package:flutter/material.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'models/product.dart';

class ProductAnalyticsScreen extends StatelessWidget {
  final Product product;

  const ProductAnalyticsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Analytics: ${product.name}',
          style: const TextStyle(fontWeight: FontWeight.bold),
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
          // Content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSummaryCard(),
                const SizedBox(height: 20),
                _buildPerformanceChart(),
                const SizedBox(height: 20),
                _buildViewsAndSalesSection(),
                const SizedBox(height: 20),
                _buildConversionRateCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Performance Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryItem(
                  'Views',
                  product.viewCount.toString(),
                  Icons.visibility,
                  Colors.blue,
                ),
                _buildSummaryItem(
                  'Sold',
                  product.soldCount.toString(),
                  Icons.shopping_cart,
                  Colors.green,
                ),
                _buildSummaryItem(
                  'Conversion',
                  '${(product.soldCount / (product.viewCount > 0 ? product.viewCount : 1) * 100).toStringAsFixed(1)}%',
                  Icons.trending_up,
                  Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
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
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildPerformanceChart() {
    // Mock chart that would be replaced with a real chart library (fl_chart, syncfusion, etc.)
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Performance Trend',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                DropdownButton<String>(
                  value: 'Last 30 Days',
                  items: const [
                    DropdownMenuItem(
                      value: 'Last 7 Days',
                      child: Text('Last 7 Days'),
                    ),
                    DropdownMenuItem(
                      value: 'Last 30 Days',
                      child: Text('Last 30 Days'),
                    ),
                    DropdownMenuItem(
                      value: 'Last 90 Days',
                      child: Text('Last 90 Days'),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bar_chart,
                      size: 64,
                      color: TColors.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Performance Chart',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This is a placeholder for a real chart',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewsAndSalesSection() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricCard(
            'Total Views',
            product.viewCount.toString(),
            Icons.visibility,
            Colors.blue,
            '↑ 12.5% from last month',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildMetricCard(
            'Total Sales',
            product.soldCount.toString(),
            Icons.shopping_cart,
            Colors.green,
            '↑ 8.3% from last month',
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String trend,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              trend,
              style: TextStyle(
                fontSize: 12,
                color: Colors.green.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionRateCard() {
    final conversionRate = (product.soldCount /
            (product.viewCount > 0 ? product.viewCount : 1) *
            100)
        .toStringAsFixed(1);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Conversion Rate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: double.parse(conversionRate) / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                double.parse(conversionRate) < 5
                    ? Colors.red
                    : double.parse(conversionRate) < 10
                        ? Colors.orange
                        : Colors.green,
              ),
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$conversionRate%',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Industry avg: 2.8%',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              double.parse(conversionRate) > 2.8
                  ? 'Your product is performing above industry average 🎉'
                  : 'Your product is performing below industry average',
              style: TextStyle(
                fontSize: 14,
                color: double.parse(conversionRate) > 2.8
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
