// login_page.dart

import 'package:flutter/material.dart';
import '../../../app_export.dart';
import 'custom_app_bar.dart';
import '../../../shared/widgets/start_buttons.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/custom_image_view.dart';
import '../controllers/user_auth.dart';

// ignore_for_file: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.startBGcolor,
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.h,
                    vertical: 76.h,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      _buildUsernameInput(context),
                      SizedBox(height: 22.h),
                      _buildPasswordInput(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildCompleteSection(context),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 36.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.registerLogin);
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildUsernameInput(BuildContext context) {
    return CustomTextFormField(
      controller: usernameInputController,
      hintText: "Username",
      textInputAction: TextInputAction.done,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(6.h, 6.h, 26.h, 6.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgProfile,
          height: 26.h,
          width: 26.h,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 48.h,
      ),
      obscureText: false,
      contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
    );
  }

  /// Section Widget
  Widget _buildPasswordInput(BuildContext context) {
    return CustomTextFormField(
      controller: passwordInputController,
      hintText: "Password",
      textInputAction: TextInputAction.done,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(6.h, 6.h, 26.h, 6.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgLock,
          height: 26.h,
          width: 26.h,
          fit: BoxFit.contain,
        ),
      ),
      prefixConstraints: BoxConstraints(
        maxHeight: 48.h,
      ),
      obscureText: true,
      contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
    );
  }

  /// Section Widget
  Widget _buildCompleteButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Complete",
      margin: EdgeInsets.only(bottom: 12.h),
      onPressed: () async {
        String username = usernameInputController.text.trim();
        String password = passwordInputController.text.trim();
        if (username.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter both username and password')),
          );
          return;
        }
        // Show a loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );
        // Authenticate user
        bool isAuthenticated = await authenticateUser(username, password);

        // Dismiss the loading indicator
        Navigator.pop(context);

        if (isAuthenticated) {
          // Navigate to home page
          Navigator.pushNamed(context, AppRoutes.home);
        } else {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid username or password')),
          );
        }
        ;
      },
    );
  }

  /// Section Widget
  Widget _buildCompleteSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [_buildCompleteButton(context)],
      ),
    );
  }
}

class AppbarLeadingImage extends StatelessWidget {
  AppbarLeadingImage(
      {Key? key,
      this.imagePath,
      this.height,
      this.width,
      this.onTap,
      this.margin})
      : super(
          key: key,
        );
  final double? height;
  final double? width;
  final String? imagePath;
  final Function? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: CustomImageView(
          imagePath: imagePath!,
          height: height ?? 32.h,
          width: width ?? 36.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
