import 'dart:async';

import 'package:asmaa_demo_cadeau/models/shared_prefrences.dart';
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
        child: Image.asset("assets/images/Cadeau logo.png"),
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const PresistTabView();
      }));
    } else {
      //  ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const LogInScreen();
      }));
    }
  }
}
