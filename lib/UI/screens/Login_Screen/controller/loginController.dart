import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:rttv/UI/screens/Login_Screen/model/loginResponseModel.dart';
import 'package:rttv/UI/screens/Login_Screen/model/loginModel.dart';
import 'package:http/http.dart' as http;
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/strings.dart';

class LoginController extends GetxController {
  final phoneNoController = TextEditingController().obs;
  final baseURL = dotenv.env['BASE_URL'];
  RxBool isValid = false.obs;

  bool validPhoneNo = false;

  Future<PostResponseType> loginApi(LoginModel user) async{
    final url = Uri.parse(baseURL! + "login");
    try{
      var res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(user.toJson()),
      );
      Map<String, dynamic> body = jsonDecode(res.body);
      print(body);
      print(res.statusCode);
      loginResponseModel responseModel = loginResponseModel(body);
      if(responseModel.code==1){
        return PostResponseType(postResponseEnum: PostResponseEnum.success, message: SignUpSuccess);
      }else{
        if(res.statusCode==400){
          return PostResponseType(postResponseEnum: PostResponseEnum.error, message: responseModel.message!);
        }else{
          return PostResponseType(postResponseEnum: PostResponseEnum.failed, message: responseModel.message!);
        }
      }
    }catch(err){
      print(err);
      return PostResponseType(postResponseEnum: PostResponseEnum.failed, message: CheckInternet);
    }
  }

  void test(){
    print("${baseURL}login");
  }

  void checkPhoneNumber() {
    String phoneNumber = "+91"+phoneNoController.value.text;
    print(phoneNumber);
    validPhoneNo = phoneNumber.length == 13 && phoneNumber.startsWith("+91");
    checkContraints();
  }


  void checkContraints(){
    if(validPhoneNo){
      isValid.value = true;
    }
  }
}
