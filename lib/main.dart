import 'package:flutter/material.dart';
import 'test_chat.dart';

void main() => runApp(const MindMergeApp());

class MindMergeApp extends StatelessWidget {
  const MindMergeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Chat(),
    );
  }
}
