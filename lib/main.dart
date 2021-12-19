import 'package:flutter/material.dart';
import 'package:mindmerge/constants/colours.dart';
import 'package:mindmerge/constants/routes.dart';
import 'package:mindmerge/screens/game.dart';
import 'screens/home.dart';

void main() => runApp(const MindMergeApp());

class MindMergeApp extends StatelessWidget {
  const MindMergeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mind Merge',
      home: const Home(),
      theme: ThemeData(
        primarySwatch: primaryColorSwatch,
        fontFamily: 'FuzzyBubbles',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: darkColor,
                fontSize: 15,
              ),
              bodyText2: const TextStyle(
                color: darkColor,
                fontSize: 15,
              ),
            ),
      ),
      initialRoute: Home.route,
      onGenerateRoute: generateRoute,
    );
  }
}
