import 'package:flutter/material.dart';
import 'package:mindmerge/screens/home.dart';

class GameFailed extends StatelessWidget {
  const GameFailed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Text("Game Over"),
        content: const Text('Better Luck Next Time :('),
        actions: <Widget>[
          TextButton(
            child: const Text('Play Again'),
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName(Home.route));
            },
          ),
        ],
      ),
    );
  }
}
