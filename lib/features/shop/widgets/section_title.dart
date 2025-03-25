import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;
  final bool showViewAll;
  final Color? textColor;

  const SectionTitle({
    super.key,
    required this.title,
    this.onViewAllPressed,
    this.showViewAll = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextColor = textColor ?? Colors.black87;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: defaultTextColor,
            ),
          ),
          if (showViewAll)
            TextButton(
              onPressed: onViewAllPressed,
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF0A1A3B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
