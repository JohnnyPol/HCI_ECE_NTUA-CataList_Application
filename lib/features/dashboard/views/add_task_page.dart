import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_image_view.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);
  Map<String, double> dataMap = {
    "Completed": 5,
    "Incomplete": 4,
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.homeBGcolor2,
      body: SafeArea(
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 12.h,
                top: 22.h,
                right: 12.h,
              ),
              decoration: AppDecoration.linearBGcolors,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top profile button
                  Padding(
                    padding: EdgeInsets.only(left: 280.h),
                    child: CustomIconButton(
                      height: 52.h,
                      width: 52.h,
                      padding: EdgeInsets.all(14.h),
                      decoration: IconButtonStyleHelper.outlineBlack,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgProfileWhite,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.profile);
                      },
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // Daily Quote Block
                  _buildDailyQuoteBlock(context),
                  SizedBox(height: 42.h),
                  // Daily Tasks Block
                  _buildScrollableBlock(
                    context,
                    title: "Daily Tasks",
                    itemCount: 10,
                    itemBuilder: (context, index) =>
                        _buildTaskItem("Task ${index + 1}"),
                  ),
                  // _buildDailyTasksBlock(context),
                  SizedBox(height: 40.h),
                  // Daily Challenges Block
                  _buildScrollableBlock(
                    context,
                    title: "Daily Challenges",
                    itemCount: 5,
                    itemBuilder: (context, index) =>
                        _buildTaskItem("Challenge ${index + 1}"),
                  ),
                  // _buildDailyChallengesBlock(context),
                  SizedBox(height: 42.h),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  // Daily Quote Block
  Widget _buildDailyQuoteBlock(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: appTheme.homeBGcolor1,
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
      padding: EdgeInsets.all(16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Pie Chart with explicit constraints
          Container(
            height: 100.h,
            width: 100.h,
            child: PieChart(
              dataMap: dataMap,
              legendOptions: LegendOptions(showLegends: false), // Hide legends
              chartValuesOptions: ChartValuesOptions(
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
              ),
            ),
          ),
          SizedBox(width: 16.h),
          // Daily Quote
          Expanded(
            child: Text(
              "Daily Quote from API will appear here.",
              style: CustomTextStyles.dailyQuoteStyle,
            ),
          ),
        ],
      ),
    );
  }

// Scrollable Block
  Widget _buildScrollableBlock(BuildContext context,
      {required String title,
      required int itemCount,
      required Widget Function(BuildContext, int) itemBuilder}) {
    return Container(
      height: 200.h,
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
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            title,
            style: TextStyle(
              fontSize: 18.h,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          // Scrollable List
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: itemBuilder,
            ),
          ),
        ],
      ),
    );
  }

  // Task/Challenge Item
  Widget _buildTaskItem(String taskName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Icon(Icons.check_box_outline_blank, color: Colors.grey),
          SizedBox(width: 12.h),
          Text(
            taskName,
            style: TextStyle(
              fontSize: 16.h,
              color: Colors.black87,
            ),
          ),
        ],
      ),
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
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgAddTaskPressed,
              height: 40.h,
              width: 40.h,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/add_task'); // Handle routing
            },
          ),

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
}
