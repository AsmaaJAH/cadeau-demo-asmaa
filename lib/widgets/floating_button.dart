import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    super.key,
    required this.textColor,
    required this.data,
    required this.width,
    required this.backgroundColor,
    required this.borderColor,
  });
  final Color textColor;
  final String data;
  final double width;

  final Color backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    //flat button is now text button in flutter
    return SizedBox(
      height: kScreenHeight * 0.05,
      child: TextButton(
        onPressed: null,
        style: TextButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          minimumSize: Size.fromWidth(width),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          data,
          style: TextStyle(
              color: textColor,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              fontFamily: 'Jost'),
        ),
      ),
    );
  }
}
