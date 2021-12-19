import 'package:flutter/material.dart';
import 'package:mindmerge/constants/colours.dart';

class Card extends StatelessWidget {
  const Card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        color: lightColor,
      ),
    );
  }
}
