import 'package:chatapp/app_route.dart';
import 'package:flutter/material.dart';

class CrewTile extends StatelessWidget {
  final String crewId;
  final String crewName;
  final String admin;
  const CrewTile(
      {super.key,
      required this.crewId,
      required this.crewName,
      required this.admin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: ListTile(
        onTap: () {
          AppRouteManager.nextNamedScreen(context, "/chat");
        },
        leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              crewName.substring(0, 1),
              style: const TextStyle(color: Colors.white),
            )),
        title: Text(crewName),
        subtitle: Text(
          "Captain: $admin",
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
