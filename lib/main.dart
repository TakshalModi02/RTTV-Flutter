import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rttv/resources/routes/routes.dart';


void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: TextTheme(displaySmall: TextStyle(color: Colors.white),displayMedium:  TextStyle(color: Colors.white)),
          primarySwatch: Colors.brown,
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
          )
      ),
      // home: SplashScreen(),
      getPages: AppRoutes.appRoutes(),
    );
  }
}
