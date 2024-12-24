import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_elevated_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.startBGcolor,
      body: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 20.h,
            vertical: 88.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 64.h),
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(horizontal: 60.h),
                padding: EdgeInsets.symmetric(vertical: 6.h),
                decoration: AppDecoration.calmbluedarker.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder40,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 3.h),
                    Text(
                      "CataList",
                      style: theme.textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomElevatedButton(
                text: "Start",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
