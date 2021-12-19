import 'package:mindmerge/models/player.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GameArguments {
  List<Player> listOfPlayers;
  List<Player> otherPlayers;
  List<int> cardsDealt;
  int lives;
  int stars;
  IO.Socket socket;

  GameArguments({
    required this.listOfPlayers,
    required this.otherPlayers,
    required this.socket,
    required this.cardsDealt,
    required this.lives,
    required this.stars,
  });
}
