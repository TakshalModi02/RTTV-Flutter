import 'dart:ui';

import 'package:flag/flag.dart';
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    // Country Code
                                    Container(
                                      padding: const EdgeInsets.all(ten),
                                      child: const Text(
                                        '+91',
                                        style: TextStyle(fontSize: sixteen),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(eight),
                                      child: Flag.fromCode(
                                        FlagsCode.IN,
                                        height: twentyfive,
                                        width: twentyfive,
                                        fit: BoxFit.fill,
                                        flagSize: FlagSize.size_1x1,
                                        borderRadius: twentyfive,
                                      ),
                                    ),
                                    const SizedBox(width: four),
                                    Expanded(
                                      child: TextField(
                                        controller: loginController
                                            .phoneNoController.value,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => {
                                          loginController.checkPhoneNumber()
                                        },
                                        decoration: const InputDecoration(
                                          hintText: 'Enter phone number',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 0.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 0.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(12.0),
                                              bottomRight:
                                                  Radius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward,
                                        color: loginController.isValid.value?Color(0xFFcf321d):Colors.grey,
                                        size: 35,
                                      ),
                                      onPressed: loginController.isValid.value
                                          ? () async {
                                              loginController.test();
                                              String phoneNo = "+91" +
                                                  loginController
                                                      .phoneNoController
                                                      .value
                                                      .text;
                                              PostResponseType result =
                                                  await loginController
                                                      .loginApi(
                                                LoginModel(
                                                  phone_number: phoneNo
                                                ),
                                              );
                                              if (result.postResponseEnum ==
                                                  PostResponseEnum.success) {
                                                Get.snackbar(
                                                    SUCCESS, result.message,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM);
                                                Get.toNamed(RouteName.otpScreen,
                                                    arguments: {
                                                      'phoneNumber':
                                                          phoneNo
                                                    });
                                              } else {
                                                Get.snackbar(
                                                    ERROR, result.message,
                                                    snackPosition:
                                                        SnackPosition.BOTTOM);
                                              }
                                            }
                                          : () {},
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
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
