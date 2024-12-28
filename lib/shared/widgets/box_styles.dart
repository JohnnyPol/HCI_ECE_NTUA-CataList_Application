import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_image_view.dart';

// Scrollable Block
  Widget Task_or_Challenge_Block(BuildContext context,
      {required String title,required String name,required bool circle,required bool border}) {

    return Container(
      height: 175.h,
      decoration: BoxDecoration(
        border: border
        ?Border.all(width: 2.0,color: Color.fromARGB(255, 255, 255, 255),)//white border
        :Border.all(width: 2.0,color: Color.fromARGB(0, 0, 0, 0),),//translucent border
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
          SizedBox(height: 5.h),
          // Scrollable List
          Expanded(
            child:ListItem(name: name,circle:circle)//Give list name and checkbox shape
          ),
        ],
      ),
    );
  }

  Widget Activity_Block(BuildContext context,
      {required String name,required bool circle,required bool border}) {

    return Container(
      height: 175.h,
      width: 260.h,
      decoration: BoxDecoration(
        border: border
        ?Border.all(width: 2.0,color: Color.fromARGB(255, 255, 255, 255),)//white border
        :Border.all(width: 2.0,color: Color.fromARGB(0, 0, 0, 0),),//translucent border
        color: appTheme.dailyBlocks,
        borderRadius: BorderRadius.circular(25.h),
      ),
      padding: EdgeInsets.all(16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 5.h),
          // Scrollable List
          Expanded(
            child:ListItem(name: name,circle:circle)//Give list name and checkbox shape
          ),
        ],
      ),
    );
  }
