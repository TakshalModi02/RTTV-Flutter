import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:rttv/UI/screens/OTPScreen/controller/otpController.dart';
import 'package:rttv/resources/routes/routes_name.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/numbers.dart';
import 'package:rttv/utility/strings.dart';

class otpScreen extends StatefulWidget {
  final String phoneNumber;
  const otpScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  final OtpController otpController = Get.put(OtpController());
  late String otp = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          VERIFY_OTP,
          style: TextStyle(
              fontSize: twentyfive,
              color: Colors.black,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                        'assets/otp_image.jpg', // Replace with your image path
                        height: 410, // Adjust these factors as needed
                        width: 350 // Set width as per your requirement
                        ),
                    OtpTextField(
                      numberOfFields: 4,
                      fieldWidth: sixty,
                      borderColor: Colors.red,
                      showFieldAsBox: true,
                      onCodeChanged: (code) {
                        otp = code;
                      },
                      onSubmit: (code) {
                        otpController.verifyOTP(widget.phoneNumber, otp);
                      },
                    ),
                    SizedBox(
                      height: twenty,
                    ),
                    Text(ENTER_OTP),
                    SizedBox(
                      height: twenty,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(twenty),
                child: InkWell(
                  child: GestureDetector(
                    onTap: () async {
                      PostResponseType result =
                          await otpController.verifyOTP(widget.phoneNumber, otp);
                      if (result.postResponseEnum == PostResponseEnum.success) {
                        Get.toNamed(RouteName.homeScreen);
                      } else {
                        Get.snackbar(ERROR, result.message,
                            snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: one),
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
                          SUBMIT_OTP,
                          style: TextStyle(
                              fontSize: twentyfive,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
