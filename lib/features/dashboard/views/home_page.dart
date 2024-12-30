import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_image_view.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {//must be stateful in order to get an accurate pie chart??
  HomePage({Key? key}) : super(key: key);
  Map<String, double> dataMap = {
    "Completed": 5,
    "Incomplete": 4,
  };
  
 AppBar _buildAppBar(BuildContext context){
    return AppBar(
      automaticallyImplyLeading: false,//remove back button
      toolbarHeight:62,
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.h),
          child:
          CustomIconButton(
                      height: 45.h,
                      width: 45.h,
                      padding: EdgeInsets.all(13.h),
                      decoration: IconButtonStyleHelper.outlineBlack,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgProfileWhite,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.profile);
                      }
          )
        )
      ],
      backgroundColor: Colors.transparent,
      elevation:0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.linearBGcolors,
      child :Scaffold(
        backgroundColor: Colors.transparent,
        appBar:_buildAppBar(context),
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: 
            SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daily Quote Block
                  
                  Quote_Block(context,dataMap),
                  SizedBox(height: 15.h),
                  // Daily Tasks Block
                  Container(
                  padding:const EdgeInsets.only(
                          top: 0,
                          left: 24,
                          right: 0,
                          bottom: 0,
                      ),
                      child:
                        Task_or_Challenge_Block(
                            context,
                            title:"Daily",
                            name : "Daily",
                            circle: false,
                            border:false,
                            ),
                    ),
                  // _buildDailyTasksBlock(context),
                  SizedBox(height: 15.h),
                  // Daily Challenges Block
                  Container(
                  padding:const EdgeInsets.only(
                          top: 0,
                          left: 24,
                          right: 0,
                          bottom: 0,
                      ),
                      child:
                        Task_or_Challenge_Block(
                            context,
                            title:"Challenges",
                            name : "Challenges",
                            circle: false,
                            border:false,
                            ),
                    ),
                  // _buildDailyChallengesBlock(context),
                  SizedBox(height: 42.h),
                ],
              ),
            ),
          ),
          ),
        ),
        bottomNavigationBar:NavigationBar(context),
      ),
    );
  }
}

Widget NavigationBar(BuildContext context) {
   var _taskController;
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
        FloatingActionButton.small(
        shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: appTheme.startBGcolor,
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft:Radius.circular(20) ,topRight:Radius.circular(20) ),
              color:appTheme.dailyBlocks,
            ),
            padding: const EdgeInsets.all(10.0),
            height: 500,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add task',
                      style: theme.textTheme.displaySmall
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(thickness: 1.2),
                SizedBox(height: 20.0),
                TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Enter task',
                    hintStyle: theme.textTheme.displaySmall,
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: MediaQuery.of(context).size.width,
                  // height: 200.0,
                  child: Row(
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        child: 
                        FloatingActionButton(
                          child: Text(
                            'ADD',
                            style: theme.textTheme.displaySmall,
                          ),
                          onPressed: () {},
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