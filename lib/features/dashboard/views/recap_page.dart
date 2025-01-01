import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:io';

// ignore: must_be_immutable
class RecapPage extends StatelessWidget {
  RecapPage({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    final profileImagePath =
        Provider.of<ProfileProvider>(context).profileImagePath;

    return AppBar(
      toolbarHeight: 62,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.h),
          child: CustomIconButton(
            height: 45.h,
            width: 45.h,
            padding: EdgeInsets.all(5.h),
            decoration: IconButtonStyleHelper.none,
            child: CircleAvatar(
              radius: 20.h,
              backgroundColor: Colors.grey[300],
              backgroundImage: profileImagePath != null
                  ? FileImage(File(profileImagePath))
                  : null,
              child: profileImagePath == null
                  ? Icon(Icons.person, size: 20.h, color: Colors.black)
                  : null,
            ),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.profile);
            },
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.linearBGcolors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Container(
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 10,
                    right: 0,
                    bottom: 0,
                  ),
                  child: Text(
                    "Weekly",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.h),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 15,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 24,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 24,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 24,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 0,
                    left: 10,
                    right: 0,
                    bottom: 0,
                  ),
                  child: Text(
                    "Monthly",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.h,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10.h),
                // Daily Challenges Block
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 15,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 24,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 24,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 24,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 24,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            top: 0,
                            left: 24,
                            right: 0,
                            bottom: 20,
                          ),
                          child: Recap_Block(
                            context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 42.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }
}

Widget _buildBottomNavigationBar(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      color: appTheme.NavBar,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.h),
        topRight: Radius.circular(25.h),
      ),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: appTheme.black900.withOpacity(0.2),
          blurRadius: 2.h,
          spreadRadius: 2.h,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Home Button
        IconButton(
          icon: SvgPicture.asset(
            ImageConstant.imgHome, // Replace with your SVG path
            height: 24.h,
            width: 24.h,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home'); // Handle routing
          },
        ),

        // Search Button
        IconButton(
          icon: SvgPicture.asset(
            ImageConstant.imgSearch, // Replace with your SVG path
            height: 37.h,
            width: 37.h,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/search'); // Handle routing
          },
        ),

        // Add Task Button
        AddTaskButton.showAddTaskModal(context, userId: currentUser?.id),

        // Recap Button
        IconButton(
          icon: SvgPicture.asset(
            ImageConstant.imgRecapPressed, // Replace with your SVG path
            height: 35.h,
            width: 35.h,
          ),
          onPressed: () {},
        ),

        // Calendar Button
        IconButton(
          icon: SvgPicture.asset(
            ImageConstant.imgCalendar, // Replace with your SVG path
            height: 35.h,
            width: 35.h,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/calendar'); // Handle routing
          },
        ),
      ],
    ),
    height: 70.h,
  );
}