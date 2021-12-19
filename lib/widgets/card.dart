import 'package:flutter/material.dart';
import 'package:mindmerge/constants/colours.dart';

class MindMergeCard extends StatelessWidget {
  final Color color;
  final int cardNumber;

  const MindMergeCard({
    required this.cardNumber,
    this.color = lightColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(
                -5.0,
                -5.0,
              ),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$cardNumber", style: TextStyle(fontSize: 18.0)),
                  Text("$cardNumber", style: TextStyle(fontSize: 18.0)),
                ],
              ),
              Center(
                child: Container(
                  child: Text(
                    "$cardNumber",
                    style: TextStyle(fontSize: 36.0, shadows: [
                      Shadow(
                          color: Colors.black,
                          blurRadius: 40),
                    ]),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("$cardNumber", style: TextStyle(fontSize: 18.0)),
                  Text("$cardNumber", style: TextStyle(fontSize: 18.0)),
                ],
              ),
            ],
          ),
        ));
  }
}
