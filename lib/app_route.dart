import 'package:flutter/material.dart';

class AppRouteManager {
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String homeRoute = "/home";
  static const String sarchRoute = "/search";
  static const String profileRoute = "/profile";

  static void nextScreen(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void replaceScreen(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => page));
  }

  static void nextNamedScreen(BuildContext context, String path,
      {Object? arguments}) {
    Navigator.of(context).pushNamed(path, arguments: arguments);
  }

  static void replaceNamedScreen(BuildContext context, String path,
      {Object? arguments}) {
    Navigator.of(context).pushReplacementNamed(path, arguments: arguments);
  }
}
