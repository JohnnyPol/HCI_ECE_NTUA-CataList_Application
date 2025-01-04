// home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/shared/widgets/list_item.dart';
import 'dart:io';
import 'package:flutter_application_1/shared/widgets/custom_icon_button.dart';

// TODO: Add a "take photo" button at the top left of the screen

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// ignore: must_be_immutable
class _HomePageState extends State<HomePage> {
  final GlobalKey<ListItemStateNew> DailyKey = GlobalKey<ListItemStateNew>();
  final GlobalKey<ListItemStateNew> ChallengesKey =
      GlobalKey<ListItemStateNew>();
  final DatabaseHelper dbHelper = DatabaseHelper();

  Future<List<List<dynamic>>> fetchDailyTasks() async {
    final fetchedTasks =
        await dbHelper.getTasksByCategory(currentUser?.id, "Daily");
    return fetchedTasks.map((task) {
      final mappedTask = [
        task['title'] ?? 'Unknown Title',
        task['completed'] == 1,
        task['description'] ?? 'No Description',
        task['id'] ?? -1,
        task['category'] ?? 'Uncategorized',
        task['date'] ?? 'No Date',
        task['time'] ?? 'No time',
      ];
      print('Mapped Task: $mappedTask'); // Debug mapped task
      return mappedTask;
    }).toList();
  }

  Future<List<List<dynamic>>> fetchChallenges() async {
    final fetchedTasks =
        await dbHelper.getTasksByCategory(currentUser?.id, "Challenge");
    return fetchedTasks.map((challenges) {
      final dateTime = challenges['date'] ?? 'No Date';
      final date = dateTime.split('T')[0]; // Extract the date
      // Extract the time
      final time =
          dateTime.split('T').length > 1 ? dateTime.split('T')[1] : 'No Time';
      return [
        challenges['title'] ?? 'Unknown Title',
        challenges['completed'] == 1,
        challenges['description'] ?? 'Now Description',
        challenges['id'],
        challenges['category'] ?? 'Uncategorized',
        date,
        time,
      ];
    }).toList();
  }

  Map<String, double> dataMap = {"Completed": 0, "Incomplete": 0};

  Future<Map<String, double>> generateDataMap() async {
    // Fetch Daily Tasks
    final dailyTasks = await fetchDailyTasks();
    // Fetch Challenges
    final challenges = await fetchChallenges();

    // Combine all tasks
    final allTasks = [...dailyTasks, ...challenges];

    // Calculate Completed and Incomplete tasks
    final completedCount =
        allTasks.where((task) => task[1] as bool).length.toDouble();
    final incompleteCount =
        allTasks.where((task) => !(task[1] as bool)).length.toDouble();

    return {
      "Completed": completedCount,
      "Incomplete": incompleteCount,
    };
  }

  @override
  void initState() {
    super.initState();
    _updateDataMap(); // Initialize the dataMap on widget load
  }

  Future<void> _updateDataMap() async {
    final newDataMap = await generateDataMap();
    setState(() {
      dataMap = newDataMap; // Update the dataMap and trigger UI rebuild
    });
  }

  // Add this to Task_or_Challenge_Block to trigger _updateDataMap
  void onCheckboxToggled() {
    _updateDataMap(); // Recalculate the pie chart data when a checkbox is toggled
  }

  AppBar _buildAppBar(BuildContext context) {
    final profileImagePath =
        Provider.of<ProfileProvider>(context).profileImagePath;
    return AppBar(
      automaticallyImplyLeading: false, // Remove back button
      toolbarHeight: 62,
      leading: ElevatedButton(
        onPressed: () async {
          final photoStorage = PhotoStorage();
          final String? photoPath = await photoStorage.captureAndSavePhoto();

          if (photoPath != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Photo saved successfully!")),
            );
          }
        },
        child: Text("Capture Photo"),
      ),

      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.h),
          child: CustomIconButton(
            height: 45.h,
            width: 45.h,
            padding: EdgeInsets.all(5.h),
            decoration: IconButtonStyleHelper.none, // No outline or decoration
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
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use FutureBuilder to dynamically fetch the dataMap
              FutureBuilder<Map<String, double>>(
                future: generateDataMap(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('No data available'));
                  } else {
                    final dataMap = snapshot.data!;
                    return Quote_Block(context, dataMap);
                  }
                },
              ),
              SizedBox(height: 15.h),
              // Fetch and display Daily Tasks
              FutureBuilder<List<List<dynamic>>>(
                future: fetchDailyTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // TODO: Return the same widget as if with no tasks
                    return Center(child: Text('No daily tasks available'));
                  } else {
                    final tasks = snapshot.data!;
                    return Container(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 24,
                        right: 0,
                        bottom: 0,
                      ),
                      child: Task_or_Challenge_Block(
                        context,
                        listkey: DailyKey,
                        title: "Daily",
                        listname: tasks,
                        circle: false,
                        border: false,
                        onCheckboxChanged: onCheckboxToggled,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 15.h),
              // Fetch and display Challenges
              FutureBuilder<List<List<dynamic>>>(
                future: fetchChallenges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // TODO: Return the same widget as if with no tasks
                    return Center(child: Text('No challenges available'));
                  } else {
                    final challenges = snapshot.data!;
                    return Container(
                      padding: const EdgeInsets.only(
                        top: 0,
                        left: 24,
                        right: 0,
                        bottom: 0,
                      ),
                      child: Task_or_Challenge_Block(
                        context,
                        listkey: ChallengesKey,
                        title: "Challenges",
                        listname: challenges,
                        circle: false,
                        border: false,
                        onCheckboxChanged: onCheckboxToggled,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(context),
      ),
    );
  }
}

Widget NavigationBar(BuildContext context) {
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
            ImageConstant.imgHomePressed, // Replace with your SVG path
            height: 24.h,
            width: 24.h,
          ),
          onPressed: () {},
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
          onPressed: () {
            Navigator.pushNamed(context, '/calendar'); // Handle routing
          },
        ),
      ],
    ),
    height: 70.h,
  );
}
