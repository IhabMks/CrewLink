import 'package:chatapp/helper/helper_functions.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/pages/profile_page.dart';
import 'package:chatapp/pages/search_page.dart';
import 'package:chatapp/pages/signup_page.dart';
import 'package:chatapp/app_route.dart';
import 'package:chatapp/shared/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constant.apiKey,
            appId: Constant.appId,
            messagingSenderId: Constant.messagingSenderId,
            projectId: Constant.projectId));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasCredentials = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null && value) {
        setState(() => _hasCredentials = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Constant.primaryColor,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      initialRoute: _hasCredentials
          ? AppRouteManager.homeRoute
          : AppRouteManager.loginRoute,
      routes: {
        AppRouteManager.loginRoute: (context) => const LoginPage(),
        AppRouteManager.homeRoute: (context) => const HomePage(),
        AppRouteManager.signUpRoute: (context) => const SignUpPage(),
        AppRouteManager.sarchRoute: (context) => const SearchPage(),
        AppRouteManager.profileRoute: (context) => const ProfilePage(),
      },
    );
  }
}
