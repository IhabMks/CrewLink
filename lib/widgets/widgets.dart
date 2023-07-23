import 'package:chatapp/shared/constant.dart';
import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Constant.primaryColor, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
  ),
);

void nextScreen(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void replaceScreen(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
