import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget headerbutton({
  required String buttontext,
  required IconData buttonicon,
  required void Function() buttonaction,
  required Color buttoncolor,
}) {
  return ElevatedButton.icon(
      onPressed: buttonaction,
      style: ElevatedButton.styleFrom(elevation: 0, primary: Colors.white),
      icon: Icon(
        buttonicon,
        color: buttoncolor,
      ),
      label: Text(
        buttontext,
        style: TextStyle(color: Colors.black),
      ));
}
