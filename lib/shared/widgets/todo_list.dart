import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.circle,
    this.onChanged,
  });

  final String taskName;
  final bool taskCompleted;
  final bool circle;
  final Function(bool?)? onChanged;
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Checkbox(
              shape: circle
              ?CircleBorder()
              :RoundedRectangleBorder(),
              value: taskCompleted,
              onChanged: onChanged,
              checkColor: Colors.black,
              activeColor: Colors.white,
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
            Text(
              taskName,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.h,
              ),
            ),
          ],
        ),
      ),
    );
  }
}