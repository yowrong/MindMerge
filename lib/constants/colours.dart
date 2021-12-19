import 'package:flutter/material.dart';

/// $primary:         #83C3A3;
/// $light:           #D4DDD6;
/// $dark:            #1E242E;

const Color primaryColor = Color.fromARGB(255, 131, 195, 163);
const Color secondaryColor = Color.fromARGB(255, 212, 221, 214);
const Color lightColor = Color.fromARGB(255, 212, 221, 214);
const Color darkColor = Color.fromARGB(255, 30, 36, 46);

final MaterialColor primaryColorSwatch = MaterialColor(
  primaryColor.value,
  const <int, Color>{
    50: secondaryColor,
    100: secondaryColor,
    200: secondaryColor,
    300: secondaryColor,
    400: secondaryColor,
    500: secondaryColor,
    600: secondaryColor,
    700: secondaryColor,
    800: secondaryColor,
    900: secondaryColor,
  },
);
