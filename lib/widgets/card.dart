import 'package:flutter/material.dart';
import 'package:mindmerge/constants/colours.dart';

class MindMergeCard extends StatelessWidget {
  final Color color;
  final int value;
  final double opacity;

  const MindMergeCard({
    this.value = 24,
    this.color = primaryColor,
    this.opacity = 1.0,
    Key? key,
  }) : super(key: key);

  Widget _buildCardText(double? fontSize) {
    return Text(
      '$value',
      style: TextStyle(
        fontFamily: 'BalooBhai',
        fontSize: fontSize ?? 18.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacity,
      child: Container(
          height: 150,
          width: 100,
          decoration: BoxDecoration(
            // color: color,
            borderRadius: BorderRadius.circular(20),
            gradient: const RadialGradient(
              colors: [
                Colors.white,
                primaryColor,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                offset: const Offset(
                  -3.0,
                  -3.0,
                ),
                blurRadius: 5.0,
                spreadRadius: 1.0,
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
                    _buildCardText(null),
                    _buildCardText(null),
                  ],
                ),
                Center(
                  child: Container(
                    child: _buildCardText(36),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCardText(null),
                    _buildCardText(null),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
