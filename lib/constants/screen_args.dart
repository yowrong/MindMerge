import 'package:mindmerge/models/player.dart';

class LobbyArguments {
  final String? roomCode;
  List<Player> players;

  LobbyArguments({
    required this.roomCode,
    required this.players,
  });
}
