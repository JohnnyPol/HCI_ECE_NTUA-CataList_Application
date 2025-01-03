import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:io';

// TODO: In figma we have two months displayed (should we change it to that?)

class CalendarPage extends StatefulWidget {
  CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

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

  Widget _buildCalendarView() {
    return Padding(
      padding: EdgeInsets.all(16.0), // Padding around the calendar
      child: SingleChildScrollView(
        // Allows vertical scrolling if needed
        child: TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarStyle: CalendarStyle(
            todayDecoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
            selectedDecoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            outsideDaysVisible: false,
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
          ),
        ),
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.linearBGcolors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: SafeArea(
          child: _buildCalendarView(),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }
}
