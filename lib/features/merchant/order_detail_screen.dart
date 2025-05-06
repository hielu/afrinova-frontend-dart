import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'models/order.dart';

class OrderItem {
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  OrderItem({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}

class MockOrderDetails {
  final String transactionId;
  final String paymentMethod;
  final String phoneNumber;
  final String address;
  final String city;
  final String region;
  final String country;
  final String zipCode;
  final double deliveryFee;
  final double taxAmount;
  final List<OrderItem> items;

  MockOrderDetails({
    required this.transactionId,
    required this.paymentMethod,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.region,
    required this.country,
    required this.zipCode,
    required this.deliveryFee,
    required this.taxAmount,
    required this.items,
  });

  static MockOrderDetails getOrderDetails(Order order) {
    // This would normally come from API or database
    return MockOrderDetails(
      transactionId: 'TXN-${order.orderId.substring(4)}',
      paymentMethod: 'Credit Card',
      phoneNumber: '+1 (555) 123-4567',
      address: '123 Main Street, Apt 4B',
      city: 'Metro City',
      region: 'Eastern',
      country: 'United States',
      zipCode: '10001',
      deliveryFee: 5.99,
      taxAmount: order.totalAmount * 0.07,
      items: [
        OrderItem(
          name: 'Blue Cotton T-Shirt (L)',
          imageUrl: 'https://via.placeholder.com/80',
          price: 24.99,
          quantity: 2,
        ),
        OrderItem(
          name: 'Denim Jeans - Slim Fit',
          imageUrl: 'https://via.placeholder.com/80',
          price: 49.99,
          quantity: 1,
        ),
        OrderItem(
          name: 'Wireless Headphones',
          imageUrl: 'https://via.placeholder.com/80',
          price: 59.99,
          quantity: order.itemCount - 3,
        ),
      ],
    );
  }
}

class OrderDetailScreen extends StatefulWidget {
  final Order order;

  const OrderDetailScreen({
    super.key,
    required this.order,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late String currentStatus;
  late MockOrderDetails orderDetails;
  final currencyFormat = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  // Mock escrow status for demo purposes
  String escrowStatus = "locked"; // "locked" | "released"

  @override
  void initState() {
    super.initState();
    currentStatus = widget.order.status;
    orderDetails = MockOrderDetails.getOrderDetails(widget.order);

    // Initialize escrow status based on order status
    // In a real app, this would come from the Order object
    if (currentStatus.toLowerCase() == "completed") {
      escrowStatus = "released";
    }
  }

  void _updateOrderStatus(String newStatus) {
    setState(() {
      currentStatus = newStatus;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order status updated to $newStatus'),
        backgroundColor: _getStatusColor(newStatus),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll(RegExp(r'[^\d+]'), ''),
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      // Handle case where calling is not supported
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch phone dialer'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double subtotal = orderDetails.items
        .fold(0, (sum, item) => sum + (item.price * item.quantity));

    final double total =
        subtotal + orderDetails.deliveryFee + orderDetails.taxAmount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Main scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order Metadata section
                    _buildOrderMetadataCard(),
                    const SizedBox(height: 16),

                    // Escrow Status section
                    _buildEscrowStatusCard(),
                    const SizedBox(height: 16),

                    // Order Progress Timeline
                    _buildOrderProgressTimeline(),
                    const SizedBox(height: 16),

                    // Customer Information section
                    _buildCustomerInfoCard(),
                    const SizedBox(height: 16),

                    // Order Items section
                    _buildOrderItemsCard(),
                    const SizedBox(height: 16),

                    // Order Summary section
                    _buildOrderSummaryCard(subtotal, total),
                    const SizedBox(height: 16),

                    // QR Code section (only if status is shipped and escrow is locked)
                    if (currentStatus.toLowerCase() == "shipped" &&
                        escrowStatus == "locked")
                      _buildQrCodeSection(),
                  ],
                ),
              ),
            ),

            // Action buttons - fixed at bottom
            _buildActionButtonsBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderMetadataCard() {
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
            // Order ID and Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Order ID',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            widget.order.orderId,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: widget.order.orderId));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Order ID copied to clipboard'),
                                  behavior: SnackBarBehavior.floating,
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.copy,
                              size: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(currentStatus),
              ],
            ),
            const Divider(height: 24),

            // Date and Transaction Details
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Date & Time',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('MMM d, yyyy • h:mm a')
                            .format(widget.order.orderDate),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Payment Method',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        orderDetails.paymentMethod,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transaction ID',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        orderDetails.transactionId,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfoCard() {
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
              'Customer Information',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Customer Name
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.grey.shade200,
                  child: Text(
                    widget.order.customerInitials ??
                        widget.order.customerName.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.order.customerName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 24),

            // Phone Number
            Row(
              children: [
                const Icon(
                  Icons.phone,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    orderDetails.phoneNumber,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _makePhoneCall(orderDetails.phoneNumber),
                  icon: const Icon(Icons.call, color: Colors.green),
                  tooltip: 'Call customer',
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(8),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Shipping Address
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  size: 18,
                  color: Colors.grey,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderDetails.address,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${orderDetails.city}, ${orderDetails.region} ${orderDetails.zipCode}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        orderDetails.country,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Open maps would go here in a real implementation
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Map view would open here'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.map, color: Colors.blue),
                  tooltip: 'View on map',
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(8),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemsCard() {
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
                  'Order Items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${widget.order.itemCount} ${widget.order.itemCount == 1 ? 'item' : 'items'}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // List of items
            ...orderDetails.items.map((item) => _buildOrderItemTile(item)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemTile(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey.shade200,
                  child:
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  currencyFormat.format(item.price),
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Qty: ${item.quantity}',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),

          // Subtotal
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                currencyFormat.format(item.price * item.quantity),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard(double subtotal, double total) {
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
              'Order Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Subtotal
            _buildSummaryRow('Subtotal', currencyFormat.format(subtotal)),
            const SizedBox(height: 8),

            // Delivery fee
            _buildSummaryRow('Delivery Fee',
                currencyFormat.format(orderDetails.deliveryFee)),
            const SizedBox(height: 8),

            // Tax
            _buildSummaryRow(
                'Tax', currencyFormat.format(orderDetails.taxAmount)),

            const Divider(height: 24),

            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currencyFormat.format(total),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtonsBar() {
    // Return different buttons based on order status
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: _getActionButtonsForStatus(),
    );
  }

  Widget _getActionButtonsForStatus() {
    switch (currentStatus.toLowerCase()) {
      case 'pending':
        return Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => _updateOrderStatus('Cancelled'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: Colors.red),
                ),
                child: const Text(
                  'Cancel Order',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _updateOrderStatus('Accepted'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Accept Order'),
              ),
            ),
          ],
        );

      case 'accepted':
        return ElevatedButton(
          onPressed: () => _updateOrderStatus('Shipped'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.deepPurple,
          ),
          child: const Text('Mark as Shipped'),
        );

      case 'shipped':
        return ElevatedButton(
          onPressed: () => _updateOrderStatus('Completed'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            backgroundColor: Colors.green,
          ),
          child: const Text('Mark as Completed'),
        );

      case 'completed':
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '✓ This order has been completed',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

      case 'cancelled':
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            '✗ This order has been cancelled',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );

      default:
        return const SizedBox();
    }
  }

  Widget _buildStatusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.amber;
      case 'accepted':
        return Colors.blue;
      case 'shipped':
        return Colors.deepPurple;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildEscrowStatusCard() {
    final bool isReleased = escrowStatus == "released";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isReleased
                    ? Colors.green.withOpacity(0.1)
                    : Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isReleased ? Icons.lock_open : Icons.lock,
                color: isReleased ? Colors.green : Colors.amber,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Escrow Status',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isReleased
                        ? 'Escrow Released to You'
                        : 'Funds Held in Escrow',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isReleased ? Colors.green : Colors.amber.shade800,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isReleased ? Colors.green : Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isReleased ? 'PAID' : 'PENDING',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderProgressTimeline() {
    // Define the order stages
    final List<Map<String, dynamic>> stages = [
      {
        'title': 'Paid',
        'description': 'Order placed and payment received',
        'icon': Icons.payments_outlined,
        'isCompleted': true, // Always completed if the order exists
      },
      {
        'title': 'Processing',
        'description': 'Order accepted by merchant',
        'icon': Icons.inventory_2_outlined,
        'isCompleted': ['accepted', 'shipped', 'completed']
            .contains(currentStatus.toLowerCase()),
      },
      {
        'title': 'Shipped',
        'description': 'Order has been shipped',
        'icon': Icons.local_shipping_outlined,
        'isCompleted':
            ['shipped', 'completed'].contains(currentStatus.toLowerCase()),
      },
      {
        'title': 'Escrow Released',
        'description': 'Buyer confirmed delivery',
        'icon': Icons.lock_open_outlined,
        'isCompleted': escrowStatus == "released",
      },
    ];

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
              'Order Progress',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(stages.length, (index) {
              final stage = stages[index];
              final isLast = index == stages.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline line and dot
                  SizedBox(
                    width: 24,
                    child: Column(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: stage['isCompleted']
                                ? Colors.green
                                : Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            stage['icon'],
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        if (!isLast)
                          Container(
                            width: 2,
                            height: 30,
                            color: stage['isCompleted']
                                ? Colors.green
                                : Colors.grey.shade300,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Stage information
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stage['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: stage['isCompleted']
                                  ? Colors.black
                                  : Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            stage['description'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCodeSection() {
    final qrData = "ORDER-${widget.order.orderId}";

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Delivery Confirmation',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: QrImageView(
                data: qrData,
                version: QrVersions.auto,
                size: 200,
                errorStateBuilder: (context, error) => Center(
                  child: Text(
                    'Error generating QR code',
                    style: TextStyle(color: Colors.red.shade400),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Ask the buyer to scan this QR code upon delivery to release your payment from escrow.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                // In a real app, this might open a fullscreen QR or share it
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('QR code saved to clipboard'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              icon: const Icon(Icons.share),
              label: const Text('Share QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
