import 'dart:convert';
import 'package:asmaa_demo_cadeau/models/shared_pref.dart';
import 'package:asmaa_demo_cadeau/provider/varification_code_provider.dart';
import 'package:http/http.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import 'package:asmaa_demo_cadeau/constants/global_api_variables.dart';
import 'package:asmaa_demo_cadeau/functions/get_device_info.dart';
import 'package:asmaa_demo_cadeau/functions/show_dialog.dart';
import 'package:asmaa_demo_cadeau/provider/password_scenario_provider.dart';
import 'package:asmaa_demo_cadeau/screens/password_scenario/set_new_password_screen.dart';
import 'package:asmaa_demo_cadeau/widgets/flat_button.dart';
import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/screens/password_scenario/forget_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key, required this.resendCode});
  final void Function({required BuildContext context}) resendCode;
  @override
  State<VerificationCodeScreen> createState() {
    return _VerificationCodeScreenState();
  }
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  var code6Digits = '000000';
  late ResetScenarioState resetState;
  late VarificationCodeProviderState verificationState;

  @override
  void initState() {
    super.initState();
    resetState = context.read<ResetScenarioState>();
    verificationState = context.read<VarificationCodeProviderState>();
  }

  void onPressBack() {
    verificationState.updateBoolfirstOnComplete(false);
    verificationState.updateBoolsecondOnComplete(false);
    verificationState.updateBoolfirstOnEditing(true);
    verificationState.updateBoolsecondOnEditing(true);
    verificationState.updateBoolisFilled(false);
    verificationState.updateBoolisSending(false);

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
  }

  void _submit() async {
    var resetedPhone = resetState.resetedPhone;
    var resetedCountryCode = resetState.resetedCountryCode;
    var varificationCode = resetState.verificationCode;
    determineTimeZone();
    determineLanguage();

    final url = Uri.parse(
        '$kBaseURL/$kVersion/auth/passwords/${kQueryParameters['user_type']}/verify_otp');
    debugPrint(url.toString());

    try {
      Response response = await post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept-Language': kMostFavouriteUserLanguage,
            'Timezone': kTimeZone,
          },
          body: json.encode({
            "verification_code": varificationCode,
            "user": {
              "country_code": resetedCountryCode,
              "phone_number": resetedPhone,
            },
          }));

      if (response.statusCode == 200) {
        debugPrint('Account Detected Successfully');
        debugPrint(response.body);

        // //save the phone in a provider for using in the comming steps
        final Map<String, dynamic> resultData = json.decode(response.body);

        await SharedPref.setString(resultData['data']['token']);

        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }

        SharedPref.getString().then((value) {
          resetState.updateResetedToken(value);
        });

        //reset the form or make it empty again
        resetState.updateVerificationCode("000000");

        //don't delete token from instantanous ROM & don't delete it from preferances memory on the user's device in case we needed it again temporary
        //if the user uses the verification code screen again he/she will overWrite the device currrent token as expected in4a2 Allah
        verificationState.updateBoolisFilled(false);
        verificationState.updateBoolisSending(false);

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SetNewPasswardScreen(
                  resendCode: widget.resendCode,
                )));
      } else if (response.statusCode == 401) {
        const title = "Invalid Verification Code!";
        const content =
            "Verification Code is incorrect or has expired, please request a new one!";

        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        showUIDialog(
          context,
          title,
          content,
        );

        // don't reset---->  because the user will try again:
        //resetState.updateVerificationCode("000000");
        //resetState.updateResetedToken("");
        //verificationState.updateBoolfirstOnComplete(false);
        //verificationState.updateBoolsecondOnComplete(false);
        //verificationState.updateBoolisFilled(false);
        verificationState.updateBoolisSending(false);
      } else {
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        const title = 'Something Went Wrong!';
        const content = "Please check your input and try again later.";
        showUIDialog(
          context,
          title,
          content,
        );
        debugPrint('failed');
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());

        resetState.updateVerificationCode("000000");
        resetState.updateResetedToken("");

        verificationState.updateBoolisFilled(false);
        verificationState.updateBoolisSending(false);
        verificationState.updateBoolfirstOnComplete(false);
        verificationState.updateBoolsecondOnComplete(false);
      }
    } catch (error) {
      debugPrint(error.toString());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication failed.$error'),
        ),
      );

      verificationState.updateBoolisSending(false);
    }
  }

  void onPressFlatButton(ResetScenarioState resetState) {
    code6Digits =
        verificationState.first3digits + verificationState.second3digits;
    resetState.updateVerificationCode(code6Digits);
    // update is to show circle progress during fetching data from API requestes
    verificationState.updateBoolisSending(true);
    _submit();
    verificationState.updateBoolisSending(false);
  }

   void onPress() {
      verificationState.updateBoolfirstOnComplete(false);
      verificationState.updateBoolsecondOnComplete(false);
      verificationState.updateBoolfirstOnEditing(true);
      verificationState.updateBoolsecondOnEditing(true);
      verificationState.updateBoolisFilled(false);

      resetState.updateBoolIsResendCode(true);

      widget.resendCode(context: context);

      resetState.updateBoolIsResendCode(false);
    }

  @override
  Widget build(BuildContext context) {
    final resetedPhone = resetState.resetedPhone;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onPressBack,
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Consumer<VarificationCodeProviderState>(
            builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: kScreenHeight * .5,
                width: kScreenWidth * .9,
                child: Stack(
                  children: [
                    Positioned(
                      top: kScreenHeight * 0.095,
                      left: kScreenWidth * 0.21,
                      height: kScreenHeight * 0.15,
                      width: kScreenWidth * 0.5,
                      child: Image.asset('assets/images/verify_code.png'),
                    ),
                    Positioned(
                      top: kScreenHeight * 0.26,
                      left: kScreenWidth * 0.39,
                      height: kScreenHeight * 0.08,
                      width: kScreenWidth * 0.75,
                      child: const Text(
                        "Code",
                        style: TextStyle(
                            color: kBlack,
                            fontFamily: 'Jost',
                            fontSize: 27,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Positioned(
                      top: kScreenHeight * 0.335,
                      left: kScreenWidth * 0.09,
                      //right: screenWidth * 0.001,
                      height: kScreenHeight * 0.09,
                      width: kScreenWidth * 0.75,
                      child: const Text(
                        "We have sent the code to create Your account to mobile number",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kBlack,
                            fontFamily: 'Jost',
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Positioned(
                      top: kScreenHeight * 0.44,
                      left: kScreenWidth * 0.27,
                      height: kScreenHeight * 0.08,
                      width: kScreenWidth * 0.75,
                      child: Text(
                        '+$resetedPhone',
                        style: const TextStyle(
                            color: kBlack,
                            fontFamily: 'Jost',
                            fontSize: 24,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: kScreenHeight * 0.03,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: kScreenWidth * 0.01,
                  ),
                  //another solution:
                  // PinCodeTextField(
                  //   length: 6,
                  // ),
                  VerificationCode(
                    textStyle: const TextStyle(fontSize: 24.0, color: kOrange),
                    keyboardType: TextInputType.number,
                    fullBorder: true,
                    underlineColor: kDarkCyan,
                    length: 3,
                    cursorColor: kBlue,
                    clearAll: Padding(
                      padding: EdgeInsets.all(kScreenWidth * 0.008),
                    ),
                    onCompleted: (String value) {
                      verificationState.updateFirst3digits(value);
                      verificationState.updateBoolfirstOnComplete(true);

                      verificationState.updateBoolisFilled(
                          provider.firstOnComplete &&
                              provider.secondOnComplete);
                    },
                    onEditing: (bool value) {
                      verificationState.updateBoolfirstOnEditing(value);

                      if (!provider.firstOnEditing) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),

                  // second 3 digits
                  VerificationCode(
                    textStyle: const TextStyle(fontSize: 24.0, color: kOrange),
                    keyboardType: TextInputType.number,
                    fullBorder: true,
                    underlineColor: kDarkCyan,
                    length: 3,
                    cursorColor: kBlue,
                    clearAll: Padding(
                      padding: EdgeInsets.all(kScreenWidth * 0.008),
                    ),
                    onCompleted: (String value) {
                      verificationState.updateSecond3digits(value);
                      verificationState.updateBoolsecondOnComplete(true);

                      verificationState.updateBoolisFilled(
                          provider.firstOnComplete &&
                              provider.secondOnComplete);
                    },
                    onEditing: (bool value) {
                      verificationState.updateBoolsecondOnEditing(value);
                      if (!provider.secondOnEditing) {
                        FocusScope.of(context).unfocus();
                      }
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    kScreenWidth * 0.3, 0, kScreenWidth * 0.3, 0),
                child: TextButton(
                  onPressed: onPress,
                  child: provider.isSending
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Resend code',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: kGreyVerifyCode),
                        ),
                ),
              ),
              SizedBox(
                height: kScreenHeight * 0.1,
                child: provider.isSending
                    ? const CircularProgressIndicator()
                    : const Text(
                        "54s",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Jost',
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    kScreenWidth * 0.05, 0, kScreenWidth * 0.04, 0),
                child: provider.isSending
                    ? const CircularProgressIndicator()
                    : Selector<VarificationCodeProviderState, bool>(
                        selector: (_, provider) => provider.isFilled,
                        builder: (context, isFilled, child) {
                          return FlatButton(
                            condition: isFilled,
                            onPressedFunction: () {
                              onPressFlatButton(resetState);
                            },
                            activatedData: 'Next',
                            deactivedData: 'Next',
                          );
                        },
                      ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
