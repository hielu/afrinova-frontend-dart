import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecondaryPromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final IconData icon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color buttonColor;

  const SecondaryPromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.buttonText = 'View Offers',
    this.icon = FontAwesomeIcons.tag,
    this.onTap,
    this.backgroundColor = const Color(0xFF0A1A3B),
    this.textColor = Colors.white,
    this.buttonColor = const Color(0xFFFFC107),
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 100,
        maxHeight: isSmallScreen ? 160 : 140,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative elements
          Positioned(
            top: -10,
            right: -10,
            child: Icon(
              icon,
              size: 80,
              color: Colors.white.withOpacity(0.1),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 10.0 : 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                Container(
                  width: isSmallScreen ? 40 : 50,
                  height: isSmallScreen ? 40 : 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: isSmallScreen ? 20 : 24,
                    ),
                  ),
                ),

                SizedBox(width: isSmallScreen ? 10 : 14),

                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: textColor,
                          fontSize: isSmallScreen ? 16 : 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: isSmallScreen ? 4 : 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: textColor.withOpacity(0.8),
                          fontSize: isSmallScreen ? 11 : 13,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: isSmallScreen ? 8 : 12),

                // Button
                SizedBox(
                  height: isSmallScreen ? 28 : 32,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.black87,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSmallScreen ? 10 : 14,
                        vertical: isSmallScreen ? 4 : 6,
                      ),
                      minimumSize: Size(0, isSmallScreen ? 28 : 32),
                      textStyle: TextStyle(
                        fontSize: isSmallScreen ? 11 : 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
