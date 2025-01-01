import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:provider/provider.dart';
import 'dart:io';


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
              Navigator.pop(context); // This navigates back to the previous screen
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
            ],
          ),
        ),
      ),
    );
  }
}