import 'package:flutter/material.dart';
import 'package:afrinova/common/widgets/logo/app_logo.dart';
import 'package:afrinova/utils/constants/sizes.dart';

class LogoExampleScreen extends StatelessWidget {
  const LogoExampleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logo Examples'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Default Logo
              const TesfaLogo(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Small Logo
              const TesfaLogo(size: 60),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Logo without text
              const TesfaLogo(showText: false),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Logo with custom colors
              const TesfaLogo(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Logo in a row with text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const TesfaLogo(size: 40, showText: false),
                  const SizedBox(width: TSizes.md),
                  Text(
                    'Afrinova Pay',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
