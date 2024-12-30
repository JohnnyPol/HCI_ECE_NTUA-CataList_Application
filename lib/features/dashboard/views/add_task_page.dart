import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_image_view.dart';
import '../../../shared/widgets/custom_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class AddTaskPage extends StatelessWidget {
  AddTaskPage({Key? key}) : super(key: key);
  TextEditingController TaskInputController = TextEditingController();
  TextEditingController TaskDescriptionController = TextEditingController();

 AppBar _buildAppBar(BuildContext context){
    return AppBar(
      automaticallyImplyLeading: true,
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
              padding:EdgeInsets.only(
                  top: 130,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  ),
              child: AddTask_Block(context,)
            ),
          ),
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(context),
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
          // Add Task Button
          IconButton(
            icon: SvgPicture.asset(
              ImageConstant.imgAddTaskPressed,
              height: 40.h,
              width: 40.h,
            ),
            onPressed: () {},//remove do no pages stack up
          )
        ],
      ),
      height: 60.h,
    );
  }
}
