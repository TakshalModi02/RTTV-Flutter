import 'package:get/get.dart';
import 'package:rttv/UI/screens/Login%20Screen/view/login_screen.dart';
import 'package:rttv/UI/screens/OTPScreen/controller/otpController.dart';
import 'package:rttv/UI/screens/OTPScreen/view/otpScreen.dart';
import 'package:rttv/UI/screens/SignUpScreen/view/signupScreen.dart';
import 'package:rttv/UI/screens/splashScreen/splashScreen.dart';
import 'package:rttv/resources/routes/routes_name.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => splashScreen(),
    ),
    GetPage(
      name: RouteName.loginScreen,
      page: () => LoginPage(),
    ),
    GetPage(
      name: RouteName.signUpScreen,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: RouteName.otpScreen,
      page: () => otpScreen(phoneNumber: '',),
      binding: BindingsBuilder(() {
        Get.put(OtpController()); 
      }),
    ),
  ];
}
