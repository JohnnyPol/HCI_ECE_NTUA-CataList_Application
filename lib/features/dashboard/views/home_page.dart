import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_image_view.dart';
import 'package:flutter_application_1/shared/widgets/custom_text_form_field.dart';
import 'package:flutter_application_1/shared/widgets/list_item.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {//must be stateful in order to get an accurate pie chart??
  HomePage({Key? key}) : super(key: key);
  List<List<dynamic>> Daily=[["one",false],["two",false],["three",false],["four",true],["five",false]];
  List<List<dynamic>> Challenges=[["one",false],["two",false],["three",false],["four",true],["five",false]];
  GlobalKey<ListItemStateNew> DailyKey= GlobalKey<ListItemStateNew>();
  GlobalKey<ListItemStateNew> ChallengesKey= GlobalKey<ListItemStateNew>();

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
                            listkey:DailyKey,
                            title:"Daily",
                            listname : Daily,
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
                            listkey:ChallengesKey,
                            title:"Challenges",
                            listname : Challenges,
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
        bottomNavigationBar:NavigationBar(context,DailyKey,ChallengesKey),
      ),
    );
  }
}

Widget NavigationBar(BuildContext context, GlobalKey<ListItemStateNew> keyD, GlobalKey<ListItemStateNew> keyC) {
  var titleController=TextEditingController();
  var descriptionController=TextEditingController();
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
                      style: TextStyle(
                            color:  Color.fromARGB(209, 37, 68, 83),
                            fontSize: 16.h,
                            fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(thickness: 1.2),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(right: 150),
                  child:
                    CustomTextFormField(
                      controller: titleController,
                      width:200.h,
                      fillColor:Colors.white,
                      borderDecoration: 
                              OutlineInputBorder(
                                borderSide: 
                                BorderSide(width: 2.0, color: Colors.lightBlue.shade50),
                                borderRadius:BorderRadius.circular(10.h),
                              ),
                      hintText: "Task Name",
                      textInputAction: TextInputAction.done,
                    ),
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.only(right: 100),
                  child:
                    CustomTextFormField(
                      controller: descriptionController,
                      width:250.h,
                      fillColor:Colors.white,
                      borderDecoration: 
                              OutlineInputBorder(
                                borderSide: 
                                BorderSide(width: 2.0, color: Colors.lightBlue.shade50),
                                borderRadius:BorderRadius.circular(10.h),
                              ),
                      hintText: "Task Description",
                      textInputAction: TextInputAction.done,
                    ),
                ),
                SizedBox(height: 160.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: MediaQuery.of(context).size.width,
                  // height: 200.0,
                  child: Row(
                    children: [
                      Container(width:320),
                      Container(
                        child: 
                        FloatingActionButton(
                          child: Text(
                            'Add',
                            style:
                             TextStyle(
                              color: Colors.white,
                              fontSize: 16.h,
                              fontWeight: FontWeight.bold)
                            ),
                            backgroundColor:appTheme.profileAvatar,
                          onPressed: () async {
                            String taskname=titleController.text.trim();
                            String taskDescription=descriptionController.text.trim();
                            if (taskname.length>25){//add condition for description
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Task title waaaay too long')));
                            }else{
                            keyD.currentState?.AddTask(taskname,taskDescription);
                            titleController.clear();
                            Navigator.of(context).pop();}
                          },
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