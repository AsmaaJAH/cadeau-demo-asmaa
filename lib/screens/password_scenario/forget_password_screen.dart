import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/global_api_variables.dart';
import 'package:asmaa_demo_cadeau/functions/get_device_info.dart';
import 'package:asmaa_demo_cadeau/functions/show_dialog.dart';
import 'package:asmaa_demo_cadeau/provider/fill_provider.dart';
import 'package:asmaa_demo_cadeau/provider/phone_form_provider.dart';
import 'package:asmaa_demo_cadeau/provider/password_scenario_provider.dart';
import 'package:asmaa_demo_cadeau/screens/password_scenario/verification_code_screen.dart';
import 'package:asmaa_demo_cadeau/widgets/pass_scenario/page_begining_interface.dart';
import 'package:asmaa_demo_cadeau/widgets/flat_button.dart';
import 'package:asmaa_demo_cadeau/widgets/sub_forms/phone_form.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/screens/login.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late FillingState fillingState;
  late EnteredPhoneState enteredPhoneState;
  late ResetScenarioState resetScenarioState;

  @override
  void initState() {
    super.initState();
    fillingState = context.read<FillingState>();
    enteredPhoneState = context.read<EnteredPhoneState>();
    resetScenarioState = context.read<ResetScenarioState>();
  }

  void _onPressIcon(BuildContext context) {
    fillingState.updateBoolFilledPhone(false);

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LogInScreen()));
  }

  void _onPressNext(BuildContext context, EnteredPhoneState enteredPhoneState) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // update is to show circle progress during fetching data from API requestes
      enteredPhoneState.updateBoolSending(true);

      _submit(context: context);
      enteredPhoneState.updateBoolSending(false);
    }
  }

  void _submit({required BuildContext context}) async {
    var enteredCountryCode = enteredPhoneState.enteredCountryCode;
    var enteredPhone = enteredPhoneState.enteredPhone;
    if (resetScenarioState.isResendCode) {
      enteredCountryCode = resetScenarioState.resetedCountryCode;
      enteredPhone = resetScenarioState.resetedPhone;
    }

    final url = Uri.parse(
        '$kBaseURL/$kVersion/auth/passwords/${kQueryParameters['user_type']}/send_reset_password_info');

    try {
      Response response = await post(url,
          headers: {
            'Content-Type': 'application/json',
            'Accept-Language': kMostFavouriteUserLanguage,
            'Timezone': kTimeZone,
          },
          body: json.encode({
            "user": {
              "country_code": enteredCountryCode,
              "phone_number": enteredPhone,
            },
          }));

      if (response.statusCode == 200) {
        debugPrint('Account Detected Successfully');

        // ignore: unused_local_variable
        final Map<String, dynamic> resultData = json.decode(response.body);
        // debugPrint("response.body      response.body       response.body     response.body ");
        debugPrint(response.body);
        debugPrint(resultData.toString());
        debugPrint(
            resultData['data']['reset_password_token'].runtimeType.toString());
        debugPrint(resultData['data']['reset_password_token']);

        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        // //save the phone in a provider for using in the comming steps
        resetScenarioState.updateResetedPhone(enteredPhone);
        resetScenarioState.updateResetedCountryCode(enteredCountryCode);
        resetScenarioState
            .updateVerificationCode(resultData['data']['reset_password_token']);

        //reset the form or make it empty again
        enteredPhoneState.updateCountryCode("+20");
        enteredPhoneState.updateEnteredPhone("");
        fillingState.updateBoolFilledPhone(false);
        enteredPhoneState.updateBoolSending(false);
        setState(() {
          _formKey.currentState!.reset();
        });

        if (!resetScenarioState.isResendCode) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => VerificationCodeScreen(
                    resendCode: _submit,
                  )));
        }
      } else if (response.statusCode == 404) {
        const title = "Account Not Found";
        const content =
            "No account is assosiated with this country code and phone num! \n Please check your input and try again";

        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        showUIDialog(
          context,
          title,
          content,
        );

        // ya Asmaa please don't reset the form here again
        //because the user may try again and complete his entered data withe the current form state
        enteredPhoneState.updateBoolSending(false);
      } else {
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        const title = 'Something Went Wrong!';
        const content = "Please check your input data and try again later.";
        showUIDialog(
          context,
          title,
          content,
        );
        debugPrint('failed');
        debugPrint(response.statusCode.toString());
        debugPrint(response.body.toString());

        enteredPhoneState.updateBoolSending(false);
      }
    } catch (error) {
      debugPrint(error.toString());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication failed.$error'),
        ),
      );
      enteredPhoneState.updateBoolSending(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _onPressIcon(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: kScreenHeight * .3,
              width: kScreenWidth * .8,
              child: Stack(
                children: [
                  const PageBeginingInterfaceWidget(
                      image: 'group.png', pageTitle: "Forget password"),
                  Positioned(
                    top: kScreenHeight * 0.215,
                    left: kScreenWidth * 0.04,
                    //right: screenWidth * 0.001,
                    height: kScreenHeight * 0.09,
                    width: kScreenWidth * 0.75,
                    child: const Text(
                      "Enter phone number to receive \n code on it",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kGreyForgetPass,
                          fontFamily: 'Jost',
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: kScreenHeight * 0.05,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              color: const Color.fromARGB(250, 250, 250, 250),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Selector<EnteredPhoneState, bool>(
                        selector: (_, provider) => provider.isSending,
                        builder: (context, isSending, child) {
                          return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const PhoneForm(
                                  hint: "EX : 0124145891",
                                ),
                                const SizedBox(height: 38),
                                if (isSending)
                                  const SizedBox(
                                      height: 5,
                                      child: CircularProgressIndicator()),
                                if (!isSending)
                                  Selector<FillingState, bool>(
                                      selector: (_, provider) =>
                                          provider.isfilledPhone,
                                      builder: (context, isFilledPhone, child) {
                                        return FlatButton(
                                          condition: isFilledPhone,
                                          onPressedFunction: () {
                                            _onPressNext(
                                                context, enteredPhoneState);
                                          },
                                          activatedData: 'Next',
                                          deactivedData: 'Next',
                                        );
                                      }),
                              ]);
                        }),
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
