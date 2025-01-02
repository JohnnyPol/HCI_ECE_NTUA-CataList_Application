// search_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

// ignore: must_be_immutable
class _SearchPageState extends State<SearchPage> {
  final DatabaseHelper dbHelper = DatabaseHelper();
  List<List<dynamic>> todayTasks = [];
  List<List<dynamic>> tomorrowTasks = [];
  List<List<dynamic>> searchResults = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchTasks(); // Fetch tasks on page load
  }

  Future<void> _fetchTasks() async {
    final allTasks = await dbHelper.getTasks(currentUser?.id);
    print("All Tasks from DB: $allTasks");

    setState(() {
      final now = DateTime.now();
      final today = DateUtils.dateOnly(now);
      final tomorrow = today.add(Duration(days: 1));

      todayTasks = allTasks
          .where((task) {
            final taskDate = DateUtils.dateOnly(DateTime.parse(task['date']));
            return taskDate.isAtSameMomentAs(today);
          }) // Compare with formatted date
          .map((task) => [
                task['title'],
                task['completed'] == 1,
                task['description'],
                task['id'],
                task['category'],
                task['date'],
                task['time'],
              ])
          .toList();

      tomorrowTasks = allTasks
          .where((task) {
            final taskDate = DateUtils.dateOnly(DateTime.parse(task['date']));
            return taskDate
                .isAtSameMomentAs(tomorrow); // Compare task date with tomorrow
          })
          .map((task) => [
                task['title'],
                task['completed'] == 1,
                task['description'],
                task['id'],
                task['category'],
                task['date'],
                task['time'],
              ])
          .toList();
    });

    print("Filtered Today Tasks: $todayTasks");
    print("Filtered Tomorrow Tasks: $tomorrowTasks");
  }

  Future<void> _searchTasks(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    final results = await dbHelper.searchTasks(query, currentUser?.id);
    setState(() {
      searchResults = results
          .map((task) => [
                task['title'],
                task['completed'] == 1,
                task['description'],
                task['id'],
                task['category'],
                task['date'],
                task['time'],
              ])
          .toList();
    });

    print("Search Results: $searchResults");
  }

  void _onSearch(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
    _searchTasks(query);
  }

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchInput(context, onSearch: _onSearch),
                SizedBox(height: 20.h),
                searchQuery.isNotEmpty
                    ? _buildSearchResults()
                    : _buildTaskSection("Today", todayTasks),
                SizedBox(height: 20.h),
                _buildDivider(),
                SizedBox(height: 20.h),
                _buildTaskSection("Tomorrow", tomorrowTasks),
                SizedBox(height: 42.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildSearchResults() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Activity_Block(
        context,
        listname: searchResults,
        circle: false,
        border: true,
        onTaskUpdate: _fetchTasks,
      ),
    );
  }

  Widget _buildTaskSection(String title, List<List<dynamic>> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            " $title",
            style: TextStyle(
                color: Colors.white,
                fontSize: 14.h,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10.h),
        tasks.isNotEmpty
            ? Container(
                padding: const EdgeInsets.only(left: 55),
                child: Activity_Block(
                  context,
                  listname: tasks,
                  circle: true,
                  border: true,
                  onTaskUpdate: _fetchTasks,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 55),
                child: Text(
                  "No tasks available.",
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 12.h,
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildDivider() {
    return Center(
      child: Container(
        height: 0.8.h,
        width: 320.h,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: appTheme.black900.withOpacity(0.2),
              blurRadius: 2.h,
              spreadRadius: 0.5.h,
              offset: Offset(0, 2),
            ),
          ],
        ),
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
            ImageConstant.imgSearchPressed, // Replace with your SVG path
            height: 37.h,
            width: 37.h,
          ),
          onPressed: () {},
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
