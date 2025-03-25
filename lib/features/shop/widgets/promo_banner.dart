import 'package:flutter/material.dart';

class PromoBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color textColor;
  final Color buttonColor;

  const PromoBanner({
    super.key,
    required this.title,
    required this.subtitle,
    this.buttonText = 'Shop Now',
    this.onTap,
    this.backgroundColor = const Color(0xFFFFC107),
    this.textColor = Colors.black87,
    this.buttonColor = const Color(0xFF0A1A3B),
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: 120,
        maxHeight: isSmallScreen ? 200 : 170,
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
          // Decorative circles
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.all(isSmallScreen ? 10.0 : 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Text content
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: textColor,
                              fontSize: isSmallScreen ? 16 : 20,
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
                          SizedBox(height: isSmallScreen ? 8 : 12),
                          SizedBox(
                            height: isSmallScreen ? 28 : 32,
                            child: ElevatedButton(
                              onPressed: onTap,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: buttonColor,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(
                                  horizontal: isSmallScreen ? 10 : 14,
                                  vertical: isSmallScreen ? 4 : 6,
                                ),
                                minimumSize: Size(0, isSmallScreen ? 28 : 32),
                                textStyle: TextStyle(
                                  fontSize: isSmallScreen ? 11 : 13,
                                ),
                              ),
                              child: Text(buttonText),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),

                // Space for potential image
                SizedBox(width: isSmallScreen ? 30 : 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
