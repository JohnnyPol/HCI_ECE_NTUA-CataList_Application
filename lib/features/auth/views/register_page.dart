// login_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/auth/controllers/user_auth.dart';
import '../../../app_export.dart';
import 'custom_app_bar.dart';
import '../../../shared/widgets/start_buttons.dart';
import '../../../shared/widgets/custom_text_form_field.dart';
import '../../../shared/widgets/custom_image_view.dart';

// ignore_for_file: must_be_immutable
class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  TextEditingController usernameInputController = TextEditingController();
  TextEditingController firstNameInputController = TextEditingController();
  TextEditingController lastNameInputController = TextEditingController();
  TextEditingController emailInputController = TextEditingController();
  TextEditingController passwordInputController = TextEditingController();
  TextEditingController reenterPasswordInputController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: appTheme.startBGcolor,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: SizedBox(
                height: SizeUtils.height,
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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
                          SizedBox(height: 10.h),
                          Text(
                            "CataList",
                            style: theme.textTheme.displayMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40.h),
                    _buildUsernameInput(context),
                    SizedBox(height: 16.h),
                    _buildFirstNameInput(context),
                    SizedBox(height: 16.h),
                    _buildLastNameInput(context),
                    SizedBox(height: 16.h),
                    _buildEmailInput(context),
                    SizedBox(height: 16.h),
                    _buildPasswordInput(context),
                    SizedBox(height: 16.h),
                    _buildReenterPasswordInput(context),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: _buildCompleteSection(context));
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: CustomTextFormField(
        controller: usernameInputController,
        hintText: "Username",
        prefix: Container(
          margin: EdgeInsets.fromLTRB(6.h, 6.h, 26.h, 6.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgProfile,
            height: 32.h,
            width: 26.h,
            fit: BoxFit.contain,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 48.h,
        ),
        contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
      ),
    );
  }

// Section Widget
  Widget _buildFirstNameInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: CustomTextFormField(
        controller: firstNameInputController,
        hintText: "First Name",
        prefix: Container(
          margin: EdgeInsets.fromLTRB(6.h, 6.h, 26.h, 6.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgProfile,
            height: 32.h,
            width: 26.h,
            fit: BoxFit.contain,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 48.h,
        ),
        contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
      ),
    );
  }

// Section Widget
  Widget _buildEmailInput(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.h),
        child: CustomTextFormField(
          controller: emailInputController,
          hintText: "Email",
          prefix: Container(
            margin: EdgeInsets.fromLTRB(6.h, 6.h, 26.h, 6.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgEmail,
              height: 32.h,
              width: 26.h,
              fit: BoxFit.contain,
            ),
          ),
          prefixConstraints: BoxConstraints(
            maxHeight: 48.h,
          ),
          contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
        ));
  }

  // Section Widget
  Widget _buildLastNameInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: CustomTextFormField(
        controller: lastNameInputController,
        hintText: "Last Name",
        prefix: Container(
          margin: EdgeInsets.fromLTRB(6.h, 6.h, 26.h, 6.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgProfile,
            height: 32.h,
            width: 26.h,
            fit: BoxFit.contain,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 48.h,
        ),
        contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: CustomTextFormField(
        controller: passwordInputController,
        hintText: "Password",
        textInputAction: TextInputAction.done,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(6.h, 6.h, 26.h, 6.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgLock,
            height: 32.h,
            width: 26.h,
            fit: BoxFit.contain,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 48.h,
        ),
        obscureText: true,
        contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
      ),
    );
  }

  Widget _buildReenterPasswordInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: CustomTextFormField(
        controller: passwordInputController,
        hintText: "Password",
        textInputAction: TextInputAction.done,
        prefix: Container(
          margin: EdgeInsets.fromLTRB(6.h, 6.h, 26.h, 6.h),
          child: CustomImageView(
            imagePath: ImageConstant.imgLock,
            height: 32.h,
            width: 26.h,
            fit: BoxFit.contain,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: 48.h,
        ),
        obscureText: true,
        contentPadding: EdgeInsets.fromLTRB(6.h, 6.h, 12.h, 6.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildCompleteSection(BuildContext context) {
    return CustomElevatedButton(
      text: "Complete",
      margin: EdgeInsets.only(bottom: 20.h),
      onPressed: () async {
        String username = usernameInputController.text.trim();
        String firstName = firstNameInputController.text.trim();
        String lastName = lastNameInputController.text.trim();
        String password = passwordInputController.text.trim();
        String email = emailInputController.text.trim();

        if (username.isEmpty || password.isEmpty || email.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please fill in all fields')),
          );
          return;
        }

        // Show a loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(child: CircularProgressIndicator()),
        );

        // Create the new user
        bool isCreated = await registerNewUser(
            username, firstName, lastName, password, email);
        Navigator.pop(context);
        if (isCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User created successfully')),
          );
          Navigator.pushNamed(
              context, AppRoutes.home); // Navigate back or to the login page
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Username already exists. Please try another.')),
          );
        }
        ;
      },
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
