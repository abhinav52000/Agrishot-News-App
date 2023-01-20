import 'package:agrishotnews/Screens/splashscreen.dart';
import 'package:agrishotnews/utitlities/directory.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
          )),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.id,
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
