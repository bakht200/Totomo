import 'package:dating_app/constants/assets.dart';
import 'package:flutter/material.dart';

import '../../widgets/avatar.dart';

class Room extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: ListView(
        padding: EdgeInsets.all(10),
        scrollDirection: Axis.horizontal,
        children: [
          Avatar(
            pic: bat,
            displayStatus: true,
          ),
          Avatar(pic: sup, displayStatus: true),
          Avatar(pic: bat, displayStatus: true),
          Avatar(pic: sup, displayStatus: true),
          Avatar(pic: bat, displayStatus: true),
          Avatar(pic: sup, displayStatus: true),
          Avatar(pic: bat, displayStatus: true),
          Avatar(pic: sup, displayStatus: true),
          Avatar(pic: bat, displayStatus: true),
          Avatar(pic: sup, displayStatus: true),
        ],
      ),
    );
  }
}
