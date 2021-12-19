import 'package:mindmerge/models/player.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameArguments {
  List<Player> listOfPlayers;
  List<Player> otherPlayers;
  IO.Socket socket;

  GameArguments({
    required this.listOfPlayers,
    required this.otherPlayers,
    required this.socket,
  });
}
