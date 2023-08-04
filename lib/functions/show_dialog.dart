import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showUIDialog(BuildContext context, String title, String content) {
  if (Platform.isIOS) {
    showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text("OK"),
                ),
              ],
            ));
  } else {
    //android device and so on
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
