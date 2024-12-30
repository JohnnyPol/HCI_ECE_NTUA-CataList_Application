import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/widgets/todo_list.dart';

class ListItem extends StatefulWidget {
  const ListItem({super.key,required this.name,required this.circle});
  final String name;
  final bool circle;
  @override
  State<ListItem> createState() => _ListItemState(circle);
}

class _ListItemState extends State<ListItem> {
  _ListItemState(bool this.circle);
  final bool circle;
  final List tasklist = [["one",false],["two",false],["three",false],["four",true],["five",false]];


  void checkBoxChanged(int index) {
    setState(() {
      tasklist[index][1] = !tasklist[index][1];
    });
  }

  void AddTask(String taskname){
    setState(() {
      tasklist.add([taskname,false]);
    });
  }



  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasklist.length,
        itemBuilder: (BuildContext context, index) {
          return TaskItem(
            taskName: tasklist[index][0],
            taskCompleted: tasklist[index][1],
            circle:circle,
            onChanged: (value) => checkBoxChanged(index),
          );
        },
      );
  }
}