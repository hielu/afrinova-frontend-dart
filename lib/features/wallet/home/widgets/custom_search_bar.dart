import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool readOnly;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Function(String)? onSubmitted;
  final Widget? suffixIcon;
  final VoidCallback? onFilterTap;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Search in Store',
    this.onTap,
    this.controller,
    this.readOnly = true,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.borderRadius,
    this.padding,
    this.onSubmitted,
    this.suffixIcon,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    final defaultBackgroundColor = backgroundColor ?? Colors.white;
    final defaultIconColor = iconColor ?? Colors.grey;
    final defaultTextColor = textColor ?? Colors.grey;
    final defaultBorderRadius = borderRadius ?? BorderRadius.circular(30);
    final defaultPadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

    return Container(
      padding: defaultPadding,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        onTap: onTap,
        onSubmitted: onSubmitted,
        style: TextStyle(color: defaultTextColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: defaultBackgroundColor,
          hintText: hintText,
          hintStyle: TextStyle(color: defaultTextColor.withOpacity(0.7)),
          prefixIcon: Icon(Iconsax.search_normal, color: defaultIconColor),
          suffixIcon: suffixIcon ??
              (onFilterTap != null
                  ? IconButton(
                      icon: Icon(Icons.filter_list, color: defaultIconColor),
                      onPressed: onFilterTap,
                    )
                  : null),
          border: OutlineInputBorder(
            borderRadius: defaultBorderRadius,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: defaultBorderRadius,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: defaultBorderRadius,
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
