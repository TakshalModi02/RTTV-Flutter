import 'package:get/get.dart';

class OtpController extends GetxController{
  Future<bool> verifyOTP(String otp) async {
    // Replace this with your actual API call logic
    // For demonstration, return a simulated result (true/false)
    await Future.delayed(Duration(seconds: 2));
    return otp == '1234'; // Simulated verification result
  }
}