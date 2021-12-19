import 'package:mindmerge/models/player.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LobbyArguments {
  final String? roomCode;
  List<Player> players;
  IO.Socket socket;

  LobbyArguments({
    required this.roomCode,
    required this.players,
    required this.socket,
  });
}
