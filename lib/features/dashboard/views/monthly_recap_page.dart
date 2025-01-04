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
    return Container(
      decoration: AppDecoration.linearBGcolors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: PageViewWithIndicator(),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }
}

class PageViewWithIndicator extends StatefulWidget {
  @override
  _PageViewWithIndicatorState createState() => _PageViewWithIndicatorState();
}

class _PageViewWithIndicatorState extends State<PageViewWithIndicator> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildWeeklyRecapContent(context),
              _buildPersonalGoalsContent(context),
            ],
          ),
        ),
        _buildPageIndicator(),
      ],
    );
  }

  Widget _buildWeeklyRecapContent(BuildContext context) {
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
          child: Center(
            child: Text(
              "No data available",
              style: TextStyle(color: Colors.white, fontSize: 16.h),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        _buildFooterProgressIndicators(context),
      ],
    );
  }

  Widget _buildPersonalGoalsContent(BuildContext context) {
  final profileImagePath =
      Provider.of<ProfileProvider>(context).profileImagePath;

  return Column(
    children: [
      AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 62,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Personal Goals/Tasks",
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
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.all(20.h),
          itemCount: 7,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                "Title (${index + 1}):",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.h,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          },
        ),
      ),
    ],
  );
}

  Widget _buildPageIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(2, (index) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            height: 10.0,
            width: _currentPage == index ? 20.0 : 10.0,
            decoration: BoxDecoration(
              color: _currentPage == index ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(5.0),
            ),
          );
        }),
      ),
    );
  }
}

Widget _buildFooterProgressIndicators(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildProgressIndicator(context, Icons.fitness_center, 88),
      _buildProgressIndicator(context, Icons.apple, 88),
      _buildProgressIndicator(context, Icons.assignment, 88),
    ],
  );
}

Widget _buildProgressIndicator(
    BuildContext context, IconData icon, int percentage) {
  return Column(
    children: [
      Icon(icon, color: Colors.white, size: 40.h),
      SizedBox(height: 10.h),
      Text(
        "$percentage%",
        style: TextStyle(color: Colors.white, fontSize: 14.h),
      ),
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
