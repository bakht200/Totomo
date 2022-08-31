import 'package:dating_app/constants/assets.dart';
import 'package:flutter/material.dart';

import '../../widgets/suggestionCard.dart';

class SuggestionSection extends StatelessWidget {
  get sup => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: Column(
        children: [
          ListTile(
            title: Text("People You May Know"),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz),
            ),
          ),
          Container(
            height: 390,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SuggestionCard(
                    mutual: "37 Mutual Friends",
                    name: "Black Superman",
                    profilePic: sup),
                SuggestionCard(
                    mutual: "23 Mutual Friends",
                    name: "Ultimate Batman",
                    profilePic: bat),
                SuggestionCard(
                    mutual: "12 Mutual Friends",
                    name: "Black Superman",
                    profilePic: sup),
                SuggestionCard(
                    mutual: "56 Mutual Friends",
                    name: "Ultimate Batman",
                    profilePic: bat),
                SuggestionCard(
                    mutual: "32 Mutual Friends",
                    name: "Black Superman",
                    profilePic: sup),
              ],
            ),
          )
        ],
      ),
    );
  }
}
