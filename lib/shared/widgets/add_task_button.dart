import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/widgets/custom_text_form_field.dart'; // Adjust based on your project structure
import 'package:flutter_application_1/app_export.dart'; // Adjust based on your project structure

class AddTaskButton {
  static FloatingActionButton showAddTaskModal(BuildContext context,
      {required int? userId}) {
    // Add Task Button
    return FloatingActionButton.small(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: appTheme.startBGcolor,
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          // Controllers and state variables
          final TextEditingController titleController = TextEditingController();
          final TextEditingController descriptionController =
              TextEditingController();
          String? selectedCategory;
          DateTime? selectedDate;
          TimeOfDay? selectedTime;

          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: appTheme.dailyBlocks,
                ),
                padding: const EdgeInsets.all(10.0),
                height: 600,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Task',
                          style: TextStyle(
                            color: Color.fromARGB(209, 37, 68, 83),
                            fontSize: 16.h,
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
                    SizedBox(height: 20.0),
                    // Task Name Field
                    CustomTextFormField(
                      controller: titleController,
                      fillColor: Colors.white,
                      borderDecoration: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0, color: Colors.lightBlue.shade50),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      hintText: "Task Name",
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 20.0),
                    // Task Description Field
                    CustomTextFormField(
                      controller: descriptionController,
                      fillColor: Colors.white,
                      borderDecoration: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 2.0, color: Colors.lightBlue.shade50),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      hintText: "Task Description",
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 20.0),
                    // Category Dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.h),
                        ),
                      ),
                      hint: Text("Select Category"),
                      value: selectedCategory,
                      items: [
                        "Daily",
                        "Challenge",
                        "Work",
                        "Personal",
                        "Urgent",
                        "Other"
                      ]
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
                    SizedBox(height: 20.h),
                    // Date Picker
                    GestureDetector(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    SizedBox(height: 20.0),
                    // Time Picker
                    GestureDetector(
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                    SizedBox(height: 20.h),
                    // Add Task Button
                    FloatingActionButton(
                      child: Text('Add',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.h,
                              fontWeight: FontWeight.bold)),
                      backgroundColor: appTheme.profileAvatar,
                      onPressed: () async {
                        String taskName = titleController.text.trim();
                        // ignore: unused_local_variable
                        String taskDescription =
                            descriptionController.text.trim();
                        // todo (fix): snackbar appears in the background
                        if (taskName.isEmpty ||
                            selectedCategory == null ||
                            selectedDate == null ||
                            selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please fill all fields')));
                          return;
                        }

                        // Insert task into the database
                        int? userId = currentUser?.id;
                        if (userId == -1) {
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
                          0, // Task not completed initially
                          selectedCategory!,
                          fullDateTime.toIso8601String(),
                          fullDateTime.toIso8601String(),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Task Added Successfully')));

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
