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
    return Container(
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
              checkColor: Color.fromARGB(255, 28, 62, 80),
              activeColor: Colors.white,
              side: const BorderSide(
                color: Colors.white,
              ),
            ),
            Text(
              taskName,
              style: TextStyle(
                color: Color.fromARGB(255, 28, 62, 80),
                fontSize: 15.h,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      );
  }
}