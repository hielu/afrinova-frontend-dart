import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:afrinova/features/shop/screens/shop_screen.dart';
import 'package:afrinova/features/wallet/home/home.dart';
import 'package:afrinova/features/wallet/screens/wallet_screen.dart';
import 'package:afrinova/features/messages/screens/messages_screen.dart';
import 'package:afrinova/features/settings/screens/settings_screen.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(() => NavigationBar(
            height: 80,
            elevation: 0,
            backgroundColor: dark ? Colors.black : Colors.white,
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
            destinations: const [
              NavigationDestination(icon: Icon(Iconsax.home), label: "Home"),
              NavigationDestination(icon: Icon(Iconsax.shop), label: "Shop"),
              NavigationDestination(
                  icon: Icon(Iconsax.wallet), label: "Wallet"),
              NavigationDestination(
                  icon: Icon(Iconsax.message), label: "Messages"),
              NavigationDestination(
                  icon: Icon(Iconsax.setting), label: "Settings"),
            ],
          )),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final List<Widget> screens = [
    const HomeScreen(),
    const ShopScreen(),
    const WalletScreen(),
    const MessagesScreen(),
    const SettingsScreen(),
  ];

  void setScreen(int index) {
    if (index >= 0 && index < screens.length) {
      selectedIndex.value = index;
    } else {
      Get.snackbar(
        "Error",
        "Invalid menu option selected. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
