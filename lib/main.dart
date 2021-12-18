// import 'dart:html';

import 'package:flutter/material.dart';
import 'test_chat.dart';

void main() => runApp(const MyMaterial());

class MyMaterial extends StatelessWidget {
  const MyMaterial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chat(),
    );
  }
}
