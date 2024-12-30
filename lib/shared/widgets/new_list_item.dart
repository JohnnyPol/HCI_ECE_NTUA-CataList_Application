import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/widgets/todo_list.dart';

class ListItemNew extends StatefulWidget {
  const ListItemNew({
    super.key,
    required this.listname,
    required this.circle,
  });
  
  final bool circle;
  final List<List<dynamic>> listname; 

  @override
  State<ListItemNew> createState() => _ListItemStateNew();
}

class _ListItemStateNew extends State<ListItemNew> {
  late List<List<dynamic>> listname; // the list will be initialised later

  @override
  void initState() {
    super.initState();
    listname = widget.listname; // Αντιστοιχεί τη λίστα από το widget στο state.
  }

  void checkBoxChanged(int index) {
    setState(() {
      listname[index][1] = !listname[index][1]; 
    });
  }

  void AddTask(String taskName) {
    setState(() {
      listname.add([taskName, false]); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listname.length,
        itemBuilder: (BuildContext context, index) {
          return TaskItem(
            taskName: listname[index][0],
            taskCompleted: listname[index][1],
            circle:widget.circle,//gets the circle varable from the ListItem widget
            onChanged: (value) => checkBoxChanged(index),
          );
        },
      );
  }
}
