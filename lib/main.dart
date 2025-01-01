import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/app_export.dart';
import 'package:provider/provider.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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

void clearDatabase() async {
  DatabaseHelper dbHelper = DatabaseHelper();
  await dbHelper.deleteAllTables();
  print("All tables have been deleted.");
}
