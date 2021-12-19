import 'package:flutter/material.dart';
import 'package:mindmerge/constants/screen_args.dart';

class Lobby extends StatefulWidget {
  static const String route = '/lobby';
  final LobbyArguments args;

  const Lobby({
    required this.args,
    Key? key,
  }) : super(key: key);

  @override
  _LobbyState createState() => _LobbyState();
}

class _LobbyState extends State<Lobby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Room Code: ${widget.args.roomCode}',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Text(
          'This is the lobby',
        ),
      ),
    );
  }
}
