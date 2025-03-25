import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final VoidCallback? onNotificationTap;
  final bool showLogo;
  final Color? textColor;
  final bool hasNotification;

  const TransparentAppBar({
    super.key,
    this.username = 'Guest User',
    this.onNotificationTap,
    this.showLogo = true,
    this.textColor,
    this.hasNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor =
        textColor ?? (isDark ? Colors.white : Colors.white);

    return Container(
      padding: const EdgeInsets.only(left: 24, right: 16, top: 8, bottom: 8),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side - Username only (no logo)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Welcome,',
                  style: TextStyle(
                    fontSize: 12,
                    color: defaultTextColor.withOpacity(0.8),
                  ),
                ),
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: defaultTextColor,
                  ),
                ),
              ],
            ),

            // Right side - Notification icon
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: onNotificationTap ?? () {},
                  icon: Icon(
                    Iconsax.notification,
                    color: defaultTextColor,
                    size: 24,
                  ),
                ),
                if (hasNotification)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFC107), // Sun color
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
