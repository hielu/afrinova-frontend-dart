import 'package:flutter/material.dart';
import 'package:afrinova/app.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep the splash screen visible until initialization is complete
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase and other dependencies (minimal initialization)
  await App.initDependencies();

  // Remove the splash screen when ready
  FlutterNativeSplash.remove();

  // Run the app directly
  runApp(const App());
}
