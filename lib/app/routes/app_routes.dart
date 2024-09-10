import 'package:flutter/material.dart';
import 'package:mondooli_registration/app/modules/login/login_screen.dart';
import 'package:mondooli_registration/app/modules/registration/registration_screen.dart';
import 'package:mondooli_registration/app/modules/splashscreen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case registration:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
