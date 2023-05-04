import 'package:flutter/material.dart';
//-------------------------------------

/// This class contains all colors used on original apps.
class Palette {
  static const Color charcoal = Color(0xff3e3e3e);
  static const Color bigStone = Color(0xff323B44);
  static const Color fireBrick = Color(0xffa41212);
  static const Color shuttleGray = Color(0xff59626b);
  static const Color dimGray = Color(0xff707070);
  static const Color kellyGreen = Color(0xff1daa0d);
  static const Color mantis = Color(0xff76b952);
  static const Color burntSienna = Color(0xffee504f);
  static const Color bittersweet = Color(0xffff6565);
  static const Color melon = Color(0xffffadac);
  static const Color darkTangerine = Color(0xffffa70e);
  static const Color mustard = Color(0xffffd554);
  static const Color sundown = Color(0xfff6a7a6);
  static const Color summerSky = Color(0xff178eea);
  static const Color spunPearl = Color(0xffa6a6a8);
  static const Color mistyRose = Color(0xffffe8e8);
  static const Color chablis = Color(0xfffeeded);
  static const Color carouselPink = Color(0xfff8dada);
  static const Color gainsboro = Color(0xffd8d8d8);
  static const Color linkWater = Color(0xffced7e0);
  static const Color cinderella = Color(0xfffcdcdc);
  static const Color floralWhite = Color(0xfffff9E9);
  static const Color aquaSpring = Color(0xffedf5eb);
  static const Color panache = Color(0xfff3f9ef);
  static const Color desertStorm = Color(0xfffbfbfa);
  static const Color whiteSmoke = Color(0xfff5f5f5);
  static const Color solitude = Color(0xffeff3f6);
  static const Color pattensBlue = Color(0xfff3f7fa);
  static const Color snow = Color(0xfffff8f8);

  /// this getter convert the primary color to a usable [MaterialColor].
  static MaterialColor get primarySwatch {
    return MaterialColor(Palette.burntSienna.value, {
      50: burntSienna.withOpacity(0.1),
      100: burntSienna.withOpacity(0.2),
      200: burntSienna.withOpacity(0.3),
      300: burntSienna.withOpacity(0.4),
      400: burntSienna.withOpacity(0.5),
      500: burntSienna.withOpacity(0.6),
      600: burntSienna.withOpacity(0.7),
      700: burntSienna.withOpacity(0.8),
      800: burntSienna.withOpacity(0.9),
      900: burntSienna,
    });
  }

  /// material ripple color that is used in all buttons.
  static Color get overlayColor => shuttleGray.withOpacity(0.25);

  /// list of dark colors used on user chat card background.
  static List<MaterialColor> darkColors = <MaterialColor>[
    Colors.red,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey,
  ];
}
