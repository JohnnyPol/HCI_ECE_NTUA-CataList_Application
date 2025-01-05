// add_task_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/widgets/custom_text_form_field.dart'; // Adjust based on your project structure
import 'package:flutter_application_1/app_export.dart';
import 'package:intl/intl.dart'; // Adjust based on your project structure

class AddTaskButton {
  static StatefulBuilder addTaskModal(
    BuildContext context, {
    String? currentRoute,
    required int? userId,
    DateTime? selectedDate,
    int? selectedHour,
    TextEditingController? titleController,
    TextEditingController? descriptionController,
  }) {
    titleController ??= TextEditingController();
    descriptionController ??= TextEditingController();
    String? selectedCategory;
    DateTime? selectedTaskDate = selectedDate;
    TimeOfDay? selectedTaskTime =
        selectedHour != null ? TimeOfDay(hour: selectedHour, minute: 0) : null;
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets, // Adjust for keyboard
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: appTheme.dailyBlocks,
            ),
            padding: const EdgeInsets.all(10),
            height: 500,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add Task',
                      style: TextStyle(
                        color: Color.fromARGB(209, 37, 68, 83),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close),
                    ),
                  ],
                ),
                Divider(thickness: 1.2),
                SizedBox(height: 20),
                // Task Name Field
                CustomTextFormField(
                  controller: titleController,
                  fillColor: Colors.white,
                  borderDecoration: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: Colors.lightBlue.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Task Name",
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 20),
                // Task Description Field
                CustomTextFormField(
                  controller: descriptionController,
                  fillColor: Colors.white,
                  borderDecoration: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 2, color: Colors.lightBlue.shade50),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Task Description",
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(height: 20),
                // Category Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  hint: Text("Select Category"),
                  value: selectedCategory,
                  items: ["Daily", "Challenge"]
                      .map((category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                // Date Picker
                GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedTaskDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        selectedTaskDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedTaskDate != null
                            ? "Date: ${DateFormat('dd/MM/yyyy').format(selectedTaskDate!)}"
                            : "Select Date"),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Time Picker
                GestureDetector(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                      context: context,
                      initialTime: selectedTaskTime ?? TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedTaskTime = pickedTime;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(selectedTaskTime != null
                            ? "Time: ${selectedTaskTime?.format(context)}"
                            : "Select Time"),
                        Icon(Icons.access_time),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                // Add Task Button

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appTheme.startBGcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15.h), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                      horizontal: 20.h,
                    ), // Padding for better touch area
                    elevation: 5, // Slight shadow for better visibility
                  ),
                  onPressed: () async {
                    String? taskName = titleController?.text.trim();
                    String? taskDescription =
                        descriptionController?.text.trim();

                    if (taskName!.isEmpty ||
                        selectedCategory == null ||
                        selectedTaskDate == null ||
                        selectedTaskTime == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fill all fields')));
                      return;
                    }

                    // Insert task into the database
                    if (userId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('No logged-in user found')));
                      return;
                    }

                    // Split the date and time
                    String formattedDate = "${selectedTaskDate!.toLocal()}"
                        .split(' ')[0]; // Date in YYYY-MM-DD format
                    String formattedTime =
                        "${selectedTaskTime!.hour.toString().padLeft(2, '0')}:${selectedTaskTime!.minute.toString().padLeft(2, '0')}:00"; // Time in HH:MM:SS format

                    await DatabaseHelper().addTask(
                      userId,
                      taskName,
                      taskDescription!,
                      0, // Task not completed initially
                      selectedCategory!,
                      formattedDate, // Store the date
                      formattedTime, // Store the time
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Task Added Successfully')));
                    // TODO: The page doesn't reload after hitting the add task button.
                    // Determine the current route and refresh accordingly
                    //print("Current Route: $currentRoute");
                    if (currentRoute == '/home') {
                      Navigator.of(context).popAndPushNamed('/home');
                    } else if (currentRoute == '/search') {
                      Navigator.of(context).popAndPushNamed('/search');
                    } else {
                      Navigator.of(context).pop(); // Default: just pop
                    }
                  },
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.h,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static FloatingActionButton showAddTaskModal(BuildContext context,
      {required int? userId, required String currentRoute}) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    // Capture the current route before opening the modal

    print("Current Route: $currentRoute");
    return FloatingActionButton.small(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: appTheme.startBGcolor,
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows the modal to adjust for keyboard
        builder: (BuildContext context) {
          return addTaskModal(
            context,
            userId: userId,
            currentRoute: currentRoute,
            titleController: titleController,
            descriptionController: descriptionController,
          );
        },
      ),
    );
  }
}
