import 'package:flutter/material.dart';
import 'package:mindmerge/screens/home.dart';

const String homeRoute = '/';

PageRoute _getPageRoute(
  Widget child, {
  bool fullScreenDialog = false,
}) {
  return MaterialPageRoute(
    builder: (context) => child,
    fullscreenDialog: fullScreenDialog,
  );
}

Route<dynamic>? generateRoute(settings) {
  switch (settings.name) {
    case homeRoute:
      _getPageRoute(Home());
      break;
    default:
      break;
  }
}
