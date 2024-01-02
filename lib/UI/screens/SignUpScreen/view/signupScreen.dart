import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rttv/UI/screens/SignUpScreen/controller/signUpController.dart';
import 'package:rttv/UI/utility/Login_Screen/text_field.dart';
import 'package:rttv/utility/numbers.dart';
import 'package:rttv/utility/strings.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.put(SignUpController());
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(forty),
                            child: Image.asset(
                              RTTVLOGO,
                              scale: eight,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: thirty),
                            child: TextFieldInput(
                                signUpController.emailController.value,
                                EMAIL,
                                TextInputType.emailAddress,
                                false),
                          ),
                          const SizedBox(
                            height: eighteen,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: thirty),
                            child: TextFieldInput(
                                signUpController.passwordController.value,
                                PASSWORD,
                                TextInputType.visiblePassword,
                                true),
                          ),
                          const SizedBox(
                            height: eighteen,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: thirty),
                            child: TextFieldInput(
                                signUpController
                                    .confirmpasswordController.value,
                                CONFIRM_PASSWORD,
                                TextInputType.visiblePassword,
                                true),
                          ),
                          const SizedBox(
                            height: thirtysix,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: onehundredtwenty),
                            child: GestureDetector(
                              // Inside GestureDetector for Login button
                              onTap: () {
                                signUpController.signupApi(
                                  signUpController.emailController.value.text,
                                  signUpController
                                      .passwordController.value.text,
                                  signUpController
                                      .confirmpasswordController.value.text,
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                alignment: Alignment.center,
                                padding:
                                    const EdgeInsets.symmetric(vertical: one),
                                decoration: const ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(four),
                                      ),
                                    ),
                                    color: Colors.red),
                                child: const Padding(
                                  padding: EdgeInsets.all(eight),
                                  child: Text(
                                    SIGNUP,
                                    style: TextStyle(
                                        fontSize: twentyfive,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: forty,
                          ),
                        ],
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
                              child: const Text(
                                CONTACTUS,
                                style: TextStyle(
                                    fontSize: five, color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              width: forty,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                PRIVACYPOLICY,
                                style: TextStyle(
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
