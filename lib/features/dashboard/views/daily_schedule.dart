// daily_schedule.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class DailySchedulePage extends StatefulWidget {
  final DateTime selectedDate;

  DailySchedulePage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  _DailySchedulePageState createState() => _DailySchedulePageState();
}

class _DailySchedulePageState extends State<DailySchedulePage> {
  AppBar _buildAppBar(BuildContext context) {
    final profileImagePath =
        Provider.of<ProfileProvider>(context).profileImagePath;

    return AppBar(
      toolbarHeight: 62,
      title: Text(
        "${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}", // Display selected day
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.h,
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
      backgroundColor: Colors.transparent,
      elevation: 0,
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
          AddTaskButton.showAddTaskModal(context, userId: currentUser?.id),
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgRecap,
              height: 35.h,
              width: 35.h,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/recap');
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgCalendarPressed,
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

  final dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> tasksForDay = [];
  @override
  void initState() {
    super.initState();
    _fetchTasksForDay();
  }

  Future<void> _fetchTasksForDay() async {
    final tasks = await dbHelper.getTasksForDate(
        currentUser?.id, widget.selectedDate.toIso8601String().split('T')[0]);
    setState(() {
      tasksForDay = tasks;
    });
  }

  List<Map<String, dynamic>> _tasksForHour(int hour) {
    return tasksForDay.where((task) {
      final taskTime = TimeOfDay(
        hour: int.parse(task['time'].split(':')[0]),
        minute: int.parse(task['time'].split(':')[1]),
      );
      return taskTime.hour == hour;
    }).toList();
  }

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          AppDecoration.linearBGcolors, // Same background as CalendarPage
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0.h),
                child: Text(
                  // TODO: Change the fontstyle of this text and add in general the fontstyles we want
                  "Organize your day!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Lobster',
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 24,
                  itemBuilder: (context, index) {
                    final time = '${index.toString().padLeft(2, '0')}:00';
                    final tasks = _tasksForHour(index);
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 4.0.h, horizontal: 16.0.h),
                      child: Container(
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.blue[200]
                              : Colors.blue[300],
                          borderRadius: BorderRadius.circular(8.h),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(time),
                              trailing: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (BuildContext context) {
                                      return AddTaskButton.addTaskModal(
                                        context,
                                        userId: currentUser?.id,
                                        selectedDate: widget.selectedDate,
                                        selectedHour: index,
                                        titleController: titleController,
                                        descriptionController:
                                            descriptionController,
                                      );
                                    },
                                  );
                                },
                                child: Text("Add Task"),
                              ),
                            ),
                            ...tasks.map(
                              (task) => ListTile(
                                title: Text(
                                  task['title'],
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                subtitle: Text(
                                  task['description'],
                                  style: TextStyle(
                                    color: appTheme.black900,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w100,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: appTheme.EditTaskIconColor,
                                  ),
                                  onPressed: () {
                                    // Add logic to edit this task
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }
}
