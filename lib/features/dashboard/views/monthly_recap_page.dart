import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class MonthlyRecapPage extends StatelessWidget {
  MonthlyRecapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final monthIndex = arguments?['monthIndex'];
    return Container(
      decoration: AppDecoration.linearBGcolors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            _buildMonthlyRecapContent(context, monthIndex: monthIndex),
            Expanded(
                child:
                    _buildScrollableTaskList(context, monthIndex: monthIndex)),
          ],
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildMonthlyRecapContent(
    BuildContext context, {
    required monthIndex,
  }) {
    final profileImagePath =
        Provider.of<ProfileProvider>(context).profileImagePath;

    return Column(
      children: [
        AppBar(
          toolbarHeight: 62,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Monthly Recap",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.h,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
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
        ),
        SizedBox(height: 50.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20.h),
          padding: EdgeInsets.all(15.h),
          decoration: BoxDecoration(
            // ignore: deprecated_member_use
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15.h),
          ),
          height: 300.h,
          child: FutureBuilder<List<List<File>>>(
            future: PhotoStorage().getMonthlyPhotos(userId: currentUser?.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    "No images available",
                    style: TextStyle(color: Colors.white, fontSize: 16.h),
                  ),
                );
              }

              final monthlyPhotos = snapshot.data!;

              // Validate that the weekIndex exists in the data
              if (monthIndex >= monthlyPhotos.length || monthIndex < 0) {
                return Center(
                  child: Text(
                    "No photos for this month",
                    style: TextStyle(color: Colors.white, fontSize: 16.h),
                  ),
                );
              }
              final selectedMonthPhotos = monthlyPhotos[monthIndex];
              // If there are no photos for the specific week
              if (selectedMonthPhotos.isEmpty) {
                return Center(
                  child: Text(
                    "No photos available for month $monthIndex",
                    style: TextStyle(color: Colors.white, fontSize: 16.h),
                  ),
                );
              }
              return PageView.builder(
                itemCount: selectedMonthPhotos.length,
                itemBuilder: (context, photoIndex) {
                  final photo = selectedMonthPhotos[photoIndex];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.h),
                      child: Image.file(
                        photo,
                        fit: BoxFit.cover,
                        width: 200.h,
                        height: 200.h,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableTaskList(
    BuildContext context, {
    required int monthIndex,
  }) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: DatabaseHelper().getTasksForMonth(currentUser?.id, monthIndex),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              "No tasks available",
              style: TextStyle(color: Colors.white, fontSize: 16.h),
            ),
          );
        }

        final tasks = snapshot.data!;
        return ListView.builder(
          padding: EdgeInsets.all(20.h),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.viewTask,
                  arguments: {
                    'taskId': task['id'],
                    'taskName': task['title'],
                    'taskDescription': task['description'],
                    'taskCategory': task['category'],
                    'taskCompleted': task['completed'] == 1,
                    'taskDate': task['date'],
                    'taskTime': task['time'],
                  },
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.h),
                padding: EdgeInsets.all(15.h),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12.h),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task['title'],
                      style: TextStyle(
                        color: appTheme.black900,
                        fontSize: 18.h,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      task['description'],
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14.h,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date: ${task['date']}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12.h,
                          ),
                        ),
                        Text(
                          "Time: ${task['time']}",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12.h,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgHome,
              height: 24.h,
              width: 24.h,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgSearch,
              height: 37.h,
              width: 37.h,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
          ),
          AddTaskButton.showAddTaskModal(
            context,
            userId: currentUser?.id,
            onTaskAdded: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgRecapPressed,
              height: 35.h,
              width: 35.h,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgCalendar,
              height: 35.h,
              width: 35.h,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/calendar');
            },
          ),
        ],
      ),
      height: 70.h,
    );
  }
}
