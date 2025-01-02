// todo_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
    required this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.taskCompleted,
    required this.taskCategory,
    required this.taskDate,
    required this.taskTime,
    required this.circle,
    this.onChanged,
    required this.deleteFunction,
  });

  final int taskId;
  final String taskName;
  final String taskDescription;
  final bool taskCompleted;
  final String taskCategory;
  final String taskDate;
  final String taskTime;
  final bool circle;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                icon: Icons.delete_rounded,
                onPressed: deleteFunction,
                backgroundColor: const Color.fromARGB(
                    255, 179, 11, 11), //CHANGE ICONS COLOR TO WHITE
                borderRadius: BorderRadius.circular(15),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Checkbox(
                  shape: circle ? CircleBorder() : RoundedRectangleBorder(),
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
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/view_task',
                        // Pass all the info of the task as parameters
                        arguments: {
                          'taskId': taskId,
                          'taskName': taskName,
                          'taskDescription': taskDescription,
                          'taskCategory': taskCategory,
                          'taskCompleted': taskCompleted,
                          'taskDate': taskDate,
                          'taskTime': taskTime,
                        },
                      );
                    },
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.white,
                    ))
              ],
            ),
          )),
    );
  }
}
