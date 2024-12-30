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
  final List name = [['One',false],['Two',true],['Three',false],['Four',false]];

  void checkBoxChanged(int index) {
    setState(() {
      name[index][1] = !name[index][1];
    });
  }

  void AddTask(String taskname){
    setState(() {
      this.name.add([taskname,false]);
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: name.length,
        itemBuilder: (BuildContext context, index) {
          return TaskItem(
            taskName: name[index][0],
            taskCompleted: name[index][1],
            circle:circle,
            onChanged: (value) => checkBoxChanged(index),
          );
        },
      );
  }
}
//ΥΠΑΡΧΕΙ ΠΡΟΒΛΗΜΑ!!!!! Μαλλον πρεπει να φτιαξω constructor έτσι ώστε να επιστρέφει η κλάση μια λίστα απο task items