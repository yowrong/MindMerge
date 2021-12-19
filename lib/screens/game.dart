import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmerge/models/player.dart';
import 'package:mindmerge/widgets/game_other_player_status.dart';
import 'package:mindmerge/widgets/game_status_bar.dart';

class Game extends StatefulWidget {
  static const String route = '/game';

  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _level = 1;
  int _hearts = 4;
  int _stars = 3;
  int _numPlayersVotingStar = 2;
  List<Player> otherPlayers = [
    Player(id: "", name: 'Cutie', cardsLeft: 4, starCard: 2),
    Player(id: "", name: 'Patootie', cardsLeft: 2, starCard: 69),
    Player(id: "", name: 'Pie', cardsLeft: 2, starCard: 23)
  ];

  @override
  void initState() {
    // TODO: Add socket connection and map response to list of other players
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: GameStatusBar(
            level: _level,
            hearts: _hearts,
            stars: _stars,
            numPlayersVotingStar: _numPlayersVotingStar,
            onStarPressed: () {
              if (_stars > 0) {
                // TODO: Make a call to server toggling number of players voting for star
                // Then update stars / numPlayersVotingStar accordingly
              }
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: otherPlayers
                  .map((player) => OtherPlayerStatus(player: player))
                  .toList(),
            )
          ]),
        ),
      ),
    );
  }
}
