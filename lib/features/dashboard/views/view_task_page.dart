// view_task_page.dart

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ViewTaskPage extends StatelessWidget {
  ViewTaskPage({Key? key}) : super(key: key);

  final DatabaseHelper dbHelper = DatabaseHelper();
  Future<void> _deleteTask(BuildContext context, int taskId) async {
    await dbHelper.deleteTask(taskId);
    Navigator.pop(context, true); // Navigate back after deleting the task
  }

  Future<void> _updateTaskField(
      BuildContext context, int taskId, String field, String newValue) async {
    await dbHelper.updateTaskField(taskId, field, newValue);
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(
          context, AppRoutes.home); // Close the modal and refresh
    });
  }

  void _showEditModal(BuildContext context, String fieldName,
      String currentValue, Function(String) onSave) {
    TextEditingController fieldController =
        TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.h),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Edit $fieldName",
                    style: TextStyle(
                        fontSize: 18.h,
                        fontWeight: FontWeight.bold,
                        color: appTheme.black900),
                  ),
                  SizedBox(height: 10.h),
                  TextField(
                    controller: fieldController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      hintText: "Enter new $fieldName",
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the modal
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.dailyBlocks,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.h),
                          ),
                        ),
                        // TODO: Style the buttons
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          onSave(fieldController.text.trim());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appTheme.startBGcolor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.h),
                          ),
                        ),
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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

    /// Retrieve the arguments
    final int taskId = args['taskId'];
    final String taskName = args['taskName'];
    final String taskDescription = args['taskDescription'];
    final String taskCategory = args['taskCategory'];
    final String taskDate = args['taskDate'];
    final String taskTime = args['taskTime'];
    final bool taskComplete = args['taskCompleted'];

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
                        _buildEditableField(
                          context,
                          "Task Name",
                          taskName,
                          (newValue) => _updateTaskField(
                              context, taskId, 'title', newValue),
                        ),
                        _buildEditableField(
                          context,
                          "Description",
                          taskDescription,
                          (newValue) => _updateTaskField(
                              context, taskId, 'description', newValue),
                        ),
                        _buildStaticField("Completed",
                            taskComplete ? "Completed" : "Incomplete"),
                        _buildStaticField("Category", taskCategory),
                        _buildEditableDateField(
                          context,
                          "Date",
                          taskDate,
                          (newValue) async {
                            await _updateTaskField(
                                context, taskId, 'date', newValue);
                          },
                        ),
                        _buildEditableTimeField(
                          context,
                          "Time",
                          taskTime,
                          (newValue) async {
                            _updateTaskField(context, taskId, 'time', newValue);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton(
                    onPressed: () => _deleteTask(context, taskId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 25.h, horizontal: 30.h),
                    ),
                    child: Text(
                      "Delete Task",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.h,
                        fontWeight: FontWeight.w900,
                      ),
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

  Widget _buildEditableField(BuildContext context, String label,
      String currentValue, Function(String) onSave) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            color: appTheme.black900,
            fontSize: 14.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Expanded(
              child: Text(
                currentValue,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14.h,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                _showEditModal(context, label, currentValue, onSave);
              },
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildStaticField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            color: appTheme.black900,
            fontSize: 14.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          value,
          style: TextStyle(
            color: Colors.black38,
            fontSize: 14.h,
          ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildEditableDateField(
    BuildContext context,
    String label,
    String currentValue,
    Function(String) onSave,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            color: appTheme.black900,
            fontSize: 14.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Expanded(
              child: Text(
                currentValue,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14.h,
                ),
              ),
            ),
            IconButton(
              icon:
                  Icon(Icons.edit_calendar, color: appTheme.EditTaskIconColor),
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.parse(currentValue),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  onSave(pickedDate.toIso8601String().split('T')[0]);
                }
              },
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _buildEditableTimeField(
    BuildContext context,
    String label,
    String currentValue,
    Function(String) onSave,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label:",
          style: TextStyle(
            color: appTheme.black900,
            fontSize: 14.h,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5.h),
        Row(
          children: [
            Expanded(
              child: Text(
                currentValue,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14.h,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () async {
                final pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay(
                    hour: int.parse(currentValue.split(':')[0]),
                    minute: int.parse(currentValue.split(':')[1]),
                  ),
                );
                if (pickedTime != null) {
                  final formattedTime =
                      "${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}:00";
                  onSave(formattedTime);
                }
              },
            ),
          ],
        ),
        SizedBox(height: 10.h),
      ],
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
}
