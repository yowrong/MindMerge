import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmerge/constants/GameArgs.dart';
import 'package:mindmerge/constants/screen_args.dart';
import 'package:mindmerge/models/player.dart';
import 'package:mindmerge/screens/game.dart';

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
  late List<Player> listOfPlayers;
  late List<Player> otherPlayers;

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
  void initState() {
    listOfPlayers = widget.args.players;
    widget.args.socket.on("newPlayer", (data) {
      print(data);

      List<Player> players = data['players'].map<Player>((player) {
        return Player(
          id: player['id'],
          name: player['username'],
          cardsLeft: 0,
        );
      }).toList() as List<Player>;
      setState(() {
        listOfPlayers = players;
      });
    });

    widget.args.socket.on("createOtherPlayers", (data) {
      print(data);
      List<Player> players = data['players'].map<Player>((player) {
        List<int> cardsDealt = player['cards']
            .map<int>((card) => card as int)
            .toList() as List<int>;

        return Player(
          id: player['id'],
          name: player['username'],
          cardsLeft: cardsDealt.length,
        );
      }).toList() as List<Player>;

      setState(() {
        otherPlayers = players;
      });

      List<int> cardsDealt = data['self'][0]['cards']
          .map<int>((card) => card as int)
          .toList() as List<int>;

      Navigator.pushNamed(
        context,
        Game.route,
        arguments: GameArguments(
          listOfPlayers: listOfPlayers,
          otherPlayers: otherPlayers,
          socket: widget.args.socket,
          cardsDealt: cardsDealt,
          lives: data['lives'] as int,
          stars: data['stars'] as int,
        ),
      );
    });
    super.initState();
  }

  void createOtherPlayers() {
    widget.args.socket.emit(
      "createOtherPlayers",
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

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
                  createOtherPlayers();
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
