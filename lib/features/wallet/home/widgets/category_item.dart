import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final dynamic icon; // Can be IconData or FontAwesomeIcon
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final double iconSize;

  const CategoryItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBackgroundColor = backgroundColor ?? Colors.white;
    final defaultIconColor = iconColor ?? const Color(0xFF0A1A3B);
    final defaultTextColor = textColor ?? Colors.black87;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular icon container
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: defaultBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: _buildIcon(defaultIconColor),
            ),
          ),
          const SizedBox(height: 8),
          // Category title
          Text(
            title,
            style: TextStyle(
              color: defaultTextColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(Color color) {
    if (icon is IconData) {
      return Icon(
        icon as IconData,
        color: color,
        size: iconSize,
      );
    } else if (icon is FaIcon) {
      final faIcon = icon as FaIcon;
      return FaIcon(
        faIcon.icon,
        color: color,
        size: iconSize,
      );
    } else {
      return Icon(
        Icons.category,
        color: color,
        size: iconSize,
      );
    }
  }
}
