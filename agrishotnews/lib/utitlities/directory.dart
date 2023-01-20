import 'package:agrishotnews/Screens/splashscreen.dart';
import 'package:agrishotnews/screens/bookmarkslist.dart';
import 'package:agrishotnews/screens/homescreen.dart';
import 'package:flutter/material.dart';

// We have all the routes listed here.

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.id:
      return MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      );
    case HomeScreen.id:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case BookMarkScreen.id:
      final deviceId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => BookMarkScreen(
          deviceId: deviceId,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Text('This page doesn\'t exist'),
        ),
      );
  }
}
