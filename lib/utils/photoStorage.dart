import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class PhotoStorage {
  final ImagePicker _picker = ImagePicker();

  // Capture and save a photo
  Future<String?> captureAndSavePhoto({required int? userId}) async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo == null) {
      return null; // User canceled the photo capture
    }

    // Get the app's documents directory
    final Directory appDir = await getApplicationDocumentsDirectory();

    // Create a unique file name with userId
    final String fileName =
        "photo_user${userId ?? 'unknown'}_${DateTime.now().millisecondsSinceEpoch}.jpg";

    // Copy the photo to the documents directory
    final File savedPhoto =
        await File(photo.path).copy("${appDir.path}/$fileName");

    return savedPhoto.path; // Return the file path for future use
  }

  // Retrieve all stored photos
  Future<List<File>> getStoredPhotos() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = appDir.listSync();

    // Filter only files with a .jpg extension
    return files
        .where((file) => file is File && file.path.endsWith(".jpg"))
        .map((file) => File(file.path))
        .toList();
  }

  // Retrieve weekly photos
  Future<List<List<File>>> getWeeklyPhotos() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = appDir.listSync();

    // Current time for reference
    final DateTime now = DateTime.now();

    // Filter and group photos by week
    final List<List<File>> weeklyPhotos = List.generate(4, (_) => []);

    for (var file in files) {
      if (file is File && file.path.endsWith(".jpg")) {
        final DateTime fileDate = _extractDateFromFileName(file.path);
        final Duration difference = now.difference(fileDate);

        if (difference.inDays < 7) {
          weeklyPhotos[0].add(file);
        } else if (difference.inDays < 14) {
          weeklyPhotos[1].add(file);
        } else if (difference.inDays < 21) {
          weeklyPhotos[2].add(file);
        } else if (difference.inDays < 28) {
          weeklyPhotos[3].add(file);
        }
      }
    }
    return weeklyPhotos;
  }

  // Retrieve monthly photos
  Future<List<List<File>>> getMonthlyPhotos() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = appDir.listSync();

    // Current time for reference
    final DateTime now = DateTime.now();

    // Filter and group photos by month
    final List<List<File>> monthlyPhotos = List.generate(6, (_) => []);

    for (var file in files) {
      if (file is File && file.path.endsWith(".jpg")) {
        final DateTime fileDate = _extractDateFromFileName(file.path);
        final int monthDifference =
            (now.year - fileDate.year) * 12 + (now.month - fileDate.month);

        if (monthDifference == 0) {
          monthlyPhotos[0].add(file);
        } else if (monthDifference == 1) {
          monthlyPhotos[1].add(file);
        } else if (monthDifference == 2) {
          monthlyPhotos[2].add(file);
        } else if (monthDifference == 3) {
          monthlyPhotos[3].add(file);
        } else if (monthDifference == 4) {
          monthlyPhotos[4].add(file);
        } else if (monthDifference == 5) {
          monthlyPhotos[5].add(file);
        }
      }
    }
    return monthlyPhotos;
  }

  // Delete all stored photos
  Future<void> deleteAllPhotos() async {
    final Directory appDir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> files = appDir.listSync();

    for (var file in files) {
      if (file is File && file.path.endsWith(".jpg")) {
        await file.delete(); // Delete the photo file
      }
    }
  }

  // Helper method to extract date from file name
  DateTime _extractDateFromFileName(String filePath) {
    final RegExp regex = RegExp(r"photo_user\d+_(\d+)\.jpg");
    final Match? match = regex.firstMatch(filePath);

    if (match != null) {
      final int timestamp = int.parse(match.group(1)!);
      return DateTime.fromMillisecondsSinceEpoch(timestamp);
    }

    return DateTime.now(); // Fallback to now if no match
  }
}
