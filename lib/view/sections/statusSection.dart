import 'package:dating_app/constants/assets.dart';
import 'package:flutter/material.dart';

import '../../widgets/avatar.dart';

class StatusSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Avatar(
        pic: sup,
        displayStatus: false,
      ),
      title: TextField(
        decoration: InputDecoration(
            hintText: "whats on your mind",
            hintStyle: TextStyle(
              color: Colors.black,
            ),
            disabledBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
      ),
    );
  }
}
