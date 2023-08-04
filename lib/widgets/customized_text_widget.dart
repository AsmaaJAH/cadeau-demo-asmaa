import 'package:flutter/material.dart';

class CustomizedTextWidget extends StatelessWidget {
  const CustomizedTextWidget({
    super.key,
    required this.fontWeight,
    required this.fontSize,
    required this.data,
    required this.color,
    this.textDecor,
    this.textAlign = TextAlign.center,
    this.maxLines = 20,
  });
  final TextDecoration? textDecor;

  final TextAlign textAlign;
  final FontWeight fontWeight;
  final double fontSize;
  final String data;
  final Color color;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      maxLines: maxLines,
      softWrap: true,

      overflow: TextOverflow.ellipsis, // Very long text ...
      textAlign: textAlign,
      style: TextStyle(
        decoration: textDecor,
        fontFamily: 'Jost',
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
