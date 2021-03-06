import 'package:flutter/material.dart';
import 'package:mindmerge/constants/screen_args.dart';
import 'package:mindmerge/models/player.dart';
import 'package:mindmerge/screens/game.dart';
import 'package:mindmerge/screens/home.dart';
import 'package:mindmerge/screens/lobby.dart';
import 'package:mindmerge/constants/GameArgs.dart';

PageRoute _getPageRoute(
  Widget child, {
  bool fullScreenDialog = false,
}) {
  return MaterialPageRoute(
    builder: (context) => child,
    fullscreenDialog: fullScreenDialog,
  );
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Home.route:
      return _getPageRoute(const Home());
    case Lobby.route:
      final args = settings.arguments as LobbyArguments;
      return _getPageRoute(Lobby(args: args));
    case Game.route:
      final args = settings.arguments as GameArguments;
      return _getPageRoute(Game(args: args));
    default:
      break;
  }
}
