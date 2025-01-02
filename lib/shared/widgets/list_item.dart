// list_item.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/widgets/todo_list.dart';

class ListItemNew extends StatefulWidget {
  const ListItemNew({
    super.key,
    required this.listname,
    required this.circle,
    required this.onCheckboxChanged,
  });

  final bool circle;
  final List<List<dynamic>> listname;
  // Add callback for checkbox updates
  final Function(int, bool) onCheckboxChanged;

  @override
  State<ListItemNew> createState() => ListItemStateNew();
}

class ListItemStateNew extends State<ListItemNew> {
  late List<List<dynamic>> listname; // the list will be initialised later

  @override
  void initState() {
    super.initState();
    listname = widget.listname; // Αντιστοιχεί τη λίστα από το widget στο state.
  }

  void checkBoxChanged(int index) {
    setState(() {
      listname[index][1] = !listname[index][1]; // Update local state
    });

    // Trigger the callback to update the database
    widget.onCheckboxChanged(index, listname[index][1]);
  }

  void AddTask(String taskName, String taskDescription) {
    setState(() {
      listname.add([taskName, false, taskDescription]);
    });
  }

  void deleteTask(int index) {
    setState(() {
      listname.removeAt(index);
    });
  }

  /* void ViewTask(int index){
    setState((){
      //Navigate to a page that is dedicated to the task and is a widget that takes different text fields as input
    })
  }*/

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listname.length,
      itemBuilder: (BuildContext context, index) {
        return TaskItem(
          taskName: listname[index][0],
          taskCompleted: listname[index][1],
          taskDescription: listname[index][2],
          taskId: listname[index][3],
          taskCategory: listname[index][4],
          taskDate: listname[index][5],
          taskTime: listname[index][6],
          circle:
              widget.circle, //gets the circle varable from the ListItem widget
          onChanged: (value) => checkBoxChanged(index),
          deleteFunction: (contex) => deleteTask(index),
        );
      },
    );
  }
}
