// import 'package:flutter/material.dart';
// import '../../../shared/themes.dart';

// TextEditingController usernameInputController = TextEditingController();
// TextEditingController passwordInputController = TextEditingController();

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     backgroundColor: AppColors.startBGcolor,
//     resizeToAvoidBottomInset: false,
//     appBar: _buildAppBar(context),
//     body: SafeArea(
//       top: false,
//       child: SizedBox(
//         width: double.maxFinite,
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 width: double.maxFinite,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 8.0,
//                   vertical: 76.0,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(height: 28.0),
//                     _buildCatalistButton(context),
//                     Spacer(),
//                     _buildUsernameInput(context),
//                     SizedBox(height: 22.0),
//                     _buildPasswordInput(context),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//     bottomNavigationBar: _buildCompleteSection(context),
//   );
// }

// /// Section Widget
// PreferredSizeWidget _buildAppBar(BuildContext context) {
//   return CustomAppBar(
//     leadingWidth: 36.0,
//     leading: AppBarLeadingImage(
//       imagePath: ImageConstant.imgArrowLeft,
//     ),
//   );
// }

// /// Section Widget
// Widget _buildCatalistButton(BuildContext context) {
//   return CustomElevatedButton(
//     height: 82.0,
//     text: "Catalist",
//     margin: EdgeInsets.symmetric(horizontal: 72.0),
//     buttonStyle: CustomButtonStyles.fillTeal,
//     buttonTextStyle: theme.textTheme.displayMedium,
//   );
// }

// /// Section Widget
// Widget _buildUsernameInput(BuildContext context) {
//   return CustomTextFormField(
//     controller: usernameInputController,
//     hintText: "Username",
//     prefix: Container(
//       margin: EdgeInsets.fromLTRB(6.0, 6.0, 26.0, 6.0),
//       child: CustomImageView(
//         imagePath: ImageConstant.imgLock,
//         height: 26.0,
//         width: 26.0,
//         fit: BoxFit.contain,
//       ),
//     ),
//     prefixConstraints: BoxConstraints(
//       maxHeight: 48.0,
//     ),
//     contentPadding: EdgeInsets.fromLTRB(6.0, 6.0, 12.0, 6.0),
//   );
// }

// /// Section Widget
// Widget _buildPasswordInput(BuildContext context) {
//   return CustomTextFormField(
//     controller: passwordInputController,
//     hintText: "Password",
//     textInputAction: TextInputAction.done,
//     prefix: Container(
//       margin: EdgeInsets.fromLTRB(6.0, 6.0, 26.0, 6.0),
//       child: CustomImageView(
//         imagePath: ImageConstant.imgLocation,
//         height: 26.0,
//         width: 26.0,
//         fit: BoxFit.contain,
//       ),
//     ),
//     prefixConstraints: BoxConstraints(
//       maxHeight: 48.0,
//     ),
//     obscureText: true,
//     contentPadding: EdgeInsets.fromLTRB(6.0, 6.0, 12.0, 6.0),
//   );
// }

// /// Section Widget
// Widget _buildCompleteButton(BuildContext context) {
//   return CustomElevatedButton(
//     text: "Complete",
//     margin: EdgeInsets.only(bottom: 12.0),
//   );
// }

// /// Section Widget
// Widget _buildCompleteSection(BuildContext context) {
//   return Container(
//     width: double.maxFinite,
//     padding: EdgeInsets.symmetric(horizontal: 20.0),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [_buildCompleteButton(context)],
//     ),
//   );
// }
