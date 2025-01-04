import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

class PhotoStorage {
  final ImagePicker _picker = ImagePicker();

  // Capture and save a photo
  Future<String?> captureAndSavePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

    if (photo == null) {
      return null; // User canceled the photo capture
    }

    // Get the app's documents directory
    final Directory appDir = await getApplicationDocumentsDirectory();

    // Create a unique file name
    final String fileName =
        "photo_${DateTime.now().millisecondsSinceEpoch}.jpg";

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
}
