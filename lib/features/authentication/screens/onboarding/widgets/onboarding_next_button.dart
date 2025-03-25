import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:afrinova/features/authentication/controllers.onboarding/onboarding_controller.dart';
import 'package:afrinova/utils/constants/colors.dart';
import 'package:afrinova/utils/constants/sizes.dart';
import 'package:afrinova/utils/device/device_utility.dart';
import 'package:afrinova/utils/helpers/helper_functions.dart';

// ignore: camel_case_types
class onBoardingNextButton extends StatelessWidget {
  const onBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
          onPressed: () => OnBoardingController.instance.nextPage(),
          style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              backgroundColor: dark ? TColors.primary : Colors.black),
          child: const Icon(Iconsax.arrow_right_3)),
    );
  }
}
