import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../utility/Login_Screen/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
            padding: const EdgeInsets.fromLTRB(12, 60, 12, 12),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg_image.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0,sigmaY: 10.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                child: Column(
                  children: [
                    Expanded(
                      flex: 15,
                      child: Container(
                        child: Column(
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(40.0),
                              child: Image.asset(
                                'assets/rttv_logo.png',
                                scale: 8,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: TextFieldInput(_emailController, 'Enter Email',
                                  TextInputType.emailAddress, false),
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: TextFieldInput(
                                  _passwordController,
                                  'Enter Password',
                                  TextInputType.visiblePassword,
                                  true),
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 120),
                              child: GestureDetector(
                                onTap: (){}, //Call Login function
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(vertical: 1),
                                  decoration: const ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      color: Colors.red),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Row(
                                children: [
                                  const Text(
                                    'New User?',
                                    style: TextStyle(fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      //Navigate to SignUp page
                                    },
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Contact us',
                                  style: TextStyle(fontSize: 5,color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(fontSize: 5,color: Colors.white),
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
          )),
    );
  }
}
