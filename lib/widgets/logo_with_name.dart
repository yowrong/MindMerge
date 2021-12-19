import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LogoWithName extends StatelessWidget {
  const LogoWithName({
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height ?? (screenHeight * 0.25),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/icons/logo.svg',
          ),
        ],
      ),
    );
  }
}
