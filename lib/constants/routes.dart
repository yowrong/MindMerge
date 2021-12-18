import 'package:flutter/material.dart';
import 'package:mindmerge/screens/home.dart';
import 'package:mindmerge/screens/lobby.dart';

const String homeRoute = '/';
const String lobbyRoute = '/lobby';

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
    case homeRoute:
      return _getPageRoute(const Home());
    case lobbyRoute:
      return _getPageRoute(const Lobby());
    default:
      break;
  }
}
