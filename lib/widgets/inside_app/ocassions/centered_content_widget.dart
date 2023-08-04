import 'package:asmaa_demo_cadeau/constants/colors.dart';
import 'package:asmaa_demo_cadeau/constants/screen_dimensions.dart';
import 'package:asmaa_demo_cadeau/widgets/customized_text_widget.dart';
import 'package:flutter/material.dart';

class CenteredtextContent extends StatelessWidget {
  const CenteredtextContent({
    super.key,
    required this.text,
    required this.title,
  });
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.fromLTRB(kScreenWidth * 0.1, kScreenWidth * 0.05,
            kScreenWidth * 0.05, kScreenWidth * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomizedTextWidget(
              textAlign: TextAlign.start,
              data: title,
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: kOrange,
            ),
            const SizedBox(height: 20),
            CustomizedTextWidget(
              textAlign: TextAlign.start,
              data: text,
              fontSize: 22,
              fontWeight: FontWeight.normal,
              color: kBlack,
            ),
          ],
        ),
      ),
    );
  }
}
