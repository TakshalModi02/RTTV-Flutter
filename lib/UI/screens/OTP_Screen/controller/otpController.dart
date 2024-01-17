import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rttv/UI/screens/OTP_Screen/model/otpResponseModel.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/strings.dart';

class OtpController extends GetxController {
  Future<PostResponseType> verifyOTP(String phoneNumber, String? otp) async {
    final baseURL = dotenv.env['BASE_URL'];
    final url = Uri.parse(baseURL!+"verify/"+phoneNumber);
    try {
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'otp': otp
        }),
      );
      print(phoneNumber);
      print(url);
      print(response.body);
      Map<String, dynamic> body = jsonDecode(response.body);
      otpResponseModel responseModel = otpResponseModel(body);
      if(responseModel.code==1){
        return PostResponseType(postResponseEnum: PostResponseEnum.success, message: SignUpSuccess, data: responseModel.token!);
      }else{
        print("Error from otp controller::::");
        print(response.statusCode);
        print(response.body);
        if(response.statusCode==400){
          return PostResponseType(postResponseEnum: PostResponseEnum.error, message: responseModel.message!);
        }else{
          return PostResponseType(postResponseEnum: PostResponseEnum.failed, message: responseModel.message!);
        }
      }
    } catch (error) {
      print("Error from otp controller::::");
      print(error);
      return PostResponseType(
          postResponseEnum: PostResponseEnum.failed, message: ERROR);
    }
  }
}
