import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:afrinova/navigation_menu.dart';
import 'package:afrinova/utils/constants/text_strings.dart';
import 'package:afrinova/utils/theme/theme.dart';

import 'package:afrinova/utils/language/language_controller.dart';
import 'package:firebase_core/firebase_core.dart';

class App extends StatelessWidget {
  const App({super.key});

  static bool _dependenciesInitialized = false;

  static Future<void> initDependencies() async {
    // Avoid initializing dependencies multiple times
    if (_dependenciesInitialized) return;
    _dependenciesInitialized = true;

    print('App: Initializing minimal dependencies');

    // Initialize only essential services
    // Firebase initialization is optional for direct navigation
    try {
      await Firebase.initializeApp();
    } catch (e) {
      print('Firebase initialization error: $e');
    }

    // Add minimal required dependencies
    Get.put(LanguageController());

    // Add other essential dependencies as needed
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 300),
      locale: Locale(
          Get.find<LanguageController>().selectedLanguage.value.toString()),
      // Go directly to the navigation menu, bypassing all checks
      home: const NavigationMenu(),
    );
  }
}
