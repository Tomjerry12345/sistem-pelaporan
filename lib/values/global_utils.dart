import 'package:flutter/material.dart';

class GlobalContext { 
  static GlobalKey<NavigatorState> navigatorKey = 
  GlobalKey<NavigatorState>();

  static GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
}

BuildContext ctx = GlobalContext.navigatorKey.currentContext!;