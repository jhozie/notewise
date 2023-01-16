import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notewise/main.dart';
import 'package:notewise/screens/login.dart';
import 'package:notewise/screens/onboarding.dart';
import 'package:notewise/screens/register.dart';

class RouteManager {
  static const homepage = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String onBoarding = '/onboarding';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case register:
        return MaterialPageRoute(builder: ((context) => const Register()));
      case login:
        return MaterialPageRoute(builder: ((context) => const Login()));
      case onBoarding:
        return MaterialPageRoute(builder: ((context) => const Onboarding()));
      case homepage:
        return MaterialPageRoute(builder: ((context) => MyHomePage()));
      default:
        throw Exception('Route not found');
    }
  }
}
