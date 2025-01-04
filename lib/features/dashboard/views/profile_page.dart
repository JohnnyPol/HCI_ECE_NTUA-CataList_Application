// profile_page

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:provider/provider.dart';
import 'dart:io';

// TODO: the profile picture changes for every user. Find a way to prevent that

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setProfileImage(image.path);
    }
  }

  Future<void> _takePicture(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      Provider.of<ProfileProvider>(context, listen: false)
          .setProfileImage(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImagePath =
        Provider.of<ProfileProvider>(context).profileImagePath;

    return Container(
      decoration: AppDecoration.linearBGcolors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(
                  context); // This navigates back to the previous screen
            },
          ),
          title: Text("Profile"),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 120,
                backgroundColor: Colors.grey[300],
                backgroundImage: profileImagePath != null
                    ? FileImage(File(profileImagePath))
                    : null,
                child: profileImagePath == null
                    ? Icon(Icons.person, size: 120, color: Colors.black)
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _pickImageFromGallery(context),
                      icon: Icon(Icons.folder),
                      label: Text("Upload from gallery"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => _takePicture(context),
                      icon: Icon(Icons.camera_alt),
                      label: Text("Take a picture"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: Size(double.infinity, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Add logout button
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Log out",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          "Are you sure you want to Log?",
                        ),
                        actions: [
                          // Cancel Logout
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          // Logout
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.pushNamed(context, AppRoutes.start);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                            ),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.logout,
                ),
                label: Text(
                  "Logout",
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.maxFinite, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              // Add Delete all Photos button
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Confirm Deletion",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          "Are you sure you want to delete all your photos? All your data will be permanently lost.",
                        ),
                        actions: [
                          // Cancel deleting photos
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          // Delete photos
                          ElevatedButton(
                            onPressed: () async {
                              // Delete all photos method
                              await PhotoStorage().deleteAllPhotos();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("All photos have been deleted.")),
                              );
                              Navigator.pop(context); // Close the dialog
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.white,
                ),
                label: Text(
                  "Delete All Photos",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.maxFinite, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              // Add Delete Account Button
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Confirm Deletion",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                        ),
                        content: Text(
                          "Are you sure you want to delete your account? All your data will be permanently lost.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              final userId = currentUser
                                  ?.id; // Retrieve the current user's ID
                              if (userId != null) {
                                await DatabaseHelper().deleteUser(userId);
                                currentUser = null; // Clear the currentUser
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/',
                                    (route) =>
                                        false); // Go back to the start page
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text(
                              "Delete",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "Delete Account",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
