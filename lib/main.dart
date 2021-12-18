// import 'dart:html';

import 'package:flutter/material.dart';
import './test-chat.dart';

void main() => runApp(MyMaterial());

class MyMaterial extends StatelessWidget {
  const MyMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chat(),
    );
  }
}
