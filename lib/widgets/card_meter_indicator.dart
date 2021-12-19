import 'package:flutter/material.dart';
import 'package:mindmerge/constants/colours.dart';

class CardMeterIndicator extends StatefulWidget {
  final double cardMeter;
  final double height;
  final double width;
  final double padding;
  final int numBars;

  const CardMeterIndicator({
    this.cardMeter = 0,
    this.height = 50,
    this.width = 15,
    this.padding = 2,
    this.numBars = 10,
    Key? key,
  }) : super(key: key);

  @override
  _CardMeterIndicatorState createState() => _CardMeterIndicatorState();
}

class _CardMeterIndicatorState extends State<CardMeterIndicator> {
  double _meter = 0.0;

  @override
  void initState() {
    _meter = widget.cardMeter;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CardMeterIndicator oldWidget) {
    if (oldWidget.cardMeter != widget.cardMeter) {
      _meter = widget.cardMeter;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          widget.numBars,
          (index) => Container(
            width: widget.width,
            height: (widget.height - (widget.numBars * widget.padding)) /
                widget.numBars,
            decoration: BoxDecoration(
              color: (widget.numBars - (_meter * widget.numBars)) <= index
                  ? primaryColor
                  : lightColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
