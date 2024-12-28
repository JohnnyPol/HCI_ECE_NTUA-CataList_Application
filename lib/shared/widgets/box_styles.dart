import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_application_1/shared/widgets/custom_image_view.dart';
import 'package:pie_chart/pie_chart.dart';

// Scrollable Block
  Widget Task_or_Challenge_Block(BuildContext context,
      {required String title,required String name,required bool circle,required bool border}) {

    return Container(
      height: 177.h,
      width:320.h,
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

Widget Quote_Block(BuildContext context, Map<String, double> dataMap) {
    return 
    Center(
      child:Container(
        width:300.h,
      decoration: BoxDecoration(
        color: appTheme.profileAvatar,
        borderRadius: BorderRadius.circular(60.h),
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
            height: 70.h,
            width: 100.h,
            child: PieChart(
              colorList: [appTheme.homeBGcolor2,const Color.fromARGB(255, 241, 238, 248)],
              dataMap: dataMap,
              legendOptions: LegendOptions(showLegends: false), // Hide legends
              chartValuesOptions: ChartValuesOptions(
                chartValueBackgroundColor: Colors.transparent,
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
    ),
    );
  }
