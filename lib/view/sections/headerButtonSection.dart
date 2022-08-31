import 'package:flutter/material.dart';

class HeaderButtonSection extends StatelessWidget {
  final Widget buttonOne;
  final Widget buttonTwo;

  HeaderButtonSection({
    required this.buttonOne,
    required this.buttonTwo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buttonOne,
          VerticalDivider(
            thickness: 1,
            color: Colors.grey[300],
          ),
          buttonTwo,
        ],
      ),
    );
  }
}
