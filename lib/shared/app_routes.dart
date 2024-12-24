import 'package:flutter/material.dart';
import '../features/start/views/start_page.dart';
import '../features/start/views/register_login_page.dart';
import '../features/auth/views/login_page.dart';

class AppRoutes {
  static const String start = '/';
  static const String login = '/login';
  static const String registerLogin = '/register_login';
  static const String register = '/register';
  static const String home = '/home';
  static const String search = '/search';
  static const String recap = '/recap';
  static const String calendar = '/calendar';
  static const String profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case start:
        return MaterialPageRoute(builder: (context) => const StartPage());
      case registerLogin:
        return MaterialPageRoute(builder: (context) => RegisterLoginPage());
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
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
