import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:rttv/resources/routes/routes_name.dart';

class SplashServices {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void isLogin() async{
    // Timer(const Duration(seconds: 3), () => Get.toNamed(RouteName.loginScreen));
    final SharedPreferences prefs = await _prefs;
    String? token = prefs.getString("token");
    Timer(const Duration(seconds: 3), (){
      if(token==null){
      Get.toNamed(RouteName.loginScreen);
    }else{
      Get.toNamed(RouteName.homeScreen, arguments: {'token':token});
    }
    });
  }
}
