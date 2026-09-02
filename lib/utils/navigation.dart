import 'package:flutter/material.dart';

class Nav {
  Nav._();
  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static BuildContext get context => key.currentState!.context;

  static back([result]) => Navigator.pop(key.currentState!.context, result);

  // static to(Widget page) => Navigator.push(
  //     key.currentState!.context,
  //     MaterialPageRoute(
  //       builder: (context) => page,
  //     ));

  // static off(Widget page) => Navigator.pushReplacement(
  //     key.currentState!.context,
  //     MaterialPageRoute(
  //       builder: (context) => page,
  //     ));

  // static offAll(Widget page, [BuildContext? context]) {
  //   final effectiveContext = context ?? key.currentState?.context;
  //   if (effectiveContext != null && Navigator.canPop(effectiveContext)) {
  //     Navigator.pushAndRemoveUntil(
  //       effectiveContext,
  //       MaterialPageRoute(builder: (context) => page),
  //       (Route<dynamic> route) => false,
  //     );
  //   } else {
  //     off(page);
  //     // debugLog("Navigation context is invalid or no routes in the stack.");
  //   }
  // }
}
