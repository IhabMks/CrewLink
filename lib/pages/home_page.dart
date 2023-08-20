import 'package:chatapp/app_route.dart';
import 'package:chatapp/helper/helper_functions.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:chatapp/widgets/crew_creation_dialog.dart';
import 'package:chatapp/widgets/crew_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();

  Map<String, String> userDetails = {};
  Stream? groups;
  bool isGroupLoading = false;
  String crewName = "";

  String getCrewName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  String getCrewId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

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
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .gettingUserGroups()
        .then((snapshot) {
      groups = snapshot;
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
                  context, AppRouteManager.searchRoute);
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
      floatingActionButton: FloatingActionButton(
          onPressed: () => dialogPopup(),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          child: const Icon(Icons.add, size: 40)),
      body: groupList(),
    );
  }

  dialogPopup() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CrewCreationDialog(
              userDetails: userDetails,
            ));
  }

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, snapshot) {
        // Checks for different types of user cases
        if (snapshot.hasData) {
          final data = snapshot.data["groups"];
          if (data != null && data.length != 0) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return CrewTile(
                    crewId: getCrewId(data[index]),
                    crewName: getCrewName(data[index]),
                    admin: userDetails["fullname"] ?? "");
              },
            );
          } else {
            return noGroupWidget();
          }
        } else {
          return Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor));
        }
      },
    );
  }

  noGroupWidget() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => dialogPopup(),
              borderRadius: BorderRadius.circular(100),
              child: Icon(
                Icons.add_circle,
                color: Colors.grey[700],
                size: 70,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "You've not joined any crew, tap on the add icon to create a crew of your own or maybe join one by pressing the top search button.",
              textAlign: TextAlign.center,
            )
          ]),
    );
  }
}
