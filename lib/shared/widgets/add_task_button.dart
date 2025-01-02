// add_task_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/widgets/custom_text_form_field.dart'; // Adjust based on your project structure
import 'package:flutter_application_1/app_export.dart'; // Adjust based on your project structure

class AddTaskButton {
  static FloatingActionButton showAddTaskModal(BuildContext context,
      {required int? userId}) {
    // Controllers and state variables
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    String? selectedCategory;
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    return FloatingActionButton.small(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: appTheme.startBGcolor,
      onPressed: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Allows the modal to adjust for keyboard
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding:
                    MediaQuery.of(context).viewInsets, // Adjust for keyboard
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: appTheme.dailyBlocks,
                  ),
                  padding: const EdgeInsets.all(10.0),
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
                          borderSide: BorderSide(
                              width: 2, color: Colors.lightBlue.shade50),
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
                          borderSide: BorderSide(
                              width: 2, color: Colors.lightBlue.shade50),
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
                            initialDate: selectedDate ?? DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedDate != null
                                  ? "Date: ${selectedDate?.toLocal()}"
                                      .split(' ')[0]
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
                            initialTime: selectedTime ?? TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedTime = pickedTime;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedTime != null
                                  ? "Time: ${selectedTime?.format(context)}"
                                  : "Select Time"),
                              Icon(Icons.access_time),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Add Task Button
                      ElevatedButton(
                        onPressed: () async {
                          String taskName = titleController.text.trim();
                          String taskDescription =
                              descriptionController.text.trim();

                          if (taskName.isEmpty ||
                              selectedCategory == null ||
                              selectedDate == null ||
                              selectedTime == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please fill all fields')));
                            return;
                          }

                          // Insert task into the database
                          if (userId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('No logged-in user found')));
                            return;
                          }

                          DateTime fullDateTime = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          );

                          await DatabaseHelper().addTask(
                            userId,
                            taskName,
                            taskDescription,
                            0, // Task not completed initially
                            selectedCategory!,
                            fullDateTime.toIso8601String(),
                            fullDateTime.toIso8601String(),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Task Added Successfully')));

                          Navigator.of(context).pop();
                        },
                        child: Text('Add Task'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
