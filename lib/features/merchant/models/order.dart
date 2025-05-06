class Order {
  final String orderId;
  final String customerName;
  final DateTime orderDate;
  final String status;
  final int itemCount;
  final double totalAmount;
  final String? customerInitials;
  final String? customerAvatar;

  Order({
    required this.orderId,
    required this.customerName,
    required this.orderDate,
    required this.status,
    required this.itemCount,
    required this.totalAmount,
    this.customerInitials,
    this.customerAvatar,
  });

  // Sample data generator for demo purposes
  static List<Order> getSampleOrders() {
    return [
      Order(
        orderId: 'ORD-2023-0123',
        customerName: 'John Doe',
        orderDate: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'Pending',
        itemCount: 3,
        totalAmount: 149.99,
        customerInitials: 'JD',
      ),
      Order(
        orderId: 'ORD-2023-0122',
        customerName: 'Sarah Smith',
        orderDate: DateTime.now().subtract(const Duration(hours: 6)),
        status: 'Accepted',
        itemCount: 1,
        totalAmount: 49.99,
        customerInitials: 'SS',
      ),
      Order(
        orderId: 'ORD-2023-0120',
        customerName: 'Robert Johnson',
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
        status: 'Shipped',
        itemCount: 5,
        totalAmount: 249.99,
        customerInitials: 'RJ',
      ),
      Order(
        orderId: 'ORD-2023-0118',
        customerName: 'Emily Wilson',
        orderDate: DateTime.now().subtract(const Duration(days: 2)),
        status: 'Completed',
        itemCount: 2,
        totalAmount: 99.99,
        customerInitials: 'EW',
      ),
      Order(
        orderId: 'ORD-2023-0115',
        customerName: 'Michael Brown',
        orderDate: DateTime.now().subtract(const Duration(days: 3)),
        status: 'Cancelled',
        itemCount: 4,
        totalAmount: 199.99,
        customerInitials: 'MB',
      ),
      Order(
        orderId: 'ORD-2023-0112',
        customerName: 'Linda Harris',
        orderDate: DateTime.now().subtract(const Duration(days: 4)),
        status: 'Completed',
        itemCount: 2,
        totalAmount: 79.99,
        customerInitials: 'LH',
      ),
      Order(
        orderId: 'ORD-2023-0109',
        customerName: 'David Martinez',
        orderDate: DateTime.now().subtract(const Duration(days: 5)),
        status: 'Completed',
        itemCount: 1,
        totalAmount: 59.99,
        customerInitials: 'DM',
      ),
    ];
  }
}
