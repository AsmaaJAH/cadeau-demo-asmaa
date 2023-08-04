import 'dart:convert';
import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/models/shared_prefrences.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/constants/global_api_variables.dart';
import 'package:asmaa_demo_cadeau/provider/login_token.dart';
import 'package:asmaa_demo_cadeau/screens/presist_tab_view.dart';
import 'package:asmaa_demo_cadeau/functions/get_device_info.dart';
import 'package:asmaa_demo_cadeau/functions/show_dialog.dart';
import 'package:asmaa_demo_cadeau/provider/fill_provider.dart';
import 'package:asmaa_demo_cadeau/provider/passward_provider.dart';
import 'package:asmaa_demo_cadeau/provider/phone_provider.dart';
import 'package:asmaa_demo_cadeau/screens/password_scenario/forget_pass_scr.dart';
import 'package:asmaa_demo_cadeau/widgets/flat_button.dart';
import 'package:asmaa_demo_cadeau/widgets/sub_forms/password_form.dart';
import 'package:asmaa_demo_cadeau/widgets/sub_forms/phone_form.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() {
    return _LogInScreenState();
  }
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  var isfilledPhone = false;
  var isfilledPassward = false;
  var isFilling = false;
  var isAuthenticating = false;

  void _submit() async {
    determineLanguage();
    var passState = context.read<EnteredPasswordState>();
    var phoneState = context.read<EnteredPhoneState>();
    var fillState = context.read<FillingState>();
    var enteredPassward = passState.enteredPassword;
    var enteredCountryCode = phoneState.enteredCountryCode;
    var enteredPhone = phoneState.enteredPhone;

    debugPrint(enteredCountryCode + enteredPassward + enteredPhone);

    final url = Uri.parse(
        '$kBaseURL/$kVersion/auth/${kQueryParameters['user_type']}/login');

    try {
      Response response = await post(url,
          headers: {
            //-------------- default headers ------------------
            'Accept': '*/*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            // 'User-Agent': 'PostmanRuntime/7.32.3',
            //------------------------------------------------
            'Content-Type': 'application/json',
            'Accept-Language': kMostFavouriteUserLanguage,
            'Timezone': kTimeZone,
          },
          body: json.encode({
            "user": {
              "country_code": enteredCountryCode,
              "phone_number": enteredPhone,
              "password": enteredPassward,
            },
            "device": {
              "device_type": kDeviceType, //"android" , "ios" , "web", "unknown"
              "fcm_token": "dummy",
            }
          }));

      if (response.statusCode == 200) {
        debugPrint('Login successfully');

        // ignore: unused_local_variable
        final Map<String, dynamic> resultData = json.decode(response.body);

        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }

        context
            .read<LoginTokenState>()
            .updateLoginToken(resultData['data']['extra']['access_token']);
        await SharedPref.setString(resultData['data']['extra']['access_token']);
        await SharedPref.setTrueBool();

        //reset the form or make it empty again
        setState(() {
          passState.updateEnteredPassword("");
          phoneState.updateCountryCode("+20");
          phoneState.updateEnteredPhone("");

          fillState.updateBoolFilledPhone(false);
          fillState.updateBoolFilledPassword(false);
          passState.updateBoolAuthenticating(false);
          isAuthenticating = false;
          isfilledPhone = false;
          isfilledPassward = false;
          isFilling = isfilledPassward && isfilledPhone;
          _formKey.currentState!.reset();
        });
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return const PresistTabView();
        }));
      } else {
        // ignore: use_build_context_synchronously
        if (!context.mounted) {
          return;
        }
        const title = 'Failed To LogIn';
        const content =
            "Please check your input passward or phone and try again";
        showUIDialog(
          context,
          title,
          content,
        );
        debugPrint('failed');
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        setState(() {
          passState.updateBoolAuthenticating(false);
          isAuthenticating = false;
        });
      }
    } catch (error) {
      debugPrint(error.toString());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Authentication failed.$error'),
        ),
      );
      setState(() {
        passState.updateBoolAuthenticating(false);
        isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var passState = context.read<EnteredPasswordState>();
    var phoneState = context.read<EnteredPhoneState>();
    var fillState = context.read<FillingState>();
    isAuthenticating = passState.isAuthenticating;
    isfilledPhone = context.watch<FillingState>().isfilledPhone;
    isfilledPassward = context.watch<FillingState>().isfilledPassword;
    isFilling = isfilledPassward && isfilledPhone;
    void onPressFlatButton() {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // update isAuthintication to show circle progress during fetching data from API requestes
        setState(() {
          passState.updateBoolAuthenticating(true);
        });
        _submit();
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: kScreenHeight * .25,
              width: kScreenWidth * .6,
              child: Stack(
                children: [
                  Positioned(
                    top: kScreenHeight * 0.03,
                    left: kScreenWidth * 0.085,
                    height: kScreenHeight * 0.1,
                    width: kScreenWidth * 0.37,
                    child: Image.asset('assets/images/Group 15 10 log in.png'),
                  ),
                  Positioned(
                    top: kScreenHeight * 0.16,
                    right: kScreenWidth * 0.001,
                    height: kScreenHeight * 0.09,
                    width: kScreenWidth * 0.65,
                    child: const Column(
                      children: [
                        CustomizedTextWidget(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            data: "Welcome back",
                            color: kBlack),
                        CustomizedTextWidget(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            data: "log in",
                            color: kGreyLogIn),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              margin: const EdgeInsets.all(20),
              color: const Color.fromARGB(250, 250, 250, 250),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const PhoneForm(
                      hint: "0124145891",
                    ),
                    const PasswordForm(
                      isSettingNewPass: false,
                      label: 'Password',
                      hint: 'Enter your password here',
                      isConfirmingPassword: false,
                    ),
                    const SizedBox(height: 38),
                    if (isAuthenticating)
                      const SizedBox(
                          height: 5, child: CircularProgressIndicator()),
                    if (!isAuthenticating)
                      FlatButton(
                        condition: isFilling,
                        onPressedFunction: () {
                          onPressFlatButton();
                        },
                        activatedData: 'Log In',
                        deactivedData: 'Log In',
                      ),
                    if (isAuthenticating)
                      const SizedBox(
                          height: 5, child: CircularProgressIndicator()),
                    if (!isAuthenticating)
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                //empty current form and navigate to forget pass screen
                                setState(() {
                                  passState.updateEnteredPassword("");
                                  phoneState.updateCountryCode("+20");
                                  phoneState.updateEnteredPhone("");

                                  fillState.updateBoolFilledPhone(false);
                                  fillState.updateBoolFilledPassword(false);

                                  _formKey.currentState!.reset();
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswardScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Forget password ?',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
