import 'package:flutter/material.dart';

import 'UI/screens/Login Screen/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(displaySmall: TextStyle(color: Colors.white),displayMedium:  TextStyle(color: Colors.white)),
          primarySwatch: Colors.brown,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
          )
      ),
      home: LoginPage(),

    );
  }
}
