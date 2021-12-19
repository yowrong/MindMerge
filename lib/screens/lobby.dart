import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmerge/constants/GameArgs.dart';
import 'package:mindmerge/constants/screen_args.dart';
import 'package:mindmerge/models/player.dart';
import 'package:mindmerge/screens/game.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  List<Widget> generatePlayersInLobby(
      List<Player> listOfPlayers, double screenWidth, double screenHeight) {
    return listOfPlayers.asMap().entries.map((player) {
      int index = player.key;
      Player value = player.value;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20, bottom: 20, left: 20.0, right: 20.0),
            child: SvgPicture.asset("assets/icons/avatar$index.svg",
                width: screenWidth * 0.15, height: screenHeight * 0.15),
          ),
          Text(value.name),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    List<Player> listOfPlayers = widget.args.players;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Lobby code: ${widget.args.roomCode}',
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: SvgPicture.asset("assets/icons/logo.svg"),
                ),
              ),
              Expanded(
                flex: 6,
                child: GridView.count(
                    crossAxisCount: 2,
                    children: generatePlayersInLobby(
                        listOfPlayers, screenWidth, screenHeight)),
              ),
              ElevatedButton(
                onPressed: () {
                    Navigator.pushNamed(context, Game.route, arguments: GameArguments(
                        listOfPlayers: listOfPlayers,
                      ),);
                },
                child: Text('Start Playing Now'.toUpperCase()),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
