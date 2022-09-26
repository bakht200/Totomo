import 'package:flutter/material.dart';

class ViewPost extends StatefulWidget {
  final String profileImg;
  final String name;
  var postImg;
  final String caption;
  final isLoved;
  final String likedBy;
  final String viewCount;

  ViewPost({
    required this.profileImg,
    required this.name,
    this.postImg,
    required this.isLoved,
    required this.likedBy,
    required this.viewCount,
    required this.caption,
  });

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
