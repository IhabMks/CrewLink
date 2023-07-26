import 'package:chatapp/helper/helper_functions.dart';
import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/signup_page.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/database_service.dart';
import 'package:chatapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String email = "";
  String password = "";
  bool _loginLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loginLoading
            ? Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor))
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Text("CrewLink",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10),
                          const Text(
                            "Connect with CrewLink - Chat and Conquer!",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                          Image.asset("assets/images/login.png"),
                          TextFormField(
                            decoration: textInputDecoration.copyWith(
                                labelText: "Email",
                                prefixIcon: Icon(Icons.email,
                                    color: Theme.of(context).primaryColor)),
                            onChanged: (value) => email = value,
                            // checkValidation
                            validator: (value) {
                              // Regex pattern for email validation
                              return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(value!)
                                  ? null
                                  : "Please enter a valid email address";
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                                labelText: "Password",
                                prefixIcon: Icon(Icons.lock,
                                    color: Theme.of(context).primaryColor)),
                            onChanged: (value) => password = value,
                            validator: (value) {
                              // Regex pattern for password validation
                              return RegExp(
                                          r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
                                      .hasMatch(value!)
                                  ? null
                                  : " Please use at least 8 characters with a mix of lowercase, uppercase, numbers, and symbols";
                            },
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onPressed: () => login(),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text("Login"),
                                  ))),
                          const SizedBox(height: 10),
                          Text.rich(TextSpan(
                              text: "Dont have an account? ",
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                              children: <InlineSpan>[
                                TextSpan(
                                    text: "Sign up!",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        nextScreen(context, const SignUpPage());
                                      })
                              ]))
                        ]),
                  ),
                ),
              ));
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _loginLoading = true;
      });
      await _authService
          .logInWithEmailAndPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);

          // saving the shared preferences state
          HelperFunctions.saveUserLoggedInStatus(true);
          HelperFunctions.saveUserEmail(email);
          // [0] because the search by email is unique per user => one match at most
          HelperFunctions.saveUserFullName(snapshot.docs[0]['fullName']);
          showSnackBar(context, Colors.green, "Welcome back!");
          replaceScreen(context, const HomePage());
        } else {
          showSnackBar(context, Colors.red, value.toString());
        }
        setState(() {
          _loginLoading = false;
        });
      });
    }
  }
}
