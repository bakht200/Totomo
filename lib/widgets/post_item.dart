import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../theme/colors.dart';

class PostItem extends StatelessWidget {
  final String profileImg;
  final String name;
  final String postImg;
  final String caption;
  final isLoved;
  final String likedBy;
  final String viewCount;

  const PostItem({
    required this.profileImg,
    required this.name,
    required this.postImg,
    required this.isLoved,
    required this.likedBy,
    required this.viewCount,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(profileImg),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            name,
                            style: TextStyle(
                                color: black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.location_on, color: Colors.grey),
                            Text(
                              'Peshawar',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(postImg), fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    isLoved
                        ? SvgPicture.asset(
                            "assets/images/loved_icon.svg",
                            width: 27,
                            color: Colors.black,
                          )
                        : SvgPicture.asset(
                            "assets/images/love_icon.svg",
                            width: 27,
                            color: Colors.black,
                          ),
                    SizedBox(
                      width: 20,
                    ),
                    SvgPicture.asset(
                      "assets/images/comment_icon.svg",
                      width: 27,
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 15, right: 15),
          //   child: Row(children: [
          //     Icon(
          //       Icons.thumb_up_sharp,
          //       color: Colors.blue,
          //       size: 15,
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Text("12",
          //         style: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: Colors.black)),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     Icon(
          //       Icons.comment_sharp,
          //       color: Colors.blue,
          //       size: 15,
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Text("12",
          //         style: TextStyle(
          //             fontSize: 15,
          //             fontWeight: FontWeight.w500,
          //             color: Colors.black)),
          //   ]),
          // ),

          Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: "$name ",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black)),
                TextSpan(
                    text: "$caption",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
              ]))),
          SizedBox(
            height: 12,
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 15, right: 15),
          //   child: Text(
          //     "View $viewCount comments",
          //     style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 15,
          //         fontWeight: FontWeight.w500),
          //   ),
          // ),
          // SizedBox(
          //   height: 12,
          // ),
        ],
      ),
    );
  }
}
