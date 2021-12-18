import 'package:flutter/material.dart';

class Lobby extends StatefulWidget {
  static const String route = '/lobby';

  const Lobby({Key? key}) : super(key: key);

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text(
          'This is the lobby',
        ),
      ),
    );
  }
}
