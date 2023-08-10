import 'package:asmaa_demo_cadeau/provider/bonus_task_provider.dart';
import 'package:asmaa_demo_cadeau/provider/varification_code_provider.dart';
import 'package:asmaa_demo_cadeau/screens/splash.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/provider/phone_form_provider.dart';
import 'package:asmaa_demo_cadeau/provider/fill_provider.dart';
import 'package:asmaa_demo_cadeau/provider/password_form_provider.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/provider/login_provider.dart';
import 'package:asmaa_demo_cadeau/provider/occasions_list_provider.dart';
import 'package:asmaa_demo_cadeau/provider/password_scenario_provider.dart';
import 'package:asmaa_demo_cadeau/provider/product_screen_provider.dart';

void main() async {
//prevent the response of setting the landscape mode
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EnteredPhoneState()),
        ChangeNotifierProvider(create: (_) => FillingState()),
        ChangeNotifierProvider(create: (_) => EnteredPasswordState()),
        ChangeNotifierProvider(create: (_) => ResetScenarioState()),
        ChangeNotifierProvider(create: (_) => LoginTokenState()),
        ChangeNotifierProvider(create: (_) => OcassionsState()),
        ChangeNotifierProvider(create: (_) => SingleProductState()),
        ChangeNotifierProvider(create: (_) => BonusCheckerState()),
        ChangeNotifierProvider(create: (_) => VarificationCodeProviderState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    knowScreenWidth(context);
    knowScreenHeight(context);
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Asmaa Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kWhite),
          useMaterial3: true,
          fontFamily: 'Jost',
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
