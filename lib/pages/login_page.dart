import 'package:chatapp/widgets/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
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
                  "Join the CrewLink - Chat, Connect, Conquer!",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
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
                            backgroundColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
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
                          recognizer: TapGestureRecognizer()..onTap = () {})
                    ]))
              ]),
        ),
      ),
    ));
  }

  login() {
    if (_formKey.currentState!.validate()) {}
  }
}
