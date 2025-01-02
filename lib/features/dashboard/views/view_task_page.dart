// view_task_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ViewTaskPage extends StatelessWidget {
  ViewTaskPage({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 62,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the passed arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args == null) {
      return Container(
        decoration: AppDecoration.linearBGcolors,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context),
          body: Center(
            child: Text(
              "No task details available.",
              style: TextStyle(color: Colors.white, fontSize: 16.h),
            ),
          ),
        ),
      );
    }

    final String taskName = args['taskName'];
    final String taskDescription = args['taskDescription'];
    final String taskCategory = args['taskCategory'];
    final String taskDate = args['taskDate'];
    final String taskTime = args['taskTime'];

    return Container(
      decoration: AppDecoration.linearBGcolors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Here is your task!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.h,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25.h),
                  Container(
                    padding: EdgeInsets.all(30.h),
                    margin: EdgeInsets.symmetric(horizontal: 10.h),
                    decoration: BoxDecoration(
                      color: appTheme.dailyBlocks,
                      borderRadius: BorderRadius.circular(25.h),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Task Name:",
                          style: TextStyle(
                            color: appTheme.black900,
                            fontSize: 14.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          taskName,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14.h,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Description:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          taskDescription,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14.h,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Category:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          taskCategory,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14.h,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Date:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          taskDate,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14.h,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Time:",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          taskTime,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 14.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
            ImageConstant.imgRecap, // Replace with your SVG path
            height: 35.h,
            width: 35.h,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/recap'); // Handle routing
          },
        ),

        // Calendar Button
        IconButton(
          icon: SvgPicture.asset(
            ImageConstant.imgCalendar, // Replace with your SVG path
            height: 35.h,
            width: 35.h,
          ),
          onPressed: () {},
        ),
      ],
    ),
    height: 70.h,
  );
}
