// app_routes.dart

import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/dashboard/views/profile_page.dart';
import '../features/start/views/start_page.dart';
import '../features/start/views/register_login_page.dart';
import '../features/auth/views/login_page.dart';
import '../features/auth/views/register_page.dart';
import '../features/dashboard/views/home_page.dart';
import '../features/dashboard/views/recap_page.dart';
import '../features/dashboard/views/weekly_recap_page.dart';
import '../features/dashboard/views/monthly_recap_page.dart';
import '../features/dashboard/views/search_page.dart';
import '../features/dashboard/views/calendar_page.dart';
import '../features/dashboard/views/view_task_page.dart';
import '../features/dashboard/views/daily_schedule.dart';

class AppRoutes {
  static const String start = '/';
  static const String login = '/login';
  static const String registerLogin = '/register_login';
  static const String register = '/register';
  static const String home = '/home';
  static const String search = '/search';
  static const String recap = '/recap';
  static const String weekly = '/weekly';
  static const String monthly= '/monthly';
  static const String calendar = '/calendar';
  static const String profile = '/profile';
  static const String viewTask = '/view_task';
  static const String dailySchedule = '/daily_schedule';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case start:
        return MaterialPageRoute(builder: (context) => const StartPage());
      case registerLogin:
        return MaterialPageRoute(builder: (context) => RegisterLoginPage());
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case register:
        return MaterialPageRoute(builder: (context) => RegisterPage());
      case home:
        return MaterialPageRoute(builder: (context) => HomePage());
      case search:
        return MaterialPageRoute(builder: (context) => SearchPage());
      case recap:
        return MaterialPageRoute(builder: (context) => RecapPage());
      case weekly:
        return MaterialPageRoute(builder: (context) => WeeklyRecapPage());
      case monthly:
        return MaterialPageRoute(builder: (context) => MonthlyRecapPage());
      case calendar:
        return MaterialPageRoute(builder: (context) => CalendarPage());
      case profile:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case viewTask:
        return my_Route(ViewTaskPage(), settings: settings);
      case dailySchedule: // Handle the DailySchedulePage route
        final args = settings.arguments as Map<String, dynamic>?;
        final selectedDate = args?['selectedDate'] as DateTime?;
        return MaterialPageRoute(
          builder: (context) => DailySchedulePage(selectedDate: selectedDate!),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}

//Custom Transition
Route my_Route(Widget target, {RouteSettings? settings}) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => target,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
