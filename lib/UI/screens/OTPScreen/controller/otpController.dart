import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rttv/UI/screens/OTPScreen/model/otpResponseModel.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/strings.dart';

class OtpController extends GetxController {
  Future<PostResponseType> verifyOTP(String phoneNumber, String otp) async {
    final url = Uri.parse('YOUR_VERIFICATION_URL');
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phoneNumber': phoneNumber,
          'otp': otp,
        }),
      );
      Map<String, dynamic> body = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      otpResponseModel responseModel = otpResponseModel(body);
      if(responseModel.code==1){
        return PostResponseType(postResponseEnum: PostResponseEnum.success, message: SignUpSuccess);
      }else{
        if(response.statusCode==400){
          return PostResponseType(postResponseEnum: PostResponseEnum.error, message: responseModel.message!);
        }else{
          return PostResponseType(postResponseEnum: PostResponseEnum.failed, message: responseModel.message!);
        }
      }
    } catch (error) {
      print(error);
      return PostResponseType(
          postResponseEnum: PostResponseEnum.failed, message: ERROR);
    }
  }
}
