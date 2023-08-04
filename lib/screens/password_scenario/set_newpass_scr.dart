import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/global_api_variables.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/functions/get_device_info.dart';
import 'package:asmaa_demo_cadeau/functions/show_dialog.dart';
import 'package:asmaa_demo_cadeau/provider/bonus_task_provider.dart';
import 'package:asmaa_demo_cadeau/provider/fill_provider.dart';
import 'package:asmaa_demo_cadeau/provider/passward_provider.dart';
import 'package:asmaa_demo_cadeau/provider/reset_scenario_provider.dart';
import 'package:asmaa_demo_cadeau/screens/login.dart';
import 'package:asmaa_demo_cadeau/screens/password_scenario/verify_code_scr.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:asmaa_demo_cadeau/widgets/pass_scenario/page_begining_interface.dart';
import 'package:asmaa_demo_cadeau/widgets/flat_button.dart';
import 'package:asmaa_demo_cadeau/widgets/pass_scenario/pass_checker.dart';
import 'package:asmaa_demo_cadeau/widgets/sub_forms/password_form.dart';

class SetNewPasswardScreen extends StatefulWidget {
  const SetNewPasswardScreen({super.key, required this.resendCode});
  final void Function(
      {required bool isResendCode, required BuildContext context}) resendCode;

  @override
  State<SetNewPasswardScreen> createState() => _SetNewPasswardScreenState();
}

class _SetNewPasswardScreenState extends State<SetNewPasswardScreen> {
  final _formKey = GlobalKey<FormState>();
  var lengthChecker = false;
  var contentChecker = false;
  var isSending = false;
  var isFilling = false;

  void _submit() async {
    determineLanguage();
    var fillingState = context.read<FillingState>();

    var resetScenarioState = context.read<ResetScenarioState>();
    var enteredPasswordState = context.read<EnteredPasswordState>();
    var resetedPhone = resetScenarioState.resetedPhone;
    var resetedCountryCode = resetScenarioState.resetedCountryCode;
    var enteredPassward = enteredPasswordState.enteredPassword;
    var enteredPasswardConfirmation = enteredPasswordState.confirmedPassword;

    final String token = resetScenarioState.resetedPassToken;
    debugPrint(
        '$resetedCountryCode , $enteredPassward  , $resetedPhone ,token: $token');

    final url = Uri.parse(
        '$kBaseURL/$kVersion/auth/passwords/${kQueryParameters['user_type']}/reset_password');

    try {
      Response response = await post(url,
          headers: {
            //-------------- default headers ------------------
            //  'Accept': '*/*',
            //  'Accept-Encoding':'gzip, deflate, br',
            // 'Connection':'keep-alive',
            // 'User-Agent': 'PostmanRuntime/7.32.3',
            //------------------------------------------------
            'Content-Type': 'application/json',
            'Accept-Language': kMostFavouriteUserLanguage,
            'Timezone': kTimeZone,
            'verification-token': token,
          },
          body: json.encode({
            "user": {
              "country_code": resetedCountryCode,
              "phone_number": resetedPhone,
              "password": enteredPassward,
              "password_confirmation": enteredPasswardConfirmation
            },
            "device": {
              "device_type": kDeviceType, //"android" , "ios" , "web", "unknown"
              "fcm_token": kFcmToken,
            }
          }));

      if (response.statusCode == 200) {
        debugPrint('You have setted a new passwored successfully');

        // ignore: unused_local_variable
        final Map<String, dynamic> resultData = json.decode(response.body);

        //reset the form or make it empty again
        setState(() {
          resetScenarioState.updateResetedCountryCode("+20");
          resetScenarioState.updateResetedPhone("");
          enteredPasswordState.updateConfirmedPassword("");
          enteredPasswordState.updateEnteredPassword("");

          fillingState.updateBoolFilledPassword(false);
          fillingState.updateBoolFilledConfirmationPassword(false);

          enteredPasswordState.updateBoolAuthenticating(false);
          isSending = false;

          isFilling = false;
          _formKey.currentState!.reset();
        });
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        //message in the UI
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your New password setted successfully'),
          ),
        );
        //Navigate user to log in:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LogInScreen()));
      } else if (response.statusCode == 401) {
        const title = " Invalid Token!";
        const content =
            "You are not authorized to do this yet, \n You Cannot change password if you didn't verify your account after signing up,\n please sign up to request a new verification code!";
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        showUIDialog(
          context,
          title,
          content,
        );

        // reset---->  to be empty again
        setState(() {
          resetScenarioState.updateResetedPhone("");

          resetScenarioState.updateResetedCountryCode("+20");
          enteredPasswordState.updateEnteredPassword("");

          enteredPasswordState.updateConfirmedPassword("");

          //delete instead of unallocate space from the user device memory
          resetScenarioState.updateResetedToken("");
          isSending = false;
          isFilling = false;
        });
      } else {
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        const title = 'Failed To Set New Passward';
        const content = "Please check your input and try again later";
        showUIDialog(
          context,
          title,
          content,
        );
        debugPrint('failed');
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        setState(() {
          isSending = false;
        });
      }
    } catch (error) {
      debugPrint(error.toString());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Setting New password failed: $error'),
        ),
      );
      setState(() {
        isSending = false;
      });
    }
  }

  void _onPressFlatButton() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // update is to show circle progress during fetching data from API requestes
      setState(() {
        isSending = true;
      });

      _submit();

      isSending = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var fillingState = context.read<FillingState>();
    var bonusCheckerState = context.watch<BonusCheckerState>();

    isFilling = fillingState.isfilledPassword &&
        fillingState.isfilledConfirmtionPassword;
    setState(() {
      lengthChecker = bonusCheckerState.isLengthChecked;
      contentChecker = bonusCheckerState.isContentChecked;
    });
    void onPressIcon() {
      var bonusState = context.read<BonusCheckerState>();

      setState(() {
        fillingState.updateBoolFilledPassword(false);

        fillingState.updateBoolFilledConfirmationPassword(false);
        isFilling = false;
        //reset the bonus Flags:
        bonusState.updateBoolContentChecked(false);
        bonusState.updateBoolLengthChecked(false);
      });

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VerificationCodeScreen(
                resendCode: widget.resendCode,
              )));
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: onPressIcon,
            icon: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: kScreenHeight * .3,
              width: kScreenWidth * .8,
              child: const Stack(
                children: [
                  BeginigInterfaceWidget(
                      image: 'Group.png', pageTitle: 'Set New Password'),
                ],
              ),
            ),
            SizedBox(
              height: kScreenHeight * 0.0005,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              color: kWhite,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const PasswordForm(
                            isSettingNewPass: true,
                            label: 'New Password',
                            hint: 'Enter at least 8 characters',
                            isConfirmingPassword: false,
                          ),
                          SizedBox(
                            height: kScreenHeight * 0.019,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomizedTextWidget(
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  data: 'Your password Must have :',
                                  color: kBlack),
                              SizedBox(
                                height: kScreenHeight * 0.01,
                              ),
                              PassValidatorElement(
                                validator: '8 to 20 Characters',
                                checked: lengthChecker,
                              ),
                              SizedBox(
                                height: kScreenHeight * 0.01,
                              ),
                              PassValidatorElement(
                                validator:
                                    'Letters , numbers and special characters',
                                checked: contentChecker,
                              ),
                            ],
                          ),
                          const PasswordForm(
                            isSettingNewPass: true,
                            label: 'New Password',
                            hint: 'Enter at least 8 characters',
                            isConfirmingPassword: true,
                          ),
                          const SizedBox(height: 38),
                          if (isSending)
                            const SizedBox(
                                height: 5, child: CircularProgressIndicator()),
                          if (!isSending)
                            FlatButton(
                              condition: isFilling,
                              onPressedFunction: _onPressFlatButton,
                              deactivedData: 'Next',
                              activatedData: 'Done',
                            ),
                        ]),
                  ),
                ),
              ),
            ),
          ],
        )));
  }
}
