import 'package:flutter/material.dart';
import 'package:afrinova/utils/constants/sizes.dart';

class TesfaLogo extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool showText;
  final bool isDark;

  const TesfaLogo({
    super.key,
    this.size = 100,
    this.backgroundColor,
    this.foregroundColor,
    this.showText = true,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bgColor = backgroundColor ??
        (isDarkMode ? const Color(0xFF0A1A3B) : const Color(0xFF0A1A3B));
    final fgColor =
        foregroundColor ?? (isDarkMode ? Colors.amber : Colors.amber);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Logo Image
        Container(
          width: size,
          height: size,
          padding: const EdgeInsets.all(TSizes.sm),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(size / 4),
          ),
          child: Image.asset(
            'assets/logos/logo1.png',
            color: null, // Don't tint the image
          ),
        ),

        // Optional Logo Text
        if (showText)
          Padding(
            padding: const EdgeInsets.only(top: TSizes.sm),
            child: Text(
              'Tesfa',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.amber : const Color(0xFF0A1A3B),
                  ),
            ),
          ),
      ],
    );
  }
}
