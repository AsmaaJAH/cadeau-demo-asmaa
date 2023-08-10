import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:asmaa_demo_cadeau/functions/get_device_info.dart';
import 'package:asmaa_demo_cadeau/provider/product_screen_provider.dart';
import 'package:asmaa_demo_cadeau/constants/global_api_variables.dart';
import 'package:asmaa_demo_cadeau/provider/login_provider.dart';

Map productItem = {};

Future<Map> showSingleProductDetails({
  required BuildContext context,
  required int productID,
}) async {
  final singleProdustState = context.read<SingleProductState>();

  final url = Uri.parse('$kBaseURL/$kVersion/products/$productID');
  final String token = context.read<LoginTokenState>().loginToken;
  determineTimeZone();
  try {
    Response response = await get(
      url,
      headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
        'Authorization': token,
        'Timezone': kTimeZone,
      },
    );

    if (response.statusCode == 200) {
      debugPrint('one product details has been uploaded successfully');

      final Map<String, dynamic> resultData = json.decode(response.body);

      productItem = resultData['data']['product'];

      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return {};
      }

      singleProdustState.updateProductDetails(productItem);

      //end the movement of the circle progress insicator
      singleProdustState.updateBoolIsConnecting(false);
    } else {
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return {};
      }
      singleProdustState.updateBoolIsConnecting(false);
      singleProdustState.updateBoolIsFailed(true);

      debugPrint('failed');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
    }
  } catch (error) {
    debugPrint(error.toString());

    // ignore: use_build_context_synchronously
    if (!context.mounted) {
      return {};
    }
    singleProdustState.updateBoolIsConnecting(false);
    singleProdustState.updateBoolIsFailed(true);
  }
  return productItem;
}
