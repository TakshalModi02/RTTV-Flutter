import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rttv/UI/screens/OTP_Screen/controller/otpController.dart';
import 'package:rttv/resources/routes/routes_name.dart';
import 'package:rttv/utility/PostResponse/PostResponseType.dart';
import 'package:rttv/utility/numbers.dart';
import 'package:rttv/utility/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_sms_retriever/android_sms_retriever.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>
    with SingleTickerProviderStateMixin {
  final OtpController otpController = Get.put(OtpController());
  late String? otp = '';
  final String phoneNumber = Get.arguments?['phoneNumber'] ?? '';
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
    _startSmsListener();
  }

  void _startSmsListener() async {
    try {
      AndroidSmsRetriever.getAppSignature().then((value) {
        setState(() {
          String _applicationSignature = value ?? 'Signature Not Found';
          print("App Signature : $_applicationSignature");
        });
      });

      AndroidSmsRetriever.listenForOneTimeConsent().then((value) async {
        setState(() {
          final intRegex = RegExp(r'\d+', multiLine: true);
          final code = intRegex
              .allMatches(value ?? 'Phone Number Not Found')
              .first
              .group(0);
          print(code);
          String _smsCode = code ?? '12345';
          otp = _smsCode;
        });
        await _handleOtpVerification();
      }).timeout(Duration(seconds: 30));
    } catch (e) {
      print('Error listening for SMS: $e');
    }
  }

  Future<void> _handleOtpVerification() async {
    if (otp != null && otp!.length == 6) {
      final SharedPreferences prefs = await _prefs;
      PostResponseType result =
          await otpController.verifyOTP(phoneNumber, otp!);
      if (result.postResponseEnum == PostResponseEnum.success) {
        bool tokenSaved = await prefs.setString("token", result.data!);
        if (tokenSaved) {
          Get.toNamed(RouteName.homeScreen, arguments: {'token': result.data});
        }
      } else {
        Get.snackbar(ERROR, result.message,
            snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          VERIFY_OTP,
          style: GoogleFonts.ptSerif(
            fontSize: twentyfive,
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/otp_image.jpg', // Replace with your image path
                  height: 350, // Adjust these factors as needed
                  width: 350, // Set width as per your requirement
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    onChanged: (code) {
                      otp = code;
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: twenty / 2,
                ),
                Text(ENTER_OTP),
                SizedBox(
                  height: twenty / 2,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(twenty),
              child: InkWell(
                child: GestureDetector(
                  onTap: _handleOtpVerification,
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
                      color: Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(eight),
                      child: Text(
                        SUBMIT_OTP,
                        style: GoogleFonts.ptSerif(
                          fontSize: twentyfive,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
