import 'package:flutter/material.dart';
import 'package:mindmerge/constants/colours.dart';

class CardMeterIndicator extends StatefulWidget {
  final int cardMeter;
  final double height;
  final double width;
  final double padding;

  const CardMeterIndicator({
    this.cardMeter = 0,
    this.height = 50,
    this.width = 15,
    this.padding = 2,
    Key? key,
  }) : super(key: key);

  @override
  _CardMeterIndicatorState createState() => _CardMeterIndicatorState();
}

class _CardMeterIndicatorState extends State<CardMeterIndicator> {
  final int numBars = 10;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          numBars,
          (index) => Container(
            width: widget.width,
            height: (widget.height - (numBars * widget.padding)) / numBars,
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
