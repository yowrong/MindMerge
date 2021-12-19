import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmerge/constants/GameArgs.dart';
import 'package:mindmerge/constants/colours.dart';
import 'package:mindmerge/models/player.dart';
import 'package:mindmerge/widgets/card.dart';
import 'package:mindmerge/widgets/card_meter_indicator.dart';
import 'package:mindmerge/widgets/game_other_player_status.dart';
import 'package:mindmerge/widgets/game_status_bar.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  final double dragThreshold = 0.1;

  List<Player> otherPlayers = [
    Player(id: '0', name: 'Cutie', cardsLeft: 4, starCard: 2, cardMeter: 0.9),
    Player(
        id: '1', name: 'Patootie', cardsLeft: 2, starCard: 69, cardMeter: 0.2),
    Player(id: '2', name: 'Pie', cardsLeft: 2, starCard: 23, cardMeter: 0.5)
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
                        ),
                        const Spacer(),
                        const MindMergeCard(),
                        const Spacer(),
                      ],
                    ),
                  ),
                  Draggable(
                    data: 10, // TODO: Change this to card number
                    child: MindMergeCard(),
                    feedback: MindMergeCard(color: Colors.green),
                    onDragUpdate: (details) {
                      final double halfwayPoint = screenHeight / 2;
                      final double offset = 1 -
                          (details.globalPosition.dy - halfwayPoint) /
                              (screenHeight - halfwayPoint);
                      setState(() => _cardMeter = offset);
                    },
                    onDragCompleted: () {
                      setState(() => _cardMeter = 0);
                    },
                    onDraggableCanceled: (_, __) {
                      setState(() => _cardMeter = 0);
                    },
                  ),
                ],
              ),
              DragTarget(
                onAccept: (card) {
                  // TODO: Send card to server
                  print("Sending card $card to server...");
                },
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return SizedBox(
                    height: screenHeight * 0.5,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.arrow_upward,
                          color: _cardMeter < 1.0
                              ? darkColor.withOpacity(0.5)
                              : darkColor,
                        ),
                        Text(
                          'Send to Pile',
                          style: TextStyle(
                            color: _cardMeter < 1.0
                                ? darkColor.withOpacity(0.5)
                                : darkColor,
                            fontWeight: _cardMeter < 1.0
                                ? FontWeight.normal
                                : FontWeight.bold,
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
