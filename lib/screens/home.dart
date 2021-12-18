import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindmerge/constants/colours.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 90,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/icons/logo.svg',
                  height: screenHeight * 0.2,
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontFamily: 'FuzzyBubbles',
                    fontSize: 48,
                    color: darkColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'Mind',
                    ),
                    TextSpan(
                      text: 'Merge',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                'Team 37 + Kevin'.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'BalooBhai',
                ),
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth * 0.75,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter Your Name'.toUpperCase(),
                    labelStyle: const TextStyle(
                      fontFamily: 'BalooBhai',
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: screenWidth * 0.75,
                child: InkWell(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Start'.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: 'BalooBhai',
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
