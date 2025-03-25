import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:afrinova/features/shop/widgets/promo_banner.dart';
import 'package:afrinova/features/shop/widgets/secondary_promo_banner.dart';

class PromoCarouselItems {
  static List<Widget> getPromos({
    required List<Map<String, dynamic>> promoData,
  }) {
    return promoData.map((promo) {
      if (promo['type'] == 'primary') {
        return PromoBanner(
          title: promo['title'],
          subtitle: promo['subtitle'],
          buttonText: promo['buttonText'] ?? 'Shop Now',
          onTap: promo['onTap'],
          backgroundColor: promo['backgroundColor'] ?? const Color(0xFFFFC107),
          textColor: promo['textColor'] ?? Colors.black87,
          buttonColor: promo['buttonColor'] ?? const Color(0xFF0A1A3B),
        );
      } else {
        return SecondaryPromoBanner(
          title: promo['title'],
          subtitle: promo['subtitle'],
          buttonText: promo['buttonText'] ?? 'View Offers',
          icon: promo['icon'] ?? FontAwesomeIcons.tag,
          onTap: promo['onTap'],
          backgroundColor: promo['backgroundColor'] ?? const Color(0xFF0A1A3B),
          textColor: promo['textColor'] ?? Colors.white,
          buttonColor: promo['buttonColor'] ?? const Color(0xFFFFC107),
        );
      }
    }).toList();
  }
}
