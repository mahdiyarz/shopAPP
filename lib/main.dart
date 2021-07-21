import 'package:flutter/material.dart';

import './screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.grey,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => MainScreen(),
      },
    );
  }
}
