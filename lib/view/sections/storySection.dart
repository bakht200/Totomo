import 'package:dating_app/constants/assets.dart';
import 'package:dating_app/flutterUi/widgets/storyCard.dart';
import 'package:flutter/material.dart';

class StorySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          StoryCard(
            labelText: "Add to story",
            story: sup,
            avatar: sup,
            createStoryStatus: true,
          ),
          StoryCard(
              labelText: "Bat",
              story: bat,
              avatar: sup,
              stborder: true,
              createStoryStatus: false),
          StoryCard(
            labelText: "sup",
            story: sup,
            avatar: bat,
            createStoryStatus: false,
            stborder: true,
          ),
          StoryCard(
              labelText: "bat",
              story: bat,
              avatar: sup,
              stborder: true,
              createStoryStatus: false),
          StoryCard(
              labelText: "sup",
              story: sup,
              stborder: true,
              avatar: bat,
              createStoryStatus: false),
        ],
      ),
    );
  }
}
