import 'package:get/get.dart';
import 'package:rttv/UI/screens/Home_Screen/view/homeScreen.dart';
import 'package:rttv/UI/screens/Login_Screen/view/login_screen.dart';
import 'package:rttv/UI/screens/OTP_Screen/controller/otpController.dart';
import 'package:rttv/UI/screens/OTP_Screen/view/otpScreen.dart';
import 'package:rttv/UI/screens/SignUp_Screen/view/signupScreen.dart';
import 'package:rttv/UI/screens/Splash_Screen/view/splashScreen.dart';
import 'package:rttv/resources/routes/routes_name.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: RouteName.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RouteName.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: RouteName.otpScreen,
      page: () => OtpScreen(),
      binding: BindingsBuilder(() {
        Get.put(OtpController()); 
      }),
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.put(OtpController()); 
      }),
    ),
  ];
}
