import 'dart:async';

import 'package:asmaa_demo_cadeau/models/shared_pref.dart';
import 'package:asmaa_demo_cadeau/screens/login.dart';
import 'package:asmaa_demo_cadeau/screens/presist_tab_view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Image.asset("assets/images/cadeau_logo.png"),
      ),
    );
  }

  void startTimer() {
    Timer(const Duration(milliseconds: 2500), () {
      navigateUser(); //It will redirect  after 2.5 seconds
    });
  }

  void navigateUser() async {
    var isLoggedInStatus = await SharedPref.getBool();
    debugPrint(isLoggedInStatus.toString());
    if (isLoggedInStatus) {
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const PresistTabView();
      }));

      //pop splash screen from stack:
      // Navigator.of(context).pushReplacement()-----> instead of push();
      // There should be no back button on the screen that comes after the splash screen
      // (App back button or the device back button),
      // we should remove the splash screen from the
      //stack after pushing to a new screen from it.
    } else {
      //  ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return const LogInScreen();
      }));
      //pop splash screen from stack:
      // Navigator.of(context).pushReplacement()-----> instead of push();
      // There should be no back button on the screen that comes after the splash screen
      // (App back button or the device back button),
      // we should remove the splash screen from the
      //stack after pushing to a new screen from it.
    }
  }
}
