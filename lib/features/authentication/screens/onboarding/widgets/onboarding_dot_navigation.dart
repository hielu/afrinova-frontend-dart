import 'package:flutter/material.dart';
import 'package:afrinova/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:afrinova/utils/constants/sizes.dart';
import 'package:afrinova/utils/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:afrinova/utils/helpers/helper_functions.dart';
import 'package:afrinova/utils/constants/colors.dart';

// ignore: camel_case_types
class onBoardingDotNavigation extends StatelessWidget {
  const onBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
        bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
        left: TSizes.defaultSpace,
        child: SmoothPageIndicator(
          controller: controller.pageController,
          onDotClicked: controller.dotNavigationClick,
          count: 4,
          effect: ExpandingDotsEffect(
              activeDotColor: dark ? TColors.light : TColors.dark,
              dotHeight: 6),
        ));
  }
}
