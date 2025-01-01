import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_export.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecoration.linearBGcolors,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text("Home Page")),
        body: SafeArea(
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(),
            ),
          ),
        ),
      ),
    );
  }
}
