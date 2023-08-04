import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:asmaa_demo_cadeau/provider/ocassions_provider.dart';
import 'package:asmaa_demo_cadeau/constants/global_api_variables.dart';
import 'package:asmaa_demo_cadeau/models/ocassions.dart';
import 'package:asmaa_demo_cadeau/provider/login_token.dart';
import 'package:asmaa_demo_cadeau/widgets/inside_app/ocassions/centered_content_widget.dart';

OcassionListResponseBody? currentOcassions;
Widget kOccassionConstContent = const Text("Loading...");
List<dynamic> newItems = [];

Future<List<dynamic>> callOcassionsListGetAPI(
    {required BuildContext context,
    required int pageKey,
    required int pageSize}) async {
  var ocassionsState = context.read<OcassionsState>();
  final url = Uri.parse(
      '$kBaseURL/$kVersion/occasions?page_size=$pageSize&page_number=$pageKey');
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
      debugPrint('your list has been uploaded successfully');

      final Map<String, dynamic> resultData = json.decode(response.body);
      currentOcassions = OcassionListResponseBody(
        data: resultData['data'],
        extra: resultData['extra'],
      );

      newItems = resultData['data']['occasions'];

      // ignore: use_build_context_synchronously
      if (!context.mounted) {
        return [];
      }

      ocassionsState.updateOcassionsResponseBody(currentOcassions!);
      ocassionsState.updateNewOcassionsList(newItems);

      //end the movement of the circle progress insicator
      // ocassionsState.updateBoolIsConnecting(false);
    } else {
      kOccassionConstContent = const CenteredtextContent(
        title: 'Something went wrong!',
        text: "Failed To Load! Please try again later.",
      );
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
    kOccassionConstContent = const CenteredtextContent(
      title: 'Something went wrong!',
      text: "Failed To Load! Please try again later.",
    );

    // ignore: use_build_context_synchronously
    if (!context.mounted) {
      return [];
    }
    // ocassionsState.updateBoolIsConnecting(false);
    // ocassionsState.updateBoolIsFailed(true);
  }
  return newItems;
}
