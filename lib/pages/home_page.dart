import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("HomePage"),
              ElevatedButton(
                  child: const Text("LOGOUT"),
                  onPressed: () {
                    authService.logOut();
                    showSnackBar(context, Colors.green, "Logged out!");
                    replaceScreen(context, const LoginPage());
                  })
            ]),
      ),
    );
  }
}
