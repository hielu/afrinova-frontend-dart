import 'package:flutter/material.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:ui';

class MerchantAnalyticsScreen extends StatefulWidget {
  const MerchantAnalyticsScreen({super.key});

  @override
  State<MerchantAnalyticsScreen> createState() =>
      _MerchantAnalyticsScreenState();
}

class _MerchantAnalyticsScreenState extends State<MerchantAnalyticsScreen> {
  String _selectedTimeRange = 'Last 7 Days';
  final List<String> _timeRanges = ['Last 7 Days', 'Last 30 Days', 'Custom'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Analytics',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: TColors.primary,
        foregroundColor: TColors.textWhite,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Refresh analytics data
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Refreshing analytics data...')),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background with gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  TColors.primary.withOpacity(0.1),
                  Colors.white.withOpacity(0.7),
                  Colors.white,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),

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

          // Main content
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // KPI Summary Cards
                    _buildKPISummaryCards(),

                    const SizedBox(height: 24),

                    // Sales Over Time Chart
                    _buildSectionHeader('Sales Trends'),
                    _buildTimeRangeSelector(),
                    _buildSalesChart(),

                    const SizedBox(height: 24),

                    // Top Selling Products
                    _buildSectionHeader('Top Selling Products'),
                    _buildTopSellingProducts(),

                    const SizedBox(height: 24),

                    // Category Sales Distribution
                    _buildSectionHeader('Category Sales Distribution'),
                    _buildCategorySalesChart(),

                    const SizedBox(height: 24),

                    // Customer Insights
                    _buildSectionHeader('Customer Insights'),
                    _buildCustomerInsights(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: TColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: TColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassCard({
    required Widget child,
    double? width,
    double? height,
    EdgeInsets padding = const EdgeInsets.all(16),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(20)),
  }) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                TColors.primary.withOpacity(0.15),
                TColors.primary.withOpacity(0.05),
              ],
            ),
            borderRadius: borderRadius,
            border: Border.all(
              color: TColors.primary.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: TColors.primary.withOpacity(0.15),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildKPISummaryCards() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildKPICard(
          title: 'Total Revenue',
          value: 'UGX 4.2M',
          icon: Icons.attach_money,
          iconColor: Colors.green,
          trend: '+12%',
          trendUp: true,
        ),
        _buildKPICard(
          title: 'Total Orders',
          value: '156',
          icon: Icons.shopping_cart,
          iconColor: TColors.primary,
          trend: '+8%',
          trendUp: true,
        ),
        _buildKPICard(
          title: 'Conversion Rate',
          value: '24%',
          icon: Icons.trending_up,
          iconColor: Colors.orange,
          trend: '+5%',
          trendUp: true,
        ),
        _buildKPICard(
          title: 'Returning Customers',
          value: '42',
          icon: Icons.people,
          iconColor: Colors.blue,
          trend: '-3%',
          trendUp: false,
        ),
      ],
    );
  }

  Widget _buildKPICard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required String trend,
    required bool trendUp,
  }) {
    return _buildGlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: (trendUp ? Colors.green : Colors.red)
                          .withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      trendUp ? Icons.arrow_upward : Icons.arrow_downward,
                      color: trendUp ? Colors.green : Colors.red,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      trend,
                      style: TextStyle(
                        color: trendUp ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: TColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: TColors.primary.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeRangeSelector() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: _buildGlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: TColors.primary, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedTimeRange,
                  icon: Container(
                    decoration: BoxDecoration(
                      color: TColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(Icons.keyboard_arrow_down,
                        color: TColors.primary, size: 16),
                  ),
                  isExpanded: true,
                  dropdownColor: Colors.white.withOpacity(0.95),
                  items: _timeRanges.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: TColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedTimeRange = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSalesChart() {
    return _buildGlassCard(
      height: 300,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, top: 16),
        child: LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.white.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: TColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    );
                    String text;
                    switch (value.toInt()) {
                      case 0:
                        text = 'Mon';
                        break;
                      case 1:
                        text = 'Tue';
                        break;
                      case 2:
                        text = 'Wed';
                        break;
                      case 3:
                        text = 'Thu';
                        break;
                      case 4:
                        text = 'Fri';
                        break;
                      case 5:
                        text = 'Sat';
                        break;
                      case 6:
                        text = 'Sun';
                        break;
                      default:
                        text = '';
                    }
                    return SideTitleWidget(
                      axisSide: meta.axisSide,
                      child: Text(text, style: style),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    const style = TextStyle(
                      color: TColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    );
                    String text;
                    switch (value.toInt()) {
                      case 0:
                        text = '0';
                        break;
                      case 1:
                        text = '500K';
                        break;
                      case 2:
                        text = '1M';
                        break;
                      case 3:
                        text = '1.5M';
                        break;
                      case 4:
                        text = '2M';
                        break;
                      default:
                        return Container();
                    }
                    return Text(text,
                        style: style, textAlign: TextAlign.center);
                  },
                  reservedSize: 40,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 4,
            lineBarsData: [
              LineChartBarData(
                spots: const [
                  FlSpot(0, 1.5),
                  FlSpot(1, 2.0),
                  FlSpot(2, 1.8),
                  FlSpot(3, 2.5),
                  FlSpot(4, 2.2),
                  FlSpot(5, 3.0),
                  FlSpot(6, 3.5),
                ],
                isCurved: true,
                color: TColors.primary,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 4,
                      color: TColors.primary,
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: TColors.primary.withOpacity(0.2),
                ),
              ),
            ],
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.white.withOpacity(0.8),
                tooltipRoundedRadius: 8,
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    final revenue = barSpot.y * 500000;
                    return LineTooltipItem(
                      'UGX ${revenue.toStringAsFixed(0)}',
                      const TextStyle(
                        color: TColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopSellingProducts() {
    // Mock data for top selling products
    final List<Map<String, dynamic>> topProducts = [
      {
        'name': 'Premium T-Shirt',
        'image': 'https://via.placeholder.com/50',
        'revenue': 'UGX 800K',
        'sold': 120,
      },
      {
        'name': 'Leather Wallet',
        'image': 'https://via.placeholder.com/50',
        'revenue': 'UGX 650K',
        'sold': 95,
      },
      {
        'name': 'Smart Watch',
        'image': 'https://via.placeholder.com/50',
        'revenue': 'UGX 580K',
        'sold': 58,
      },
      {
        'name': 'Wireless Earbuds',
        'image': 'https://via.placeholder.com/50',
        'revenue': 'UGX 480K',
        'sold': 72,
      },
      {
        'name': 'Phone Case',
        'image': 'https://via.placeholder.com/50',
        'revenue': 'UGX 320K',
        'sold': 150,
      },
    ];

    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: topProducts.length,
        itemBuilder: (context, index) {
          final product = topProducts[index];
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0 ? 0 : 12,
              right: index == topProducts.length - 1 ? 0 : 4,
            ),
            child: _buildGlassCard(
              width: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: TColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '#${index + 1}',
                            style: const TextStyle(
                              color: TColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${product['sold']} sold',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    product['revenue'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: TColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategorySalesChart() {
    return _buildGlassCard(
      height: 330,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Revenue by Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      value: 35,
                      title: '35%',
                      color: TColors.primary,
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      badgeWidget: _buildCategoryBadge(
                          Icons.shopping_bag, TColors.primary),
                      badgePositionPercentageOffset: 1.0,
                    ),
                    PieChartSectionData(
                      value: 25,
                      title: '25%',
                      color: TColors.secondary,
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      badgeWidget:
                          _buildCategoryBadge(Icons.devices, TColors.secondary),
                      badgePositionPercentageOffset: 1.0,
                    ),
                    PieChartSectionData(
                      value: 20,
                      title: '20%',
                      color: Colors.orange,
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      badgeWidget:
                          _buildCategoryBadge(Icons.home, Colors.orange),
                      badgePositionPercentageOffset: 1.0,
                    ),
                    PieChartSectionData(
                      value: 15,
                      title: '15%',
                      color: Colors.green,
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      badgeWidget:
                          _buildCategoryBadge(Icons.local_dining, Colors.green),
                      badgePositionPercentageOffset: 1.0,
                    ),
                    PieChartSectionData(
                      value: 5,
                      title: '5%',
                      color: Colors.purple,
                      radius: 100,
                      titleStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      badgeWidget:
                          _buildCategoryBadge(Icons.category, Colors.purple),
                      badgePositionPercentageOffset: 1.0,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildCategoryLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Icon(icon, color: color, size: 16),
    );
  }

  Widget _buildCategoryLegend() {
    final categories = [
      {
        'name': 'Clothing',
        'color': TColors.primary,
        'icon': Icons.shopping_bag
      },
      {
        'name': 'Electronics',
        'color': TColors.secondary,
        'icon': Icons.devices
      },
      {'name': 'Home Decor', 'color': Colors.orange, 'icon': Icons.home},
      {'name': 'Food', 'color': Colors.green, 'icon': Icons.local_dining},
      {'name': 'Others', 'color': Colors.purple, 'icon': Icons.category},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: categories.map((category) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: category['color'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              category['name'] as String,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCustomerInsights() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildGlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Customers',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          '68',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: TColors.primary,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'this month',
                          style: TextStyle(
                            fontSize: 12,
                            color: TColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildGlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Avg. Order Value',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Text(
                          'UGX 27K',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildGlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Customer Locations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              _buildLocationBar('Kampala', 65, TColors.primary),
              const SizedBox(height: 12),
              _buildLocationBar('Entebbe', 15, Colors.blue),
              const SizedBox(height: 12),
              _buildLocationBar('Jinja', 10, Colors.orange),
              const SizedBox(height: 12),
              _buildLocationBar('Mbarara', 7, Colors.green),
              const SizedBox(height: 12),
              _buildLocationBar('Others', 3, Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationBar(String location, int percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              location,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '$percentage%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Stack(
          children: [
            Container(
              height: 8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              height: 8,
              width:
                  MediaQuery.of(context).size.width * (percentage / 100) * 0.8,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
