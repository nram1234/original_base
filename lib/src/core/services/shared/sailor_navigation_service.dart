import 'package:flutter/material.dart';
//-------------------------------------

/// global variable to access sailor which is a navigation service
/// that controls routes easily and without the need of passing contexts.
// ignore: non_constant_identifier_names
final Sailor = _SailorImpl();

// prevents sailor implementation to be accessed from outside this file.
class _SailorImpl {
  /// global key which controls navigation state.
  final _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}

extension navigationMethods on _SailorImpl {
  /// use "toNamed" instead of Navigator.pushNamed method.
  Future<dynamic> toNamed(String routeName, {Map args = const {}}) {
    return _navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  /// use "to" instead of Navigator.push method.
  Future<dynamic> to(Widget newPage) {
    return _navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (_) => newPage),
    );
  }

  /// use "replaceNamed" instead of Navigator.pushReplacementNamed method.
  Future<dynamic> replaceNamed(String routeName) {
    return _navigatorKey.currentState!.pushReplacementNamed(routeName);
  }

  /// use "startOverFrom" instead of Navigator.pushNamedAndRemoveUntil method.
  Future<dynamic> startOverFrom(String routeName) {
    return _navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (_) => false,
    );
  }

  /// use "back" instead of Navigator.pop method.
  void back([dynamic result]) {
    return _navigatorKey.currentState!.pop(result);
  }
}
