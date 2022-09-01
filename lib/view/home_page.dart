import 'package:dating_app/theme/colors.dart';
import 'package:flutter/material.dart';

import '../widgets/post_item.dart';
import '../widgets/story_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: getBody());
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      children: List.generate(10, (index) {
                    return StoryItem(
                      img:
                          'https://st2.depositphotos.com/3310833/7828/v/380/depositphotos_78289624-stock-illustration-flat-hipster-character.jpg?forcejpeg=true',
                      name: 'Story',
                    );
                  })),
                ),
              ],
            ),
          ),
          Divider(
            color: white.withOpacity(0.3),
          ),
          Column(
            children: List.generate(5, (index) {
              return PostItem(
                postImg:
                    'https://st2.depositphotos.com/3310833/7828/v/380/depositphotos_78289624-stock-illustration-flat-hipster-character.jpg?forcejpeg=true',
                profileImg:
                    'https://st2.depositphotos.com/3310833/7828/v/380/depositphotos_78289624-stock-illustration-flat-hipster-character.jpg?forcejpeg=true',
                name: 'Bakht',
                caption: 'Hello here man how are you',
                isLoved: true,
                viewCount: '5',
                likedBy: 'likesBy',
              );
            }),
          )
        ],
      ),
    );
  }
}
