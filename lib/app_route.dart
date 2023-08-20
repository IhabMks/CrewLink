import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/profile_page.dart';
import 'package:chatapp/pages/search_page.dart';
import 'package:chatapp/pages/signup_page.dart';
import 'package:flutter/material.dart';

class AppRouteManager {
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String homeRoute = "/home";
  static const String searchRoute = "/search";
  static const String profileRoute = "/profile";
  static const String chatRoute = "/chat";

  static Map<String, Widget Function(BuildContext)> generateRouteMap() {
    return {
      loginRoute: (context) => const LoginPage(),
      homeRoute: (context) => const HomePage(),
      signUpRoute: (context) => const SignUpPage(),
      searchRoute: (context) => const SearchPage(),
      profileRoute: (context) => const ProfilePage(),
    };
  }

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
