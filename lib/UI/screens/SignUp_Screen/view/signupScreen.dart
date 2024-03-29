import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rttv/UI/screens/SignUp_Screen/controller/signUpController.dart';
import 'package:rttv/UI/screens/SignUp_Screen/model/user_model.dart';
import 'package:rttv/UI/utility/Login_Screen/text_field.dart';
import 'package:rttv/resources/routes/routes_name.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/numbers.dart';
import 'package:rttv/utility/strings.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());

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
          decoration: const BoxDecoration(
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(forty),
                          child: Image.asset(
                            RTTVLOGO,
                            scale: eight,
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: thirty),
                                  child: TextFieldInput(
                                    textEditingController: signUpController
                                        .phoneNoController.value,
                                    hintText: PHONE_NUMBER,
                                    textInputType: TextInputType.emailAddress,
                                    hideText: false,
                                    onChange: (str) {
                                      signUpController.checkPhoneNumber();
                                    },
                                    leadingIcon: Icons.phone,
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
                                        signUpController.emailController.value,
                                    hintText: EMAIL,
                                    textInputType: TextInputType.emailAddress,
                                    hideText: false,
                                    onChange: (str) {
                                      signUpController.checkEmail();
                                    },
                                    leadingIcon: Icons.mail,
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
                                        signUpController.ageController.value,
                                    hintText: AGE,
                                    textInputType: TextInputType.number,
                                    hideText: false,
                                    onChange: (str) {
                                      signUpController.checkAge();
                                    },
                                    leadingIcon: Icons.person,
                                  ),
                                ),
                                const SizedBox(
                                  height: twentyfive,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: onehundredtwenty),
                                  child: GestureDetector(
                                    // Inside GestureDetector for Login button
                                    onTap: signUpController.isValid.value
                                        ? () async {
                                            signUpController.test();
                                            String phoneNo = "+91"+
                                                signUpController
                                                    .phoneNoController
                                                    .value
                                                    .text;
                                            PostResponseType result =
                                                await signUpController.signupApi(
                                                    UserModel(
                                                        phone_number:
                                                            phoneNo,
                                                        age: signUpController
                                                            .ageController
                                                            .value
                                                            .text,
                                                        email: signUpController
                                                            .emailController
                                                            .value
                                                            .text));

                                            if (result.postResponseEnum ==
                                                PostResponseEnum.success) {
                                              Get.snackbar(
                                                  SUCCESS, result.message,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                              print(signUpController
                                                  .phoneNoController
                                                  .value
                                                  .text);
                                              Get.toNamed(RouteName.otpScreen,
                                                  arguments: {
                                                    'phoneNumber':
                                                        phoneNo,
                                                  });
                                            } else {
                                              Get.snackbar(
                                                  ERROR, result.message,
                                                  snackPosition:
                                                      SnackPosition.BOTTOM);
                                            }
                                          }
                                        : () {},
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: one),
                                      decoration: ShapeDecoration(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(four),
                                            ),
                                          ),
                                          color: signUpController.isValid.value
                                              ? Colors.red
                                              : Colors.grey),
                                      child: Padding(
                                        padding: const EdgeInsets.all(eight),
                                        child: Text(
                                          SIGNUP,
                                          style: GoogleFonts.ptSerif(
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
                      ],
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
