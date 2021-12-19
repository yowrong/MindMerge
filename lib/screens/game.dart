import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mindmerge/constants/GameArgs.dart';
import 'package:mindmerge/constants/colours.dart';
import 'package:mindmerge/models/player.dart';
import 'package:mindmerge/widgets/card.dart';
import 'package:mindmerge/widgets/card_meter_indicator.dart';
import 'package:mindmerge/widgets/game_other_player_status.dart';
import 'package:mindmerge/widgets/game_status_bar.dart';
import 'package:playing_cards/playing_cards.dart';
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
  late List<Player> listOfPlayers;
  late List<Player> otherPlayers;
  bool _isAboutToSendCard = false;
  List<int> cards = [8, 7, 6, 5, 4, 3, 2, 1];
  int cardValueOnTop = 0;

  @override
  void initState() {
    listOfPlayers = widget.args.listOfPlayers;
    otherPlayers = widget.args.otherPlayers;
    cards = widget.args.cardsDealt;

    widget.args.socket.on("playCard", (data) {
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

      List<int> cardsDealt = data['self']['cards']
          .map<int>((card) => card as int)
          .toList() as List<int>;

      // print('cardsDealt to player: $cardsDealt\n');
    });
    // TODO: Add socket connection and map response to list of other players
    super.initState();
  }

  void playCard(int card) {
    widget.args.socket.emit(
      "playCard",
      card,
    );
  }

  List<Widget> cardsInHand(
      List<int> cards, double screenWidth, double screenHeight) {
    return cards.map((card) {
      return Draggable(
        data: card, // TODO: Change this to card number
        child: MindMergeCard(
          cardNumber: card,
        ),
        feedback: MindMergeCard(cardNumber: card, color: Colors.green),
        onDragUpdate: (details) {
          final double halfwayPoint = screenHeight / 2;
          final double offset = 1.75 -
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
      );
    }).toList();
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: otherPlayers
                        .map((player) => OtherPlayerStatus(player: player))
                        .toList(),
                  ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CardMeterIndicator(
                      cardMeter: _cardMeter,
                      width: 30,
                      height: 200,
                      padding: 5,
                      numBars: 20,
                    ),
                  ),
                  const Spacer(),
                  if (cards.isNotEmpty && cards.length > 1)
                    FlatCardFan(
                      children: cardsInHand(cards, screenHeight, screenWidth),
                    ),
                  if (cards.isNotEmpty && cards.length == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: cardsInHand(
                        cards,
                        screenWidth,
                        screenHeight,
                      ),
                    )
                ],
              ),
              DragTarget(
                onAccept: (card) {
                  playCard(card as int);
                  print("Sending card $card to server...");
                  setState(() {
                    int cardValue = cards.removeLast();
                    cardValueOnTop = cardValue;
                  });
                },
                builder: (
                  BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
                ) {
                  return SizedBox(
                    height: screenHeight * 0.7,
                    width: screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Opacity(
                          opacity: _isAboutToSendCard ? 0.5 : 1.0,
                          child: MindMergeCard(
                            cardNumber: cardValueOnTop,
                          ),
                        ),
                        const SizedBox(height: 50),
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
