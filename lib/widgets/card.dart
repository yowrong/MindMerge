import 'package:flutter/material.dart';
import 'package:mindmerge/constants/colours.dart';

class MindMergeCard extends StatelessWidget {
  final Color color;

  const MindMergeCard({
    this.color = lightColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: color,
      ),
    );
  }
}
