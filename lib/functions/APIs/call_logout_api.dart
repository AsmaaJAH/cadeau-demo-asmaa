import 'package:asmaa_demo_cadeau/functions/animate_logout.dart';
import 'package:asmaa_demo_cadeau/models/shared_prefrences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:asmaa_demo_cadeau/functions/get_device_info.dart';
import 'package:asmaa_demo_cadeau/constants/global_api_variables.dart';
import 'package:asmaa_demo_cadeau/provider/login_token.dart';

void logout({required BuildContext context}) async {
  var loginTokenState = context.read<LoginTokenState>();
  final url = Uri.parse('$kBaseURL/$kVersion/auth/logout');
  final String token = loginTokenState.loginToken;
  determineTimeZone();
  determineLanguage();
  try {
    Response response = await delete(
      url,
      headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        //'Connection': 'keep-alive',
        'Content-Type': 'application/json',
        'Authorization': token,
        'Timezone': kTimeZone,
        'Accept-Language': kMostFavouriteUserLanguage,
      },
    );

    if (response.statusCode == 200) {
      debugPrint('u have logged out successfully');

      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }

      //reset acssess token   :
      loginTokenState.updateLoginToken("");
      await SharedPref.clearSharedPref();

      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }

      //navigator with push and remove from stack
      animateLogout(context);
    } else {
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }

      debugPrint('failed');

      debugPrint(response.statusCode.toString());
      debugPrint(response.body);

      //log out the user manually here :
      loginTokenState.updateLoginToken("");
      await SharedPref.clearSharedPref();
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return;
      }
      animateLogout(context);
    }
  } catch (error) {
    debugPrint(error.toString());

    // ignore: use_build_context_synchronously
    if (!context.mounted) {
      return;
    }

    //log out the user manually here :
    loginTokenState.updateLoginToken("");
    await SharedPref.clearSharedPref();

    // ignore: use_build_context_synchronously
    if (!context.mounted) {
      return;
    }
    animateLogout(context);
  }
}
