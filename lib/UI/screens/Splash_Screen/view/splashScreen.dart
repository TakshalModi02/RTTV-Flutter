import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rttv/UI/screens/Splash_Screen/controller/splashServices.dart';
import 'package:rttv/utility/strings.dart';
import 'dart:ui';
import 'package:rttv/utility/numbers.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    super.initState();
    splashServices.isLogin();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(BGIMAGE),
              fit: BoxFit.cover,
            ),
          ),
        child: BackdropFilter(filter:ImageFilter.blur(sigmaX: ten, sigmaY: ten),
          child: Center(
            child: Hero(
              child: Image.asset(
                'assets/rttv_logo.png',
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
            tag: 'logo',
            )
          ),
        )
      )
    );
  }
}
