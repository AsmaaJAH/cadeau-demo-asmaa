import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:asmaa_demo_cadeau/provider/ocassions_provider.dart';
import 'package:asmaa_demo_cadeau/constants/global_api_variables.dart';
import 'package:asmaa_demo_cadeau/models/ocassions.dart';
import 'package:asmaa_demo_cadeau/provider/login_token.dart';

List<dynamic> newProducts = [];

Future<List<dynamic>> callShowSingleOcassionAPI(
    {required BuildContext context,
    required int ocassionID,
    required int pageKey,
    required int pageSize}) async {
  var ocassionsState = context.read<OcassionsState>();
  final url = Uri.parse(
      '$kBaseURL/$kVersion/products?occasion_type_id=$ocassionID&page_number=$pageKey');
  final String token = context.read<LoginTokenState>().loginToken;

  try {
    Response response = await get(
      url,
      headers: {
        'Accept': '*/*',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      debugPrint('your single ocassion products uploaded successfully');

      final Map<String, dynamic> resultData = json.decode(response.body);
      OcassionListResponseBody productsResponseBody = OcassionListResponseBody(
        data: resultData['data'],
        extra: resultData['extra'],
      );

      newProducts = resultData['data']['products'];

      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return [];
      }

      ocassionsState.updateProductsResponseBody(productsResponseBody);
      ocassionsState.updateNewProductsList(newProducts);

      //end the movement of the circle progress insicator
      // ocassionsState.updateBoolIsConnecting(false);
    } else {
      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return [];
      }
      // ocassionsState.updateBoolIsConnecting(false);
      // ocassionsState.updateBoolIsFailed(true);

      debugPrint('failed');
      debugPrint(response.statusCode.toString());
      debugPrint(response.body);
    }
  } catch (error) {
    debugPrint(error.toString());

    // ignore: use_build_context_synchronously
    if (!context.mounted) {
      return [];
    }
    // ocassionsState.updateBoolIsConnecting(false);
    // ocassionsState.updateBoolIsFailed(true);
  }
  return newProducts;
}
