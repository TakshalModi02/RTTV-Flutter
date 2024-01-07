import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:rttv/UI/screens/SignUpScreen/model/signup_response_model.dart';
import 'package:rttv/UI/screens/SignUpScreen/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/strings.dart';

class SignUpController extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmpasswordController = TextEditingController().obs;
  final ageController = TextEditingController().obs;
  final phoneNoController = TextEditingController().obs;
  final baseURL = dotenv.env['BASE_URL'];
  RxBool isValid = false.obs;

  bool validEmail = false;
  bool validPhoneNo = false;
  bool validAge = false;
  bool validPassword = false;

  Future<PostResponseType> signupApi(UserModel user) async{
    final url = Uri.parse(baseURL! + "signup");
    print(user.toJson());
    try{
      var res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json'
        },
        body: jsonEncode(user.toJson()),
      );
      Map<String, dynamic> body = jsonDecode(res.body);
      print(res.statusCode);
      print(res.body);
      SignUpResponseModel responseModel = SignUpResponseModel(body);
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
    print("${baseURL}signup");
  }

  void checkEmail(){
    validEmail = EmailValidator.validate(emailController.value.text);
    checkContraints();
  }

  void checkPhoneNumber() {
    String phoneNumber = phoneNoController.value.text;
    validPhoneNo = phoneNumber.length == 13 && phoneNumber.startsWith("+91");
    checkContraints();
  }

  void checkAge() {
    String age = ageController.value.text;
    double number = double.parse(age);
    validAge = number >= 0 && number > 5;
    checkContraints();
  }

  void checkPassword(){
    String password = passwordController.value.text;
    String confirmPassword = confirmpasswordController.value.text;

    if(password!="" && password==confirmPassword){
      validPassword = true;
    }
    checkContraints();
  }

  void checkContraints(){
    if(validEmail && validPhoneNo && validAge && validPassword){
      isValid.value = true;
    }
  }
}
