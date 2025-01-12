// main.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Initialize dummy data before running the app
  await initializeDummyData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ProfileProvider()), // Add ProfileProvider
      ],
      child: Sizer(builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false, // Remove the debug banner
          title: 'CataList',
          theme: theme,
          //initialRoute: AppRoutes.home,
          initialRoute: AppRoutes.start,
          onGenerateRoute: AppRoutes.onGenerateRoute,
        );
      }),
    );
  }
}

Future<void> initializeDummyData() async {
  final dbHelper = DatabaseHelper();

  // Check if the dummy user exists
  final dummyUser = await dbHelper.getUserByUsername("anonymous");
  int? userId;
  if (dummyUser.isEmpty) {
    // Create the dummy user
    final userId = await dbHelper.addUser(
        "anonymous", "DummyUser", "Testing", "ntua@mail.ntua.gr", "testing");

    // Add some dummy tasks for this user
    await dbHelper.addTask(
      userId,
      "Welcome Task",
      "This is a sample task to help you get started.",
      0, // Not completed
      "Daily",
      DateTime.now().toIso8601String().split("T")[0], // Today's date
      "10:00:00", // Time
    );

    await dbHelper.addTask(
      userId,
      "Explore the App",
      "Try navigating through different features of the app.",
      0, // Not completed
      "Challenge",
      DateTime.now()
          .add(Duration(days: 1))
          .toIso8601String()
          .split("T")[0], // Tomorrow's date
      "14:00:00", // Time
    );

    await dbHelper.addTask(
      userId,
      "Complete a Task",
      "Mark a task as completed to see how the app tracks progress.",
      0, // Not completed
      "Daily",
      DateTime.now()
          .add(Duration(days: 2))
          .toIso8601String()
          .split("T")[0], // Day after tomorrow's date
      "09:00:00", // Time
    );

    await dbHelper.addTask(
      userId,
      "Upload a Photo",
      "Use the photo feature to capture and save a memory.",
      0, // Not completed
      "Challenge",
      DateTime.now()
          .add(Duration(days: 3))
          .toIso8601String()
          .split("T")[0], // Three days from now
      "16:00:00", // Time
    );

    await dbHelper.addTask(
      userId,
      "Review Your Week",
      "Go to the recap page to review your weekly progress.",
      0, // Not completed
      "Challenge",
      DateTime.now()
          .add(Duration(days: 4))
          .toIso8601String()
          .split("T")[0], // Four days from now
      "18:00:00", // Time
    );

    print("Dummy user and tasks have been created.");
    await initializeDummyPhotos(userId);
  } else {
    userId = await dbHelper.getUserId("anonymous");
    await initializeDummyPhotos(userId);
    print("Dummy user already exists.");
  }
}

Future<void> initializeDummyPhotos(int? userId) async {
  final photoStorage = PhotoStorage();
  final List<File> existingPhotos =
      await photoStorage.getUserPhotos(userId: userId);

  if (existingPhotos.isNotEmpty) {
    print("Dummy photos already exist for this user.");
    return;
  }

  // Define the dummy photo assets and their corresponding timestamps
  final List<Map<String, dynamic>> dummyPhotoAssets = [
    {
      'assetPath': 'assets/dummy_photos/photo1.jpg',
      'timestamp': '2025-01-11 10:00:00'
    },
    {
      'assetPath': 'assets/dummy_photos/photo2.jpg',
      'timestamp': '2025-01-01 14:00:00'
    },
    {
      'assetPath': 'assets/dummy_photos/photo3.jpg',
      'timestamp': '2024-12-20 18:00:00'
    },
    {
      'assetPath': 'assets/dummy_photos/photo4.jpg',
      'timestamp': '2024-11-25 18:00:00'
    },
    {
      'assetPath': 'assets/dummy_photos/photo5.jpg',
      'timestamp': '2024-10-05 18:00:00'
    },
    {
      'assetPath': 'assets/dummy_photos/photo6.jpg',
      'timestamp': '2025-01-12 10:00:00'
    },
    {
      'assetPath': 'assets/dummy_photos/photo7.jpg',
      'timestamp': '2025-01-10 10:00:00'
    },
  ];

  for (final dummyPhoto in dummyPhotoAssets) {
    final byteData = await rootBundle.load(dummyPhoto['assetPath']);
    final tempFile = File(
        '${(await getTemporaryDirectory()).path}/${dummyPhoto['assetPath'].split('/').last}');
    await tempFile.writeAsBytes(byteData.buffer.asUint8List());

    // Extract custom timestamp and convert it to milliseconds since epoch
    final DateTime customDateTime = DateTime.parse(dummyPhoto['timestamp']);
    final int timestamp = customDateTime.millisecondsSinceEpoch;

    // Create a unique file name with userId and custom timestamp
    final String fileName = "photo_user${userId ?? 'unknown'}_${timestamp}.jpg";
    final File savedPhoto = await tempFile
        .copy('${(await getApplicationDocumentsDirectory()).path}/$fileName');
    print("Dummy photo saved for user $userId: ${savedPhoto.path}");
  }
}

void clearDatabase() async {
  DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.deleteAllTables();
  print("All tables have been deleted.");
}
