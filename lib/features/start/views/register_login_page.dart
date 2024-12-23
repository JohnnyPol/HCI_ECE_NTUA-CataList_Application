import 'package:flutter/material.dart';
import '../../../shared/themes.dart';
import '../../../shared/app_routes.dart';

class RegisterLoginPage extends StatelessWidget {
  const RegisterLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.startBGcolor,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            horizontal: 300,
            vertical: 80,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 60),
              Container(
                width: double.maxFinite,
                margin: const EdgeInsets.symmetric(horizontal: 50),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: AppDecoration.calmbluedarker.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder40,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 1),
                    Text(
                      "CataList",
                      style: AppTextStyles.displayMedium,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 16),
                  backgroundColor: AppColors.lightBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: AppTextStyles.buttonText,
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 150, vertical: 16),
                  backgroundColor: AppColors.lightBlueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: AppTextStyles.buttonText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
