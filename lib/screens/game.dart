import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmerge/constants/GameArgs.dart';
import 'package:mindmerge/constants/colours.dart';
import 'package:mindmerge/models/player.dart';
import 'package:mindmerge/widgets/card_meter_indicator.dart';
import 'package:mindmerge/widgets/game_other_player_status.dart';
import 'package:mindmerge/widgets/game_status_bar.dart';

class Game extends StatefulWidget {
  static const String route = '/game';
  final GameArguments args;

  const Game({required this.args, Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _level = 1;
  int _hearts = 4;
  int _stars = 3;
  int _numPlayersVotingStar = 2;
  double _cardMeter = 0;

  List<Player> otherPlayers = [
    Player(id: '', name: 'Cutie', cardsLeft: 4, starCard: 2, cardMeter: 0.9),
    Player(
        id: '', name: 'Patootie', cardsLeft: 2, starCard: 69, cardMeter: 0.2),
    Player(id: '', name: 'Pie', cardsLeft: 2, starCard: 23, cardMeter: 0.5)
  ];

  @override
  void initState() {
    // TODO: Add socket connection and map response to list of other players
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Stack(
            children: [
              Column(
                children: [
                  GameStatusBar(
                    level: _level,
                    hearts: _hearts,
                    stars: _stars,
                    numPlayersVotingStar: _numPlayersVotingStar,
                    onStarPressed: () {
                      if (_stars > 0) {
                        // TODO: Make a call to server toggling number of players voting for star
                        // Then update stars / numPlayersVotingStar accordingly
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: otherPlayers
                        .map((player) => OtherPlayerStatus(player: player))
                        .toList(),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        CardMeterIndicator(
                          cardMeter: _cardMeter,
                          width: 30,
                          height: 200,
                          padding: 5,
                          numBars: 20,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              DragTarget(
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return Container(
                    height: screenHeight * 0.5,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.2),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: darkColor.withOpacity(0.5),
                        ),
                        Text(
                          'Send to Pile',
                          style: TextStyle(
                            color: darkColor.withOpacity(0.5),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
