import 'package:chatapp/app_route.dart';
import 'package:chatapp/helper/helper_functions.dart';
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

  Map<String, String> userDetails = {};

  @override
  void initState() {
    super.initState();
    getUserDetails();
  }

  getUserDetails() async {
    await HelperFunctions.getUserDetails().then((value) {
      setState(() {
        userDetails = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crews",
          style: TextStyle(
              fontSize: 26,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.5),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              AppRouteManager.nextNamedScreen(
                  context, AppRouteManager.sarchRoute);
            },
            icon: const Icon(Icons.search),
            iconSize: 30,
          )
        ],
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // Replace DrawerHeader with Container
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.account_circle,
                      size: 120, color: Colors.grey[300]),
                  const SizedBox(height: 10),
                  Text(
                    userDetails["fullname"] ?? "",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    selected: true,
                    selectedColor: Theme.of(context).primaryColor,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.group),
                    title: const Text("Crews",
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    leading: const Icon(Icons.person),
                    title: const Text("Profile",
                        style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500)),
                    onTap: () {
                      AppRouteManager.nextNamedScreen(
                          context, AppRouteManager.profileRoute,
                          arguments: userDetails);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout",
                  style: TextStyle(
                      color: Colors.black,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500)),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.cancel_rounded),
                          color: Colors.red,
                        ),
                        IconButton(
                          onPressed: () {
                            authService.logOut().whenComplete(() =>
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()),
                                    (route) => false));
                          },
                          icon: const Icon(Icons.check),
                          color: Colors.green,
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: Text("HomePage"),
      ),
    );
  }
}
