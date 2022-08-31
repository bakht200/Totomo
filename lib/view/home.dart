import 'package:dating_app/constants/app_theme.dart';
import 'package:dating_app/constants/themes.dart';
import 'package:dating_app/view/sections/room.dart';
import 'package:dating_app/view/sections/statusSection.dart';
import 'package:dating_app/view/sections/storySection.dart';
import 'package:dating_app/view/sections/suggestionSection.dart';
import 'package:flutter/material.dart';

import '../constants/assets.dart';
import '../widgets/circular_button.dart';
import '../widgets/header_Button.dart';
import '../widgets/postcard.dart';
import 'sections/headerButtonSection.dart';

class Home extends StatefulWidget {
  @override
  homeState createState() => homeState();
}

class homeState extends State<Home> {
  Color butt = Colors.pink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Totomo",
          style: TextStyle(
            color: Color(AppTheme.primaryColor),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircularButton(
            buttonIcon: Icons.message,
            buttonAction: () {
              print("hello");
            },
          )
        ],
      ),
      body: ListView(
        children: [
          StatusSection(),
          Divider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          HeaderButtonSection(
            buttonOne: headerbutton(
                buttontext: "Gallery",
                buttonicon: Icons.photo_library,
                buttonaction: () {},
                buttoncolor: Colors.red),
            buttonTwo: headerbutton(
                buttontext: "Camera",
                buttonicon: Icons.camera,
                buttonaction: () {},
                buttoncolor: Colors.green),
          ),
          Divider(
            thickness: 10,
            color: Colors.grey[300],
          ),
          StorySection(),
          Divider(
            thickness: 10,
            color: Colors.grey[300],
          ),
          PostCard(
            varifiedpost: true,
            pics: sup,
            name: "Spiderman",
            time: "4h",
            postImage: bat,
            postTitle: "hai man get some sleep,",
            like: "15K",
            comments: "2K",
            share: "432",
          ),
          Divider(
            thickness: 10,
            color: Colors.grey[300],
          ),
          PostCard(
            varifiedpost: true,
            pics: bat,
            name: "Batman",
            time: "8h",
            postImage: sup,
            postTitle: "yoo bud",
            like: "30K",
            comments: "2K",
            share: "344",
          ),
          Divider(
            thickness: 10,
            color: Colors.grey[300],
          ),
          PostCard(
            varifiedpost: true,
            pics: sup,
            name: "Spiderman",
            time: "4h",
            postImage: bat,
            postTitle: "hai mahn get some sleep,",
            like: "15K",
            comments: "2K",
            share: "232",
          ),
          Divider(
            thickness: 10,
            color: Colors.grey[300],
          ),
          SuggestionSection(),
          Divider(
            thickness: 10,
            color: Colors.grey[300],
          ),
          PostCard(
            varifiedpost: true,
            pics: bat,
            name: "Batman",
            time: "8h",
            postImage: sup,
            postTitle:
                "yooo baby how are you mahn... how you doin. come here mahn i have got some job for you dude..",
            like: "15K",
            comments: "2K",
            share: "211",
          ),
        ],
      ),
    );
  }
}
