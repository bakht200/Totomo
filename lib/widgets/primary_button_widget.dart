import 'package:flutter/material.dart';

import '../constants/app_theme.dart';

class theme_primary_button_widget extends StatelessWidget {
  var primaryColor;
  var textColor;
  var onpressFunction;
  var title;

  theme_primary_button_widget(
      {required this.primaryColor,
      required this.textColor,
      required this.onpressFunction,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7), // <-- Radius
        ),
        primary: primaryColor, // background
        onPrimary: textColor, // foreground
      ),
      onPressed: onpressFunction,
      child: Text('${title}'),
    );
  }
}
