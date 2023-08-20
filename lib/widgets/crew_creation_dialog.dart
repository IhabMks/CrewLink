import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:chatapp/widgets/widgets.dart';

class CrewCreationDialog extends StatefulWidget {
  final Map<String, String> userDetails;
  const CrewCreationDialog({super.key, required this.userDetails});

  @override
  State<CrewCreationDialog> createState() => _CrewCreationDialogState();
}

class _CrewCreationDialogState extends State<CrewCreationDialog> {
  final _formKey = GlobalKey<FormState>();
  AuthService authService = AuthService();
  bool isGroupLoading = false;
  String crewName = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Build your crew", textAlign: TextAlign.left),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        isGroupLoading == true
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : Form(
                key: _formKey,
                child: TextFormField(
                  decoration: textInputDecoration.copyWith(
                      labelText: "Name",
                      hintText: "Crew name",
                      prefixIcon: Icon(Icons.flag,
                          color: Theme.of(context).primaryColor)),
                  onChanged: (newCrewName) {
                    crewName = newCrewName;
                  },

                  // checkValidation
                  validator: (value) {
                    // Regex pattern for crew name validation
                    return RegExp(
                      r"^[a-zA-Z][a-zA-Z0-9 \-*_+()\[\]\|]{6,24}$",
                    ).hasMatch(value!)
                        ? null
                        : "Start with a letter, at least 6 characters. Allowed symbols: _-+*()[]|";
                  },
                ),
              ),
      ]),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => createCrew(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor),
          child: const Text("Build up!"),
        )
      ],
    );
  }

  createCrew() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isGroupLoading = true);
      final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
      DatabaseService(uid: currentUserUID)
          .createGroup(
              widget.userDetails["fullname"]!, currentUserUID, crewName)
          .whenComplete(() => isGroupLoading = false);
      Navigator.of(context).pop();
      showSnackBar(context, Colors.green, "Crew is ready to sail!");
    }
  }
}
