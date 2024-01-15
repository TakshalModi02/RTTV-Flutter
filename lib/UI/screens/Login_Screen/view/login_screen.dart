import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rttv/UI/screens/Login_Screen/controller/loginController.dart';
import 'package:rttv/UI/screens/Login_Screen/model/loginModel.dart';
import 'package:rttv/resources/routes/routes_name.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/numbers.dart';
import 'package:rttv/utility/strings.dart';

import '../../../utility/Login_Screen/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  bool _isLoading = false;

  showSnackBar(BuildContext context, String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(twelve, sixty, twelve, twelve),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(BGIMAGE),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: ten, sigmaY: ten),
            child: Container(
              decoration: BoxDecoration(color: Colors.white.withOpacity(zero)),
              child: Column(
                children: [
                  Expanded(
                    flex: 15,
                    child: Container(
                      child: Obx(
                        () => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(forty),
                              child: Image.asset(
                                RTTVLOGO,
                                scale: eight,
                              ),
                            ),
                            const SizedBox(
                              height: eighteen,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: thirty),
                              child: TextFieldInput(
                                textEditingController:
                                    loginController.phoneNoController.value,
                                hintText: PHONE_NUMBER,
                                textInputType: TextInputType.emailAddress,
                                hideText: false,
                                onChange: (str) {
                                  loginController.checkPhoneNumber();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: onehundredtwenty),
                              child: GestureDetector(
                                onTap: loginController.isValid.value
                                    ? () async {
                                        loginController.test();
                                        PostResponseType result =
                                            await loginController.loginApi(
                                          LoginModel(
                                            phone_number: loginController
                                                .phoneNoController.value.text,
                                          ),
                                        );
                                        if (result.postResponseEnum ==
                                            PostResponseEnum.success) {
                                          Get.snackbar(SUCCESS, result.message,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                          Get.toNamed(RouteName.otpScreen,
                                              arguments: {
                                                'phoneNumber': loginController
                                                    .phoneNoController
                                                    .value
                                                    .text
                                              });
                                        } else {
                                          Get.snackbar(ERROR, result.message,
                                              snackPosition:
                                                  SnackPosition.BOTTOM);
                                        }
                                      }
                                    : () {},
                                child: Container(
                                  width: double.infinity,
                                  height: 70, // Adjust the height as needed
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: loginController.isValid.value
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(eight),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: thirty,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: forty,
                            ),
                            FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Row(
                                children: [
                                  Text(
                                    NEWUSER,
                                    style: GoogleFonts.ptSerif(
                                        fontSize: twenty, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: ten,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteName.signUpScreen);
                                    },
                                    child: Text(
                                      SIGNUP,
                                      style: GoogleFonts.ptSerif(
                                          fontWeight: FontWeight.bold,
                                          fontSize: twenty,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(ten, zero, ten, zero),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                CONTACTUS,
                                style: GoogleFonts.ptSerif(
                                    fontSize: five, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: forty,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                PRIVACYPOLICY,
                                style: GoogleFonts.ptSerif(
                                    fontSize: five, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
