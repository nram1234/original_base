import 'dart:math';
//-----------------
import 'package:flutter/material.dart';
//-------------------------------------

class ResponsiveLayout {
  static late ResponsiveLayout _instance;

  /// Size of the phone in UI Design, dp.
  late Size uiSize;

  late double _pixelRatio;
  late double _textScaleFactor;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;

  ResponsiveLayout._();

  factory ResponsiveLayout() => _instance;

  static void init(
    BoxConstraints constraints, {
    required Size designSize,
  }) {
    _instance = ResponsiveLayout._()
      ..uiSize = designSize
      .._screenWidth = constraints.maxWidth
      .._screenHeight = constraints.maxHeight;

    var window = WidgetsBinding.instance.window;
    _instance._pixelRatio = window.devicePixelRatio;
    _instance._statusBarHeight = window.padding.top;
    _instance._bottomBarHeight = window.padding.bottom;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  /// The number of font pixels for each logical pixel.
  double get textScaleFactor => _textScaleFactor;

  /// The size of the media in logical pixels (e.g, the size of the screen).
  double get pixelRatio => _pixelRatio;

  /// The horizontal extent of this size.
  double get screenWidth => _screenWidth;

  /// The vertical extent of this size. dp
  double get screenHeight => _screenHeight;

  /// The offset from the top, in dp.
  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  /// The offset from the bottom, in dp.
  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  /// The ratio of actual width to UI design.
  double get scaleWidth => _screenWidth / uiSize.width;

  /// The ratio of actual height to UI design.
  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation,
  /// if you want a square.
  double setWidth(num width) => width * scaleWidth;

  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  /// Adapt according to the smaller of width or height.
  double radius(num r) => r * scaleText;

  /// Font size adaptation method
  ///- [fontSize] The size of the font on the UI design, in dp.
  double setSp(num fontSize) => fontSize * scaleText;
}
