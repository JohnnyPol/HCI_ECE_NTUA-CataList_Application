import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String? _profileImagePath;

  String? get profileImagePath => _profileImagePath;

  void setProfileImage(String path) {
    _profileImagePath = path;
    notifyListeners();
  }
}