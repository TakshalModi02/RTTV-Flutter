import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:rttv/resources/routes/routes_name.dart';

class SplashServices {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void isLogin() async {
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString("token");

    Timer(const Duration(seconds: 3), () {
      if (token == null) {
        _navigateToLogin();
      } else {
        _navigateToHome(token);
      }
    });
  }

  void _navigateToLogin() {
    Get.offAndToNamed(RouteName.loginScreen);
  }

  void _navigateToHome(String token) {
    Get.offAndToNamed(RouteName.homeScreen, arguments: {'token': token});
  }
}